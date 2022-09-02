*&---------------------------------------------------------------------*
*& Include          ZPRA160002_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.
  CASE ok_code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT' OR 'CANC'.
      LEAVE PROGRAM.
    WHEN OTHERS.
  ENDCASE.
ENDMODULE.