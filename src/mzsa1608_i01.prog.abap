*&---------------------------------------------------------------------*
*& Include          MZSA1608_I01
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
    WHEN 'CANC'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'ENTER'.
      PERFORM get_emp_name USING zssa1673-pernr
                           CHANGING zssa1673-ename.
    WHEN 'SEARCH'.
      IF zssa1673-pernr+4(2) <> '00'.
      PERFORM get_emp_info USING zssa1673-pernr
                           CHANGING zssa1670_emp.
      ELSE.
        MESSAGE e016(pn) WITH 'Danger your number Push'.
      ENDIF.
  ENDCASE.
ENDMODULE.
