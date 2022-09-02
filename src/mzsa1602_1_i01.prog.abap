*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
*  CASE sy-ucomm.
*    when 'BACK'.
*      LEAVE TO SCREEN 0.
*    when 'EXIT'.
*      LEAVE PROGRAM.
*    when 'CANC'.
*      LEAVE TO SCREEN 0.
*    when 'SEARCH'.
*       MESSAGE i000(zmcasa16) WITH 'CALL'.
*       PERFORM Search_emp USING pernr
*                          CHANGING gv_pernr gv_date gv_ename gv_gender.
*   ENDCASE.
ENDMODULE.
