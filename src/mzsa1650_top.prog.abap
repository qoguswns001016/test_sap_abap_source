*&---------------------------------------------------------------------*
*& Include MZSA1650_TOP                             - Module Pool      SAPMZSA1650
*&---------------------------------------------------------------------*
PROGRAM sapmzsa1650.

DATA: ok_code  TYPE sy-ucomm,
      gv_subrc TYPE sy-subrc,
      gv_dynnr TYPE sy-dynnr.

"Vendor Condition
TABLES zssa16ven_con.

"Meal Info
TABLES zssa16meal.

"Vendor Info
TABLES zssa16ven.

"Control

CONTROLS ven_info TYPE TABSTRIP.
