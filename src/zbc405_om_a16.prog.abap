*&---------------------------------------------------------------------*
*& Report ZBC405_OM_A16
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_om_a16.
TABLES: spfli.

SELECT-OPTIONS : so_car FOR spfli-carrid MEMORY ID car,
                 so_con FOR spfli-connid MEMORY ID con.


DATA: gt_spfli TYPE TABLE OF spfli,
      gs_spfli TYPE spfli.

DATA: go_alv     TYPE REF TO cl_salv_table,
      go_func    TYPE REF TO cl_salv_functions_list,
      go_disp    TYPE REF TO cl_salv_display_settings,
      go_columns TYPE REF TO cl_salv_columns_table,
      go_column  TYPE REF TO cl_salv_column_table,
      go_cols    TYPE REF TO cl_salv_column.

START-OF-SELECTION.

  SELECT *
    FROM spfli
    INTO TABLE gt_spfli
    WHERE carrid IN so_car AND
          connid IN so_con.

  TRY.
      CALL METHOD cl_salv_table=>factory
        EXPORTING
          list_display = '' "IF_SALV_C_BOOL_SAP=>FALSE
*         r_container  =
*         container_name =
        IMPORTING
          r_salv_table = go_alv
        CHANGING
          t_table      = gt_spfli.
    CATCH cx_salv_msg.
  ENDTRY.



  CALL METHOD go_alv->get_functions
    RECEIVING
      value = go_func.

  CALL METHOD go_func->set_all
*    EXPORTING
*      value  = IF_SALV_C_BOOL_SAP=>TRUE
    .
*---- display setting
  CALL METHOD go_alv->get_display_settings
    RECEIVING
      value = go_disp.

*---- Salv title
  CALL METHOD go_disp->set_list_header
    EXPORTING
      value = 'SALV DEMO!!!!!'.
*---- zebra Pattern
  CALL METHOD go_disp->set_striped_pattern
    EXPORTING
      value = 'X'.

*----
  CALL METHOD go_alv->get_columns
    RECEIVING
      value = go_columns.

  CALL METHOD go_columns->set_optimize " 압축
*  EXPORTING
*    value  = IF_SALV_C_BOOL_SAP~TRUE
    .

  TRY.
      CALL METHOD go_columns->get_column
        EXPORTING
          columnname = 'MANDT'
        RECEIVING
          value      = go_cols.
    CATCH cx_salv_not_found.
  ENDTRY.

  go_column ?= go_cols. " Casting Type 이 달라도 구문오류 없이 인정.
  CALL METHOD go_column->set_technical
*    EXPORTING
*      value  = IF_SALV_C_BOOL_SAP=>TRUE
    .







  CALL METHOD go_alv->display.
