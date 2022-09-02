*&---------------------------------------------------------------------*
*& Include          ZBC405_A16_ALV_CLASS
*&---------------------------------------------------------------------*
CLASS lcl_handler DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS :
      on_doubleclick FOR EVENT double_click
        OF cl_gui_alv_grid
        IMPORTING e_row e_column es_row_no,
*--------------------------------------------------------------------*
      on_hotspot FOR EVENT hotspot_click
        OF cl_gui_alv_grid
*        IMPORTING e_row_id e_column_id es_row_no,
        IMPORTING e_row_id e_column_id es_row_no,
*--------------------------------------------------------------------*
      on_toolbar FOR EVENT toolbar
        OF cl_gui_alv_grid
        IMPORTING e_object,
*--------------------------------------------------------------------*
      on_user_command FOR EVENT user_command
        OF cl_gui_alv_grid
        IMPORTING e_ucomm,
*--------------------------------------------------------------------*
      on_button_click FOR EVENT button_click
        OF cl_gui_alv_grid
        IMPORTING es_col_id es_row_no,
*--------------------------------------------------------------------*
      on_context_menu_request FOR EVENT context_menu_request
        OF cl_gui_alv_grid
        IMPORTING e_object,
*--------------------------------------------------------------------*
      on_before_user_com FOR EVENT before_user_command
        OF cl_gui_alv_grid
        IMPORTING e_ucomm.


ENDCLASS.

CLASS lcl_handler IMPLEMENTATION.

  METHOD on_doubleclick.
    DATA : total_occ   TYPE i,
           total_occ_c TYPE c LENGTH 10.

    CASE e_column-fieldname.
      WHEN 'CHANGES_POSSIBLE'.

        READ TABLE gt_flt INTO gs_flt INDEX es_row_no-row_id.
        IF sy-subrc EQ 0.
          total_occ = gs_flt-seatsocc +
                      gs_flt-seatsocc_b +
                      gs_flt-seatsocc_f.

          total_occ_c = total_occ.
          CONDENSE total_occ_c.
          MESSAGE i000(zt03_msg) WITH 'Total number of bookings: ' total_occ_c.

        ELSE.
          MESSAGE i075(bc405_408).
        ENDIF.
    ENDCASE.
  ENDMETHOD.

  METHOD on_hotspot.
    DATA carr_name TYPE scarr-carrname.
    CALL METHOD go_alv_grid->get_selected_rows.

    CASE e_column_id-fieldname.
      WHEN 'CARRID'.
        READ TABLE gt_flt INTO gs_flt INDEX es_row_no-row_id.
        IF sy-subrc EQ 0.
          SELECT SINGLE carrname
            FROM scarr
            INTO carr_name
            WHERE carrid = gs_flt-carrid.
          IF sy-subrc EQ 0.
            MESSAGE i000(zt03_msg) WITH carr_name.
          ELSE.
            MESSAGE i000(zt03_msg) WITH 'No found'.
          ENDIF.
        ELSE.
          MESSAGE i000(zt03_msg) WITH 'No found'.
        ENDIF.
    ENDCASE.
  ENDMETHOD.

  METHOD on_toolbar.
    DATA ls_button TYPE stb_button.

    CLEAR ls_button.
    ls_button-function = 'PERCENTAGE'.
*      ls_button-icon = ?
    ls_button-quickinfo = 'Occupied Percentage'.
    ls_button-butn_type = '0'. "Normal Button
    ls_button-text = 'Percentage'.
    INSERT ls_button INTO TABLE e_object->mt_toolbar.

    CLEAR ls_button.
    ls_button-butn_type = '3'. "구분선
    INSERT ls_button INTO TABLE e_object->mt_toolbar.

    CLEAR ls_button.
    ls_button-function = 'PERCENTAGE_MARKED'.
*      ls_button-icon = ?
    ls_button-quickinfo = 'Occupied Marked Percentage'.
    ls_button-butn_type = '0'. "Normal Button
    ls_button-text = 'Marked Percentage'.
    INSERT ls_button INTO TABLE e_object->mt_toolbar.

    CLEAR ls_button.
    ls_button-function = 'AIRLINE_NAME'.
*      ls_button-icon = ?
    ls_button-quickinfo = 'Airline name'.
    ls_button-butn_type = '0'. "Normal Button
    ls_button-text = 'Airline Name'.
    INSERT ls_button INTO TABLE e_object->mt_toolbar.
  ENDMETHOD.

  METHOD on_user_command.
    DATA: lv_occp     TYPE i,
          lv_capa     TYPE i,
          lv_perc     TYPE p LENGTH 8 DECIMALS 1,
          lv_text(20).

    DATA: lt_rows   TYPE lvc_t_roid,
          ls_rows   TYPE lvc_s_roid,
          ls_row TYPE lvc_s_row,

          ls_col    TYPE lvc_s_col,
          carr_name TYPE scarr-carrname.

    CASE e_ucomm.
      WHEN 'PERCENTAGE'.
        LOOP AT gt_flt INTO gs_flt.
          lv_occp = lv_occp + gs_flt-seatsocc.
          lv_capa = lv_capa + gs_flt-seatsmax.
        ENDLOOP.
        lv_perc = lv_occp / lv_capa * 100.
        lv_text = lv_perc.
        CONDENSE lv_text.

        MESSAGE i000(zt03_msg) WITH 'Percentage Of Occupied seats :' lv_text '%'.

      WHEN 'PERCENTAGE_MARKED'.
        CALL METHOD go_alv_grid->get_selected_rows
          IMPORTING
*           et_index_rows =
            et_row_no = lt_rows.

        IF lines( lt_rows ) > 0.
          LOOP AT lt_rows INTO ls_rows.

            READ TABLE gt_flt INTO gs_flt INDEX ls_rows-row_id.
            IF sy-subrc EQ 0.
              lv_occp = lv_occp + gs_flt-seatsocc.
              lv_capa = lv_capa + gs_flt-seatsmax.

            ENDIF.

          ENDLOOP.

          lv_perc = lv_occp / lv_capa * 100.
          lv_text = lv_perc.
          CONDENSE lv_text.

          MESSAGE i000(zt03_msg) WITH 'Percentage Of Occupied seats :' lv_text '%'.

        ELSE.
          MESSAGE i000(zt03_msg) WITH 'Please select at least one line'.
        ENDIF.

      WHEN 'AIRLINE_NAME'.
        CALL METHOD go_alv_grid->get_current_cell
          IMPORTING
*           e_row     =
*           e_value   =
*           e_col     =
*           es_row_id =
            es_col_id = ls_col
            es_row_no = ls_rows.

        READ TABLE gt_flt INTO gs_flt INDEX ls_rows-row_id.
        IF sy-subrc EQ 0.
          SELECT SINGLE carrname
            FROM scarr
            INTO carr_name
            WHERE carrid = gs_flt-carrid.
          IF sy-subrc EQ 0.
            MESSAGE i000(zt03_msg) WITH carr_name.
          ELSE.
            MESSAGE i000(zt03_msg) WITH 'No found'.
          ENDIF.
        ELSE.
          MESSAGE i000(zt03_msg) WITH 'No found'.
        ENDIF.

      WHEN'SCHE'. "goto flight schedule report.
      CALL METHOD go_alv_grid->get_current_cell
          IMPORTING
            es_col_id = ls_col
            es_row_id = ls_row.

        READ TABLE gt_flt INTO gs_flt INDEX ls_row-index.
        IF sy-subrc EQ 0.
          SUBMIT bc405_event_d4 AND RETURN
             WITH so_car EQ gs_flt-carrid
             WITH so_con EQ gs_flt-connid.
        ENDIF.


    ENDCASE.
  ENDMETHOD.

  METHOD on_button_click.

    READ TABLE gt_flt INTO gs_flt INDEX es_row_no-row_id.

    IF ( gs_flt-seatsmax NE gs_flt-seatsocc ) OR
       ( gs_flt-seatsmax_f NE gs_flt-seatsocc_f ).
      MESSAGE i000(zt03_msg) WITH '다른 동급의 좌석을 예약하시오.'.

    ELSE.
      MESSAGE i000(zt03_msg) WITH '모든 좌석이 얘약이 된 상태입니다'.
    ENDIF.
  ENDMETHOD.

  METHOD on_context_menu_request.

    DATA: ls_rows   TYPE lvc_s_roid,
          ls_col    TYPE lvc_s_col,
          carr_name TYPE scarr-carrname.
*    CALL METHOD e_object->add_separator. "contextMenu 에 구분선 넣는것.
*    CALL METHOD cl_ctmenu=>load_gui_status
*      EXPORTING
*        program    = sy-cprog
*        status     = 'CT_MENU'
**       disable    =   "보일까 말까 X 로 하면 안보임.
*        menu       = e_object
*      EXCEPTIONS
*        read_error = 1
*        OTHERS     = 2.
*    IF sy-subrc <> 0.
**     Implement suitable error handling here
*    ENDIF.
    IF ls_col = 'CARRID'.
      CALL METHOD e_object->add_separator. "contextMenu 에 구분선 넣는것.
      CALL METHOD e_object->add_function
        EXPORTING
          fcode = 'AIRLINE_NAME'
          text  = 'Display Airline'
*         icon  =
*         ftype =
*         disabled          =
*         hidden            =
*         checked           =
*         accelerator       =
*         insert_at_the_top = SPACE
        .
      CALL METHOD go_alv_grid->get_current_cell
        IMPORTING
*         e_row     =
*         e_value   =
*         e_col     =
*         es_row_id =
          es_col_id = ls_col
          es_row_no = ls_rows.
    ENDIF.


  ENDMETHOD.

  METHOD on_before_user_com.
    CASE e_ucomm.
      WHEN cl_gui_alv_grid=>mc_fc_detail.
        CALL METHOD go_alv_grid->set_user_command
          EXPORTING
            i_ucomm = 'SCHE'.
    ENDCASE.


  ENDMETHOD.
ENDCLASS.
