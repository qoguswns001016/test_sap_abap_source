*&---------------------------------------------------------------------*
*& Report ZRSA16_50
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE ZRSA16_50_TOP                           .    " Global Data

* INCLUDE ZRSA16_50_O01                           .  " PBO-Modules
* INCLUDE ZRSA16_50_I01                           .  " PAI-Modules
* INCLUDE ZRSA16_50_F01                           .  " FORM-Routines

INITIALIZATION.

START-OF-SELECTION.
SELECT *
  FROM ztsa1601
  INTO CORRESPONDING FIELDS OF TABLE gt_proinfo
  WHERE pernr = pa_pernr.

cl_demo_output=>display_data( gt_proinfo ).
