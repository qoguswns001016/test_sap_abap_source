*&---------------------------------------------------------------------*
*& Include          ZBC405_A16_ALV_F01
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

  SELECT *
    FROM sflight
    INTO TABLE gt_fit
    WHERE carrid IN so_car AND
          connid IN so_con AND
          fldate IN so_dat.

  LOOP AT gt_fit into gs_fit.
    IF gs_fit-seatsocc < 5.
      gs_fit-light = 1. "RED
    ELSEIF gs_fit-seatsocc < 100.
      gs_fit-light = 2. "YElLOW
    ELSE.
      gs_fit-light = 3. "GREEN
    ENDIF.

    MODIFY gt_fit FROM gs_fit.
  ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form make_variant
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM make_variant .
  gv_variant-report = sy-cprog.
    gv_save = 'A'.

    gs_layout-zebra = 'X'.
    gs_layout-cwidth_opt = 'X'.
    gs_layout-sel_mode = 'D'. " A B C D space

    gs_layout-excp_fname = 'LIGHT'."exception field 설정
*    gs_layout-excp_led = 'X'.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form grid_layout
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM grid_layout .
  CALL METHOD go_alv_grid->set_table_for_first_display
      EXPORTING
*       i_buffer_active  =
*       i_bypassing_buffer            =
*       i_consistency_check           =
        i_structure_name = 'SFLIGHT'
        is_variant       = gv_variant
        i_save           = gv_save
        i_default        = 'X'
        is_layout        = gs_layout
*       is_print         =
*       it_special_groups             =
*       it_toolbar_excluding          =
*       it_hyperlink     =
*       it_alv_graphics  =
*       it_except_qinfo  =
*       ir_salv_adapter  =
      CHANGING
        it_outtab        = gt_fit
*       it_fieldcatalog  =
*       it_sort          = gt_sort
*       it_filter        =
*  EXCEPTIONS
*       invalid_parameter_combination = 1
*       program_error    = 2
*       too_many_lines   = 3
*       others           = 4
      .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form make_sort
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM make_sort.

  CLEAR gs_sort.

  gs_sort-fieldname = 'CARRID'.
  gs_sort-up = 'X'.
  gs_sort-spos = 1.
  append gs_sort to gt_sort.

  CLEAR gs_sort.
  gs_sort-fieldname = 'CONNNID'.
  gs_sort-up = 'X'.
  gs_sort-spos = 2.
  append gs_sort to gt_sort.

  CLEAR gs_sort.
  gs_sort-fieldname = 'FLDATE'.
  gs_sort-down = 'X'.
  gs_sort-spos = 3.
  append gs_sort to gt_sort.
ENDFORM.
