*&---------------------------------------------------------------------*
*& Include          MZSA1601_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'BACK' OR 'CANC'.
      LEAVE TO SCREEN 0.
*      set SCREEN 0." 원래 주석 두개를 합친게 leave to screen이다
*      LEAVE SCREEN.
    WHEN 'SEARCH'.
      "Get Data
      PERFORM get_data USING gv_pno
                       CHANGING zssa0031.

*      MESSAGE s000(zmcsa16) WITH sy-ucomm.
  ENDCASE.
ENDMODULE.
