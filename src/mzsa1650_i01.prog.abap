*&---------------------------------------------------------------------*
*& Include          MZSA1650_I01
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
    WHEN 'ENTER'.

    WHEN 'TAB1' OR 'TAB2'.
      ven_info-activetab = ok_code.
    WHEN 'SEARCH'.
      CLEAR: zssa16meal, zssa16ven.
      PERFORM meal_info USING zssa16ven_con-carrid zssa16ven_con-mealnumber
                        CHANGING zssa16meal zssa16ven
                                 gv_subrc.
      PERFORM get_domain USING 'S_MEALTYPE'
                               'ZDVENCA_A16'
                                zssa16meal-mealtype
                                zssa16ven-venca
                         CHANGING zssa16meal-mealtype_t
                                  zssa16ven-venca_t.



    WHEN OTHERS.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.
  CASE ok_code.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'CANC'.
      LEAVE TO SCREEN 0.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CHECK_CARRID  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_carrid INPUT.

  IF zssa16ven_con-carrid = 'AB'.
    MESSAGE e016(pn) WITH 'Check AB'.

  ENDIF.
ENDMODULE.
