*&---------------------------------------------------------------------*
*& Module Pool      SAPMZSA1604
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE mzsa1605_top.
*INCLUDE MZSA1604_TOP                            .    " Global Data

INCLUDE mzsa1605_o01.
* INCLUDE MZSA1604_O01                            .  " PBO-Modules
INCLUDE mzsa1605_i01.
* INCLUDE MZSA1604_I01                            .  " PAI-Modules
INCLUDE mzsa1605_f01.
* INCLUDE MZSA1604_F01                            .  " FORM-Routines

LOAD-OF-PROGRAM.
  PERFORM set_default CHANGING zssa0073.
