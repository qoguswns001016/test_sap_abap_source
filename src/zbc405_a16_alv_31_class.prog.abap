*&---------------------------------------------------------------------*
*& Include          ZBC405_ALV_CL1_T03_CLASS
*&---------------------------------------------------------------------*
CLASS lcl_handler DEFINITION.

  PUBLIC SECTION.
    CLASS-METHODS :

      on_doubleclick FOR EVENT
        double_click OF cl_gui_alv_grid
        IMPORTING e_row e_column es_row_no,
      on_toolbar FOR EVENT
        toolbar OF cl_gui_alv_grid
        IMPORTING e_object,
      on_usercommand FOR EVENT
        user_Command OF cl_gui_alv_grid
        IMPORTING e_ucomm,
      on_data_changed FOR EVENT
        data_changed OF cl_gui_alv_grid
        IMPORTING er_data_changed.


ENDCLASS.

CLASS lcl_handler IMPLEMENTATION.
  METHOD on_data_changed.

    DATA : ls_mod_cells TYPE lvc_s_modi.

    LOOP AT er_data_changed->mt_good_cells INTO ls_mod_cells.

      CASE ls_mod_cells-fieldname.

        WHEN 'CUSTOMID'.
          PERFORM customer_change_part USING er_data_changed
                                       ls_mod_cells.

      ENDCASE.


    ENDLOOP.


  ENDMETHOD.



  METHOD on_usercommand.
    DATA : ls_col  TYPE   lvc_s_col,
           ls_roid TYPE  lvc_s_roid.


    CALL METHOD go_alv->get_current_cell
      IMPORTING
        es_col_id = ls_col
        es_row_no = ls_roid.



    CASE e_ucomm.
      WHEN 'GOTOFL'.
        READ TABLE gt_sbook INTO gs_sbook
             INDEX ls_roid-row_id.
        IF sy-subrc EQ 0.
          SET PARAMETER ID 'CAR' FIELD gs_sbook-carrid.
          SET PARAMETER ID 'CON' FIELD gs_sbook-connid.

          CALL TRANSACTION 'SAPBC405CAL'.

        ENDIF.
    ENDCASE.

  ENDMETHOD.

  METHOD on_toolbar.
    DATA : wa_button TYPE stb_button.

    wa_button-butn_type = '3'.     "seperator
    INSERT wa_button INTO TABLE e_object->mt_toolbar.

    CLEAR : wa_button.
    wa_button-butn_type = '0'.    "normal button
    wa_button-function = 'GOTOFL'.   "flight connection.
    wa_button-icon     = ICON_Flight.
    wa_button-quickinfo = 'Go to flight connection!'.
    wa_button-text = 'Flight'.
    INSERT wa_button INTO TABLE e_object->mt_toolbar.


  ENDMETHOD.



  METHOD on_doubleclick.
    DATA : carrname TYPE scarr-carrname.
    CASE e_column-fieldname.
      WHEN 'CARRID'.
        READ TABLE gt_sbook INTO gs_sbook
             INDEX e_row-index.
        IF sy-subrc EQ 0.

          SELECT SINGLE carrname INTO carrname
                FROM scarr WHERE carrid = gs_sbook-carrid.
          IF sy-subrc EQ 0.
            MESSAGE i000(zt03_msg) WITH carrname.
          ENDIF.
        ENDIF.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
