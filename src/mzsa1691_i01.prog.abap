*&---------------------------------------------------------------------*
*& Include          MZSA1690_I01
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
      "GEt Airline Name
      PERFORM get_airline_name USING zssa1690-carrid
                               CHANGING zssa1690-carrname.
      "Get Meal Text
      PERFORM get_meal_text USING zssa1690-carrid
                                  zssa1690-mealnumber
                                  sy-langu
                            CHANGING zssa1690-mealnumber_t.
    WHEN 'SEARCH'.
      PERFORM get_meal_info USING zssa1690-carrid
                                  zssa1690-mealnumber
                            CHANGING zssa1691.
      PERFORM get_vendor_info USING 'M'
                                    zssa1690-carrid
                                    zssa1690-mealnumber
                              CHANGING zssa1693.


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
