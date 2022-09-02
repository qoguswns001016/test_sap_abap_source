*&---------------------------------------------------------------------*
*& Report ZPRA160002
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE ZPRA160002_TOP                          .    " Global Data

 INCLUDE ZPRA160002_O01                          .  " PBO-Modules
 INCLUDE ZPRA160002_I01                          .  " PAI-Modules
 INCLUDE ZPRA160002_F01                          .  " FORM-Routines

 INITIALIZATION.


 START-OF-SELECTION.
 PERFORM get_data.

 call screen '0100'.
