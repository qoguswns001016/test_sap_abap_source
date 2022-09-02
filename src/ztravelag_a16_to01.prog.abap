*----------------------------------------------------------------------*
***INCLUDE BC414_SQL_TRAVELAG_SO01
*----------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Module  CLEAR_OKCODE  OUTPUT
*&---------------------------------------------------------------------*
MODULE clear_okcode OUTPUT.

  CLEAR ok_code.

ENDMODULE.                 " CLEAR_OKCODE  OUTPUT


*&---------------------------------------------------------------------*
*&      Module  GET_DATA  OUTPUT
*&---------------------------------------------------------------------*
MODULE get_data OUTPUT.

  IF gv_sel_changed = abap_true.
    PERFORM get_selected_lines USING    gt_travelag
                               CHANGING gt_travelag_sel.
    gv_sel_changed = abap_false.
*   Show screen in modal dialog box.
    REFRESH CONTROL 'TC_STRAVELAG' FROM SCREEN '0200'.
  ENDIF.

ENDMODULE.                 " GET_DATA  OUTPUT


*&---------------------------------------------------------------------*
*&      Module  INIT_ALV  OUTPUT
*&---------------------------------------------------------------------*
MODULE init_alv OUTPUT.

  IF go_container IS INITIAL.
    CREATE OBJECT go_container
      EXPORTING
        container_name = 'CONTAINER'.
    CREATE OBJECT go_alv
      EXPORTING
        i_parent = go_container.
    gv_refresh = abap_true.
  ENDIF.
  IF gv_refresh = abap_true.
    PERFORM read_data CHANGING gt_travelag.
    gs_layout-sel_mode = 'A'.
    go_alv->set_table_for_first_display(
      EXPORTING
        is_layout        = gs_layout
        i_structure_name = 'STRAVELAG'
      CHANGING
        it_outtab        = gt_travelag ).
    gv_refresh = abap_false.
  ELSE.
    go_alv->refresh_table_display( ).
  ENDIF.

ENDMODULE.                 " INIT_ALV  OUTPUT


*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.

  SET PF-STATUS 'DYN_100'.
  SET TITLEBAR 'DYN_100'.

ENDMODULE.                             " STATUS_0100  OUTPUT


*&---------------------------------------------------------------------*
*&      Module  STATUS_0200  OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0200 OUTPUT.

  SET PF-STATUS 'DYN_200'.
  SET TITLEBAR 'DYN_200'.

ENDMODULE.                             " STATUS_0200  OUTPUT


*&---------------------------------------------------------------------*
*&      Module  TRANS_TO_0200  OUTPUT
*&---------------------------------------------------------------------*
MODULE trans_to_0200 OUTPUT.

* Field transport to screen
  MOVE-CORRESPONDING gs_travelag TO stravelag.

ENDMODULE.                             " TRANS_TO_0200  OUTPUT
