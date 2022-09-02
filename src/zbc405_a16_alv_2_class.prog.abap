*&---------------------------------------------------------------------*
*& Include          ZBC405_A16_ALV_2_CLASS
*&---------------------------------------------------------------------*

CLASS lcl_handler DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      on_doubleclick FOR EVENT
        double_click OF cl_gui_alv_grid
        IMPORTING e_row e_column es_row_no.

ENDCLASS.

CLASS lcl_handler IMPLEMENTATION.
  METHOD on_doubleclick.
    DATA: carrname TYPE scarr-carrname.

    CASE e_column-fieldname..
      WHEN 'CARRID'.
        READ TABLE gt_sbook INTO gs_sbook
        INDEX e_row-index.
        IF sy-subrc EQ 0.
          SELECT SINGLE carrname
            FROM scarr
            INTO carrname
            WHERE carrid = gs_sbook-carrid.
          IF sy-subrc EQ 0.
            MESSAGE i000(zt03_msg) WITH carrname.

          ENDIF.
        ENDIF.
    ENDCASE.

  ENDMETHOD.
ENDCLASS.
