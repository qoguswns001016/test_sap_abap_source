*&---------------------------------------------------------------------*
*& Module Pool      SAPMZSA1604
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE MZSA1604_TOP                            .    " Global Data

 INCLUDE MZSA1604_O01                            .  " PBO-Modules
 INCLUDE MZSA1604_I01                            .  " PAI-Modules
 INCLUDE MZSA1604_F01                            .  " FORM-Routines

 LOAD-OF-PROGRAM.
 PERFORM set_default CHANGING zssa0073.
 CLEAR: gv_r1, gv_r2, gv_r3.
 gv_r2 = 'X'.
