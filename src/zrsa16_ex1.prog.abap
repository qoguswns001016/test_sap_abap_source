*&---------------------------------------------------------------------*
*& Report ZRSA16_EX1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE ZRSA16_EX1_TOP                          .    " Global Data

* INCLUDE ZRSA16_EX1_O01                          .  " PBO-Modules
* INCLUDE ZRSA16_EX1_I01                          .  " PAI-Modules
 INCLUDE ZRSA16_EX1_F01                          .  " FORM-Routines

 INITIALIZATION.
 gs_info-depno = 'D002'.
 gs_info-dname = 'Cleaner'.
 gs_info-depph = 00101010.

 APPEND gs_info to gt_info.
 START-OF-SELECTION.

 cl_demo_output=>display_data( gt_info ).
