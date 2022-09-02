*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_ALV_F01
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
    FROM sflight AS f INNER JOIN saplane AS p
    ON f~planetype = p~planetype
 INTO CORRESPONDING FIELDS OF TABLE gt_flt
    WHERE f~carrid IN so_car
    AND f~connid IN so_con
    AND f~fldate IN so_dat.

  LOOP AT gt_flt INTO gs_flt.
    IF gs_flt-seatsocc < 5.
      gs_flt-light = 1. "red
    ELSEIF gs_flt-seatsocc < 100.
      gs_flt-light = 2. "Yellow
    ELSE.
      gs_flt-light = 3. "Green
    ENDIF.

    IF gs_flt-fldate+4(2) = sy-datum+4(2).
      gs_flt-row_color = 'C510'.
    ENDIF.

    IF gs_flt-planetype = '747-400'.
      gs_color-fname = 'PLANETYPE'.
      gs_color-color-col = col_total.
      gs_color-color-inv = '0'.
      gs_color-color-int = '1'.
      APPEND gs_color TO gs_flt-it_color.
    ENDIF.

    IF  gs_flt-seatsmax_b <= '10'.
      gs_color-fname = 'SEATSMAX_B'.
      gs_color-color-col = '6'.
      gs_color-color-int = '1'.
      gs_color-color-inv = '0'.

      APPEND gs_color TO gs_flt-it_color.

    ENDIF.

    IF gs_flt-fldate < p_date.
      gs_flt-changes_possible = icon_space.
    ELSE.
      gs_flt-changes_possible = icon_okay.
    ENDIF.

    IF gs_flt-seatsmax_b = gs_flt-seatsocc_b.
      gs_flt-btn_text = 'FullSeats!'.
*    gs_flt-btn_text = '예약하기!'.

      gs_styl-fieldname = 'BTN_TEXT'.
      gs_styl-style = cl_gui_alv_grid=>mc_style_button.
      APPEND gs_styl TO gs_flt-it_styl.

    ENDIF.

    MODIFY gt_flt FROM gs_flt.

  ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form make_layout
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM make_layout .
  "layout setting
  gs_layout-zebra = 'X'. "행 번갈아가면서 다른 색상
  gs_layout-cwidth_opt = 'X'. "화면에 보이는 최대 길이로 맞춰서 column이 압축됨
  gs_layout-sel_mode = 'D'. " A B C D

  gs_layout-excp_fname = 'LIGHT'.
  gs_layout-excp_led = 'X'. "1개 짜리 신호등이 나옴

  gs_layout-info_fname = 'ROW_COLOR'.
  gs_layout-ctab_fname = 'IT_COLOR'.

  gs_layout-stylefname = 'IT_STYL'.
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
  gs_variant-variant = pa_lv.
  gs_variant-report = sy-cprog.
  gv_save = 'A'.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form make_sort
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM make_sort .

  "wa가 중복되어 append될 때에는 항상 clear하자
  CLEAR gs_sort.
  gs_sort-fieldname = 'CARRID'.
  gs_sort-up = 'X'.
  gs_sort-spos = 1.
  APPEND gs_sort TO gt_sort.

  CLEAR gs_sort.
  gs_sort-fieldname = 'CONNID'.
  gs_sort-up = 'X'.
  gs_sort-spos = 2.
  APPEND gs_sort TO gt_sort.

  CLEAR gs_sort.
  gs_sort-fieldname = 'FLDATE'.
  gs_sort-down = 'X'.
  gs_sort-spos = 3.
  APPEND gs_sort TO gt_sort.
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
  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'CARRID'.
*  gs_fcat-hotspot = 'X'.
  gs_fcat-coltext = 'Ariline'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'LIGHT'.
  gs_fcat-coltext = 'Info'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'PRICE'.
*  gs_fcat-no_out = 'X'.
  gs_fcat-emphasize = 'C610'.
  gs_fcat-col_opt ='X'.
*  gs_fcat-edit = 'X'
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'CHANGES_POSSIBLE'.
  gs_fcat-coltext = 'Chang.Poss'.
  gs_fcat-col_pos = 9.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'BTN_TEXT'.
  gs_fcat-coltext = 'Status'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'TANKCAP'.
  gs_fcat-coltext = 'Tankcap'.
  gs_fcat-col_pos = 5.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'CAP_UNIT'.
  gs_fcat-coltext = 'Cap_Unit'.
  gs_fcat-col_pos = 6.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'WEIGHT'.
  gs_fcat-coltext = 'Weight'.
  gs_fcat-col_pos = 7.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'WEI_UNIT'.
  gs_fcat-coltext = 'Wri_Unit'.
  gs_fcat-col_pos = 8.
  APPEND gs_fcat TO gt_fcat.

ENDFORM.
