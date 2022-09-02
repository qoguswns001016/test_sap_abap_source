*&---------------------------------------------------------------------*
*& Report ZPR_A16_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE ZPR_A16_01_TOP                          .    " Global Data

 INCLUDE ZPR_A16_01_O01                          .  " PBO-Modules
 INCLUDE ZPR_A16_01_I01                          .  " PAI-Modules
 INCLUDE ZPR_A16_01_F01                          .  " FORM-Routines

 INITIALIZATION.



 START-OF-SELECTION.
 PERFORM get_data.
  call screen '0100'.
