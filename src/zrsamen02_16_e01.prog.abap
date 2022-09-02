*&---------------------------------------------------------------------*
*& Include          ZRSAMEN02_16_E01
*&---------------------------------------------------------------------*
INITIALIZATION.
  PERFORM get_data.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S100'.
  SET TITLEBAR 'T100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  DATA: lt_rows TYPE lvc_t_roid,
        ls_rows TYPE lvc_s_roid,
        ls_row  TYPE lvc_s_row,
        ls_col  TYPE lvc_s_col.

  CASE sy-ucomm.
    WHEN 'BACK' OR 'CANC'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'COPY'.





  ENDCASE.
ENDMODULE.

MODULE create_and_transfer OUTPUT.
  PERFORM make_sort.
  PERFORM make_fieldcatalog.
  PERFORM make_layout.

  IF go_container IS INITIAL.
    CREATE OBJECT go_container
      EXPORTING
        container_name = 'MY_CONTROL_AREA'
      EXCEPTIONS
        OTHERS         = 6.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
    CREATE OBJECT go_alv_grid
      EXPORTING
        i_parent = go_container
      EXCEPTIONS
        OTHERS   = 5.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDIF.


  PERFORM grid_layout.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CREATE_AND_TRANSFER2 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE create_and_transfer2 OUTPUT.
  PERFORM make_sort.
  PERFORM make_fieldcatalog.
  PERFORM make_layout.

  IF go_container IS INITIAL.
    CREATE OBJECT go_container
      EXPORTING
        container_name = 'MY_CONTROL_AREA2'
      EXCEPTIONS
        OTHERS         = 6.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
    CREATE OBJECT go_alv_grid
      EXPORTING
        i_parent = go_container
      EXCEPTIONS
        OTHERS   = 5.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDIF.


  PERFORM grid_layout.

  SET HANDLER lcl_handler=>on_context_menu_request FOR go_alv_grid.
  SET HANDLER lcl_handler=>on_user_command FOR go_alv_grid.
ENDMODULE.


START-OF-SELECTION.

  PERFORM get_data.

  CALL SCREEN 100.
