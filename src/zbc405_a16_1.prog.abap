*&---------------------------------------------------------------------*
*& Report ZBC405_A20_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE ZBC405_A16_1_TOP.
*INCLUDE zbc405_a20_1_top                        .    " Global Data
INCLUDE ZBC405_A16_1_E01.
*INCLUDE zbc405_a20_e01                          .    "Extra

* INCLUDE ZBC405_A20_1_O01                        .  " PBO-Modules
* INCLUDE ZBC405_A20_1_I01                        .  " PAI-Modules
* INCLUDE ZBC405_A20_1_F01                        .  " FORM-Routines


INITIALIZATION.
  so_flda-low = sy-datum.
  so_flda-high = sy-datum + 30.
  so_flda-sign = 'I'.
  so_flda-option = 'BT'.

  APPEND so_flda.


  LOOP AT SCREEN.
    IF screen-group1 = 'MOD'.
      screen-input = 0.
      screen-output = 1.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.


AT SELECTION-SCREEN.
  CASE 'X'.
    WHEN p_rad1.
    WHEN p_rad2.
      MESSAGE i016(pn) WITH 'radio 2'.
    WHEN p_rad3.
  ENDCASE.

  " type 뒤에 data element, structure, table type

*set parameter id car field p_car.
*set parameter id 'Z01' field p_car.
*set parameter id 'Z01' field p_car.
