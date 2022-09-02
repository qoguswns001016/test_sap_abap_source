*&---------------------------------------------------------------------*
*& Include          ZBC405_A16_EXAM_F01
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
    FROM ztspfli_a16
    INTO CORRESPONDING FIELDS OF TABLE gt_spfli
    WHERE carrid IN so_car AND
    connid IN so_con.

  SELECT *
    FROM sairport
    INTO TABLE gt_airp.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_data .
  "country set
  CLEAR gs_spfli.
  LOOP AT gt_spfli INTO gs_spfli.
    CLEAR gs_spfli-countid.
    IF gs_spfli-countryfr = gs_spfli-countryto.
      gs_spfli-countid = 'I'.
    ELSE.

*      ELSEIF ztspfli_a16-countryfr <> ztspfli_a16-countryto.
      gs_spfli-countid = 'D'.
    ENDIF.

    CASE gs_spfli-countid.
      WHEN 'I'.
        gs_color-fname = 'COUNTID'.
        gs_color-color-col = col_total.
        gs_color-color-int = 1.
        gs_color-color-inv = 0.
      WHEN 'D'.
        gs_color-fname = 'COUNTID'.
        gs_color-color-col = col_positive.
        gs_color-color-int = 1.
        gs_color-color-inv = 0.
    ENDCASE.
    APPEND gs_color TO gs_spfli-it_color.
    CLEAR gs_color.


    "flight type
    CLEAR  gs_spfli-ficon .
    IF gs_spfli-fltype = 'X'.
      gs_spfli-ficon = icon_ws_plane.
    ENDIF.

    "Exception Handling
    IF gs_spfli-period >= 2.
      gs_spfli-light = 1.
    ELSEIF gs_spfli-period >= 1.
      gs_spfli-light = 2.
    ELSE.
      gs_spfli-light = 3.
    ENDIF.

    "T-zone
    READ TABLE gt_airp INTO gs_airp WITH KEY id = gs_spfli-airpfrom.
    IF sy-subrc EQ 0.
      gs_spfli-from_tzone = gs_airp-time_zone.
    ENDIF.

    READ TABLE gt_airp INTO gs_airp WITH KEY id = gs_spfli-airpto.
    IF sy-subrc EQ 0.
      gs_spfli-to_tzone = gs_airp-time_zone.
    ENDIF.


    MODIFY gt_spfli FROM gs_spfli.
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
  gs_layout-zebra = 'X'.
  gs_layout-info_fname = 'ROW_COLOR'.
  gs_layout-ctab_fname = 'IT_COLOR'.
  gs_layout-excp_fname = 'LIGHT'. "Exception handling
  gs_layout-excp_led = 'X'.
  gs_layout-grid_title = 'Flight Schedule Report'.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_fieldcatalog
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_fieldcatalog .
  CLEAR gs_fcat.
  gs_fcat-fieldname = 'CARRID'.
  gs_fcat-coltext = 'Airline'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'COUNTID'.
  gs_fcat-coltext = 'I&D'.
  gs_fcat-col_opt = 'X'.
  gs_fcat-col_pos = 5.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'FICON'.
  gs_fcat-coltext = 'FLIGHT'.
  gs_fcat-just = 'C'.
  gs_fcat-col_pos = 9.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'FROM_TZONE'.
  gs_fcat-coltext = 'From TZONE'.
  gs_fcat-col_pos = 16.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'TO_TZONE'.
  gs_fcat-coltext = 'To TZONE'.
  gs_fcat-col_pos = 17.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'LIGHT'.
  gs_fcat-coltext = 'Info'. "column명
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'FLTYPE'.
  gs_fcat-no_out = 'X'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'FLTIME'.
  gs_fcat-edit = pa_edit.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'DEPTIME'.
  gs_fcat-edit = pa_edit.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'ARRTIME'.
  gs_fcat-emphasize = 'C301'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'PERIOD'.
  gs_fcat-emphasize = 'C301'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'MO_CHECK'.
  gs_fcat-coltext = 'CHECK'.
  gs_fcat-col_pos = 1.
  APPEND gs_fcat TO gt_fcat.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form fltime_change_part
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM fltime_changed_part USING rr_data_changed TYPE REF TO
                              cl_alv_changed_data_protocol
                              rs_mod_cells TYPE lvc_s_modi.
  DATA: l_fltime   TYPE s_fltime,
        l_deptime  TYPE s_dep_time,
        ev_arrtime TYPE s_arr_time,
        ev_period  TYPE n.

  CLEAR gs_spfli.
  READ TABLE gt_spfli INTO gs_spfli INDEX rs_mod_cells-row_id.

  CALL METHOD rr_data_changed->get_cell_value
    EXPORTING
      i_row_id    = rs_mod_cells-row_id
      i_fieldname = 'FLTIME'
    IMPORTING
      e_value     = l_fltime.

  CHECK sy-subrc = 0.

  CALL METHOD rr_data_changed->get_cell_value
    EXPORTING
      i_row_id    = rs_mod_cells-row_id
      i_fieldname = 'DEPTIME'
    IMPORTING
      e_value     = l_deptime.

  CALL FUNCTION 'ZBC405_CALC_ARRTIME'
    EXPORTING
      iv_fltime       = l_fltime
      iv_deptime      = l_deptime
      iv_utc          = gs_spfli-from_tzone
      iv_utc1         = gs_spfli-to_tzone
    IMPORTING
      ev_arrival_time = ev_arrtime
      ev_period       = ev_period.

  CALL METHOD rr_data_changed->modify_cell
    EXPORTING
      i_row_id    = rs_mod_cells-row_id
      i_fieldname = 'ARRTIME'
      i_value     = ev_arrtime.
  CALL METHOD rr_data_changed->modify_cell
    EXPORTING
      i_row_id    = rs_mod_cells-row_id
      i_fieldname = 'PERIOD'
      i_value     = ev_period.
  gs_spfli-period = ev_period.
  gs_spfli-arrtime = ev_arrtime.

  IF gs_spfli-period >= 2.
    gs_spfli-light = '1'.
  ELSEIF gs_spfli-period = 1.
    gs_spfli-light = '2'.
  ELSE.
    gs_spfli-light = '3'.
  ENDIF.

  CALL METHOD rr_data_changed->modify_cell
    EXPORTING
      i_row_id    = rs_mod_cells-row_id
      i_fieldname = 'LIGHT'
      i_value     = gs_spfli-light.
  gs_spfli-mo_check = 'X'.
  CALL METHOD rr_data_changed->modify_cell
    EXPORTING
      i_row_id    = rs_mod_cells-row_id
      i_fieldname = 'MO_CHECK'
      i_value     = gs_spfli-mo_check.
  MODIFY gt_spfli FROM gs_spfli INDEX rs_mod_cells-row_id.









ENDFORM.
*&---------------------------------------------------------------------*
*& Form data_save
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM data_save .

  LOOP AT gt_spfli INTO gs_spfli WHERE mo_check = 'X'.
    UPDATE ztspfli_a16
      SET fltime = gs_spfli-fltime
          deptime = gs_spfli-deptime
          arrtime = gs_spfli-arrtime
          period = gs_spfli-period
    WHERE carrid = gs_spfli-carrid AND
          connid = gs_spfli-connid.

  ENDLOOP.
ENDFORM.
