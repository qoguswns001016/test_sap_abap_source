*&---------------------------------------------------------------------*
*& Include          ZRSAMEN02_16_CLASS
*&---------------------------------------------------------------------*
CLASS lcl_handler DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS :
      on_context_menu_request FOR EVENT context_menu_request
        OF cl_gui_alv_grid
        IMPORTING e_object,
      on_user_command FOR EVENT before_user_command
        OF cl_gui_alv_grid
        IMPORTING e_ucomm.
ENDCLASS.

CLASS lcl_handler IMPLEMENTATION.
  METHOD on_context_menu_request.
    DATA: ls_rows TYPE lvc_s_roid,
          ls_col  TYPE lvc_s_col.
    CALL METHOD e_object->add_separator.
    CALL METHOD cl_ctmenu=>load_gui_status
      EXPORTING
        program = sy-cprog
        status  = 'COPY'
*       disable =
        menu    = e_object
*     EXCEPTIONS
*       read_error = 1
*       others  = 2
      .
    IF sy-subrc <> 0.
*    Implement suitable error handling here
    ENDIF.

    CALL METHOD go_alv_grid->get_current_cell
      IMPORTING
*       e_row     =
*       e_value   =
*       e_col     =
*       es_row_id =
        es_col_id = ls_col
        es_row_no = ls_rows.


  ENDMETHOD.
  METHOD on_user_command.
    DATA: lv_occp     TYPE i,
          lv_capa     TYPE i,
          lv_perc     TYPE p LENGTH 8 DECIMALS 1,
          lv_text(20).

    DATA: lt_rows   TYPE lvc_t_roid,
          ls_rows   TYPE lvc_s_roid,
          ls_row    TYPE lvc_s_row,

          ls_col    TYPE lvc_s_col,
          carr_name TYPE scarr-carrname.

    CASE e_ucomm.
      WHEN 'COPY'.
                CALL METHOD go_alv_grid->get_selected_rows
          IMPORTING
*            et_index_rows =
            et_row_no     = lt_rows.
      IF lines( lt_rows ) > 0.
        LOOP AT lt_rows INTO ls_rows.
          READ TABLE gt_flt INTO gs_flt INDEX ls_rows-row_id.
          IF sy-subrc EQ 0.
            CLEAR gs_flt2.
            select SINGLE *
              from scarr as c INNER JOIN spfli as s
              ON c~carrid = s~carrid
              INTO CORRESPONDING FIELDS OF gs_flt2
              WHERE s~carrid = gs_flt2-carrid.
          APPEND gs_flt2 to gt_flt2.

          ENDIF.

        ENDLOOP.
      ENDIF.

      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
