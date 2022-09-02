*&---------------------------------------------------------------------*
*& Include          MZSA0010_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code. "sy-ucomm.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'TAB1' OR 'TAB2'.
      ts_info-activetab = ok_code.

    WHEN 'SEARCH'.
      "Get Connection Info
      PERFORM get_conn_info USING zssa0080-carrid
                                  zssa0080-connid
                            CHANGING zssa0081
                                     zssa0082
                                     gv_subrc.
      IF gv_subrc <> 0.
        MESSAGE i016(pn) WITH 'Data is not found'.
        RETURN.
      ENDIF.

    WHEN 'ENTER'.

    WHEN OTHERS.

  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.
  CASE sy-ucomm.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'CANC'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.
