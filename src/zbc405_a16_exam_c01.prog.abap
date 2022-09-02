*&---------------------------------------------------------------------*
*& Include          ZBC405_A16_EXAM_C01
*&---------------------------------------------------------------------*
CLASS lcl_handler DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      on_toolbar FOR EVENT toolbar
        OF cl_gui_alv_grid
        IMPORTING e_object e_interactive,

      on_user_command FOR EVENT user_command
        OF cl_gui_alv_grid
        IMPORTING e_ucomm,

      on_double_click FOR EVENT double_click
        OF cl_gui_alv_grid
        IMPORTING e_row e_column es_row_no,

      on_data_changed FOR EVENT data_changed
        OF cl_gui_alv_grid
        IMPORTING er_data_changed.
ENDCLASS.

CLASS lcl_handler IMPLEMENTATION.
  METHOD on_toolbar.
    DATA ls_button TYPE stb_button.

    ls_button-function = 'FLIGHT'.
    ls_button-quickinfo = 'Flight'.
    ls_button-butn_type = '0'.
    ls_button-text = 'Flight'.
    ls_button-icon = icon_flight.
    INSERT ls_button INTO TABLE e_object->mt_toolbar.
    CLEAR ls_button.

    ls_button-function = 'FLIGHT_INFO'.
    ls_button-quickinfo = 'Flight Info'.
    ls_button-butn_type = '0'.
    ls_button-text = 'Flight Info'.
    INSERT ls_button INTO TABLE e_object->mt_toolbar.
    CLEAR ls_button.

    ls_button-function = 'FLIGHT_DATA'.
    ls_button-quickinfo = 'Flight Data'.
    ls_button-butn_type = '0'.
    ls_button-text = 'Flight Data'.
    INSERT ls_button INTO TABLE e_object->mt_toolbar.
    CLEAR ls_button.
  ENDMETHOD.

  METHOD on_user_command.
    DATA : lt_rows TYPE lvc_t_roid,
           ls_rows LIKE LINE OF lt_rows.
    DATA : lv_value  TYPE c LENGTH 10,
           ls_col_id TYPE lvc_s_col,
           lt_spfli  TYPE TABLE OF spfli,
           ls_spfli  LIKE LINE OF lt_spfli.
    DATA : lv_carrname TYPE scarr-carrname,
           lv_carrid   TYPE sdyn_conn-carrid,
           lv_connid   TYPE sdyn_conn-connid,
           lv_fldate   TYPE sdyn_conn-fldate.

    CALL METHOD go_alv->get_current_cell
      IMPORTING
*       e_row     =
        e_value   = lv_value
*       e_col     =
*       es_row_id =
        es_col_id = ls_col_id
        es_row_no = ls_rows.


    CASE e_ucomm.
      WHEN 'FLIGHT'.

        SELECT SINGLE carrname
          FROM scarr
          INTO lv_carrname
          WHERE carrid = lv_value.
        IF sy-subrc <> 0.
          MESSAGE i016(pn) WITH 'Could Not Find'.
        ELSE.
          MESSAGE i016(pn) WITH lv_carrname.
        ENDIF.

      WHEN 'FLIGHT_INFO'.

        CALL METHOD go_alv->get_selected_rows
          IMPORTING
*           et_index_rows =
            et_row_no = lt_rows.
        IF lines( lt_rows ) > 0.
          LOOP AT lt_rows INTO ls_rows.
            READ TABLE gt_spfli  INTO gs_spfli INDEX ls_rows-row_id.
            MOVE-CORRESPONDING gs_spfli TO ls_spfli.
            APPEND ls_spfli TO lt_spfli.
          ENDLOOP.
          EXPORT mem_it_spfli FROM lt_spfli TO MEMORY ID 'BC405'.
          SUBMIT bc405_call_flights AND RETURN.
        ELSE.
          MESSAGE i016(pn) WITH 'you did not select rows'.
        ENDIF.

      WHEN 'FLIGHT_DATA'.

        READ TABLE gt_spfli INTO gs_spfli INDEX ls_rows-row_id.
        IF sy-subrc = 0.
          lv_carrid = gs_spfli-carrid.
          lv_connid = gs_spfli-connid.
          lv_fldate = ''.

          SET PARAMETER ID:
                'CAR' FIELD lv_carrid,
                'CON' FIELD lv_connid,
                'DAY' FIELD lv_fldate.
          CALL TRANSACTION 'SAPBC410A_INPUT_FIEL'.

        ELSE.
          MESSAGE i016(pn) WITH 'you did not select row'.
        ENDIF.
    ENDCASE.
  ENDMETHOD.

  METHOD on_double_click.
    DATA : lt_rows TYPE lvc_t_roid,
           ls_rows LIKE LINE OF lt_rows.


    CASE e_column-fieldname.
      WHEN 'CARRID' OR 'CONNID'.
        CALL METHOD go_alv->get_current_cell
          IMPORTING
            es_row_no = ls_rows.

        READ TABLE gt_spfli INTO gs_spfli INDEX ls_rows-row_id.
        SUBMIT bc405_event_s4 WITH so_car = gs_spfli-carrid WITH so_con = gs_spfli-connid
        AND RETURN.
    ENDCASE.

  ENDMETHOD.

  METHOD on_data_changed.
    DATA: ls_mod_cells TYPE lvc_s_modi,
          ls_cells TYPE lvc_s_modi,
          ls_del_cells TYPE lvc_s_moce,
          ls_ins_cells TYPE lvc_s_moce.

    LOOP AT er_data_changed->mt_good_cells INTO ls_mod_cells.

      CASE ls_mod_cells-fieldname.
        WHEN 'FLTIME' OR 'DEPTIME'.
          PERFORM fltime_changed_part USING er_data_changed
                                           ls_mod_cells.
      ENDCASE.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
