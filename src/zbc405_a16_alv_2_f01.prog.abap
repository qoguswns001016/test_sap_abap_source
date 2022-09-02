*&---------------------------------------------------------------------*
*& Include          ZBC405_A16_ALV_2_F01
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

  DATA gt_custom TYPE TABLE of ztscustom_a16.
  DATA gs_custom TYPE ztscustom_a16.
  DATA gt_temp TYPE TABLE of ts_sbook.

  SELECT *
    FROM ztsbook_a16
    INTO CORRESPONDING FIELDS OF TABLE gt_sbook
    WHERE carrid IN so_car AND
    connid IN so_con AND
    fldate IN so_fld AND
    customid IN so_cus.

  IF sy-subrc eq 0.

    gt_temp = gt_sbook.
    DELETE gt_temp where customid = space.

    sort gt_temp by customid.
    delete ADJACENT DUPLICATES FROM gt_temp COMPARING customid.
    "AD~~~~ 중복되는걸 지운다 .
    select *
      from ztscustom_a16
      into table gt_custom
      for ALL ENTRIES IN gt_sbook
      WHERE id = gt_sbook-customid.

  ENDIF.
 LOOP AT gt_sbook INTO gs_sbook.
  IF gs_sbook-class = 'F'.
    gs_sbook-row_color = 'C710'.

  ENDIF.
  IF gs_sbook-smoker = 'X'.

    gs_color-fname = 'SMOKER'.
    gs_color-color-col = col_negative.
    gs_color-color-int = '1'.
    gs_color-color-inv = '0'.
    APPEND gs_color TO gs_sbook-it_color.

  ENDIF.

    READ TABLE gt_custom into gs_custom WITH key id = gs_sbook-customid.
    IF sy-subrc eq 0.
      gs_sbook-telephone = gs_custom-telephone.
      gs_sbook-email = gs_custom-email.
    ENDIF.

"-------------------------------------------
    IF gs_sbook-luggweight > 25.
      gs_sbook-light = 1. "red
    ELSEIF gs_sbook-luggweight > 15.
      gs_sbook-light = 2.
    ELSE.
      gs_sbook-light = 3.
    ENDIF.
    MODIFY gt_sbook FROM gs_sbook.
  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_layout
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_layout .

  gs_layout-sel_mode = 'D'.
  gs_layout-excp_fname = 'LIGHT'. "exception Handling
  gs_layout-excp_led = 'X'.
  gs_layout-zebra = 'X'.
  gs_layout-cwidth_opt = 'X'.

  gs_layout-info_fname = 'ROW_COLOR'.
  gs_layout-ctab_fname = 'IT_COLOR'.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_sort
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_sort .

  CLEAR gs_sort.
  gs_sort-fieldname = 'CARRID'.
  gs_sort-up = 'X'.
  gs_sort-spos = '1'.
  APPEND gs_sort TO gt_sort.
  CLEAR gs_sort.
  gs_sort-fieldname = 'CONNID'.
  gs_sort-up = 'X'.
  gs_sort-spos = '2'.
  APPEND gs_sort TO gt_sort.
  CLEAR gs_sort.
  gs_sort-fieldname = 'FLDATE'.
  gs_sort-down = 'X'.
  gs_sort-spos = '3'.
  APPEND gs_sort TO gt_sort.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_variant
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_variant .
  CALL FUNCTION 'LVC_VARIANT_SAVE_LOAD'
    EXPORTING
      i_save_load = 'F'
    CHANGING
      cs_variant  = gs_variant.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ELSE.
    p_layout = gs_variant-variant.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form make_fieldcatalog
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM make_fieldcatalog .
  CLEAR gs_fcat.
  gs_fcat-fieldname = 'LIGHT'.
  gs_fcat-coltext = 'Info'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'SMOKER'.
  gs_fcat-checkbox = 'X'.
  APPEND gs_fcat to gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'CANCEL'.
  gs_fcat-checkbox = 'X'.
  APPEND gs_fcat to gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'INVOICE'.
  gs_fcat-checkbox = 'X'.
  APPEND gs_fcat to gt_fcat.


endform.
