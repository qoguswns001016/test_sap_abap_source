*&---------------------------------------------------------------------*
*& Include          ZPR_A16_01_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form set_screen
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_screen .
  IF gcl_container IS NOT BOUND.
    CREATE OBJECT gcl_container
      EXPORTING
        repid     = sy-repid
        dynnr     = sy-dynnr
        side      = gcl_container->dock_at_left
        extension = 3000.
    CREATE OBJECT gcl_grid
      EXPORTING
        i_parent = gcl_container.
    CALL METHOD gcl_grid->set_table_for_first_display
      EXPORTING
        is_variant      = gs_variant
        i_save          = 'A'
        i_default       = 'X'
        is_layout       = gs_layout
      CHANGING
        it_outtab       = gt_data
        it_fieldcatalog = gt_fcat.

ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .
  select *
    from ztsa1601
    into TABLE gt_data
    where pernr = so_pernr.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_fcat_layout
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_fcat_layout .
  gs_layout-zebra      = 'X'.
  gs_layout-sel_mode   = 'D'.
  gs_layout-cwidth_opt = 'X'.

  IF gt_fcat is INITIAL.
    PERFORM set_fcat.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_fcat
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_fcat .
  clear gs_fcat.
   gs_fcat-fieldname = 'PERNR'.
   gs_fcat-coltext = 'PERNR'.
   gs_fcat-edit = 'X'.
   APPEND gs_fcat to gt_fcat.

   clear gs_fcat.
   gs_fcat-fieldname = 'ENAME'.
   gs_fcat-coltext = 'ENAME'.
   gs_fcat-edit = 'X'.
   APPEND gs_fcat to gt_fcat.

   clear gs_fcat.
   gs_fcat-fieldname = 'ENTDT'.
   gs_fcat-coltext = 'ENTDT'.
   gs_fcat-edit = 'X'.
   append gs_fcat to gt_fcat.

   clear gs_fcat.
   gs_fcat-fieldname = 'GENDER'.
   gs_fcat-coltext = 'GENDER'.
   gs_fcat-edit = 'X'.
   append gs_fcat to gt_fcat.

   clear gs_fcat.
   gs_fcat-fieldname = 'DEPNO'.
   gs_fcat-coltext = 'DEPNO'.
   gs_fcat-edit = 'X'.
   append gs_fcat to gt_fcat.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form create_row
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM create_row .
  clear gs_data.

  APPEND gs_data to gt_data.

  PERFORM refresh_grid.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form refresh_grid
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM refresh_grid .

  gs_stable-row = 'X'.
  gs_stable-col = 'X'.

  CALL METHOD gcl_grid->refresh_table_display
    EXPORTING
      is_stable      = gs_stable
      i_soft_refresh = space.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form save_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM save_data .

  DATA: lt_save TYPE TABLE of ztsa1601.

  REFRESH lt_save.

ENDFORM.
