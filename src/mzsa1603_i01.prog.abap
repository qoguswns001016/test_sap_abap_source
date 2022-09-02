*&---------------------------------------------------------------------*
*& Include          MZSA1603_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'CANC'.
      LEAVE TO SCREEN 0.
    WHEN 'SEARCH'.

      call SCREEN 200.
      MESSAGE i000(zmcasa16) WITH 'CALL'.
      PERFORM get_airline_name USING gv_carrid
                               CHANGING gv_carrname.

*      SET SCREEN 200.
*      LEAVE SCREEN.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.
  CASE sy-ucomm.
    when 'BACK'.
        LEAVE to SCREEN 0.

*       call SCREEN 100.

*      set SCREEN 100.
*      MESSAGE i000(zmcsa16) WITH 'BACK'.
*      LEAVE SCREEN.

*      leave TO SCREEN 100. "목적지를 정하자마자 떠나라. 아래꺼 실행안함.

   ENDCASE.
ENDMODULE.
