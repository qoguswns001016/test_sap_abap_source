*&---------------------------------------------------------------------*
*& Include          SAPMZSA1602_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S100'.
  SET TITLEBAR 'T100' WITH sy-datum.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module SET_DEFAULT OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE set_default OUTPUT.
  IF zssa1660 IS INITIAL.
    zssa1660-carrid = 'AA'.
    zssa1660-connid = '0017'.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module MODIFY_SCREEN_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE modify_screen_0100 OUTPUT.

  LOOP AT SCREEN.
    CASE  screen-group1.
      WHEN 'GR1'.
         screen-active = 0.

    ENDCASE.
    MODIFY SCREEN.
  ENDLOOP.


*  LOOP AT SCREEN.
*    CASE screen-name.
*      WHEN 'ZSSA1660-CARRID'.
*        IF sy-uname <> 'KD-A-16'.
**          screen-input = 0.
*          screen-active = 0.
*        ELSE.
*          screen-input = 1.
*          screen-active = 1.
*        ENDIF.
*       ENDCASE.
*    MODIFY SCREEN.
*    CLEAR screen.
*  ENDLOOP.
ENDMODULE.
