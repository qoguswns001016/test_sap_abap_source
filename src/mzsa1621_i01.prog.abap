*&---------------------------------------------------------------------*
*& Include          MZSA1621_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'TAB1' OR 'TAB2'.
      em_info-activetab = ok_code.
    WHEN 'SEARCH'.
      PERFORM get_emp_info USING zssa1673-pernr
                           CHANGING zssa1670_emp.
    WHEN 'ENTER'.
      PERFORM get_conn_info USING zssa1673-pernr
                            CHANGING zssa1673-ename.
    WHEN OTHERS.
  ENDCASE.
ENDMODULE.
