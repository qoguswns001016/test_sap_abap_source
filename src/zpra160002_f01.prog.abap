*&---------------------------------------------------------------------*
*& Include          ZPRA160002_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .
  select a~matnr a~mtart a~matkl
         b~ekgrp b~mtvfp b~beskz
         c~maktx
  from mara as a INNER JOIN marc as b
    on a~matnr = b~matnr
    LEFT OUTER JOIN makt as c
    on a~matnr = c~matnr
    and c~spras = sy-langu
    where a~matnr in it_matnr
    and b~werks eq pi_werks
    and b~beskz in it_beskz
    into CORRESPONDING FIELDS OF TABLE gt_data.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form display_screen
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_screen .
  IF gcl_container IS NOT BOUND.
    CREATE OBJECT gcl_container
      EXPORTING
        repid     = sy-repid
        dynnr     = sy-dynnr
        side      = gcl_container->dock_at_left
        extension = 1500.
    CREATE OBJECT gcl_grid
      EXPORTING
        i_parent = gcl_container.
CALL METHOD gcl_grid->set_table_for_first_display
  EXPORTING
    is_variant                    = gs_variant
    i_save                        = 'A'
    i_default                     = 'X'
    is_layout                     = gs_layout
  CHANGING
    it_outtab                     = gt_data
    it_fieldcatalog               = gt_fcat.



  ENDIF.
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
    PERFORM set_fcat. "using:
*          'X' 'MATNR' '' 'MAST' 'MATNR',
*         'X' 'MAKTX' '' 'MATK' 'MAKTX',
*          'X' 'MATNR' '' 'MAST' 'MATNR',
*          'X' 'MATNR' '' 'MAST' 'MATNR',
*          'X' 'MATNR' '' 'MAST' 'MATNR',
*          'X' 'MATNR' '' 'MAST' 'MATNR',
*          'X' 'MATNR' '' 'MAST' 'MATNR',
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
   gs_fcat-fieldname = 'MATNR'.
   gs_fcat-coltext = 'MATNR'.
   APPEND gs_fcat to gt_fcat.

   clear gs_fcat.
   gs_fcat-fieldname = 'MAKTX'.
   gs_fcat-coltext = 'MAKTX'.
   APPEND gs_fcat to gt_fcat.

   clear gs_fcat.
   gs_fcat-fieldname = 'STLAN'.
   gs_fcat-coltext = 'STLAN'.
   append gs_fcat to gt_fcat.

   clear gs_fcat.
   gs_fcat-fieldname = 'STLNR'.
   gs_fcat-coltext = 'STLNR'.
   append gs_fcat to gt_fcat.

   clear gs_fcat.
   gs_fcat-fieldname = 'STLAL'.
   gs_fcat-coltext = 'STLAL'.
   append gs_fcat to gt_fcat.

   clear gs_fcat.
   gs_fcat-fieldname = 'MTART'.
   gs_fcat-coltext = 'MTART'.
   append gs_fcat to gt_fcat.

   clear gs_fcat.
   gs_fcat-fieldname = 'MATKL'.
   gs_fcat-coltext = 'MATKL'.
   append gs_fcat to gt_fcat.
ENDFORM.
