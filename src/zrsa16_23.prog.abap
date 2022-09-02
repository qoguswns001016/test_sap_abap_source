*&---------------------------------------------------------------------*
*& Report ZRSA16_23
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa16_23.

DATA gt_info TYPE TABLE OF zsinfo.
DATA gs_info LIKE LINE OF gt_info.

PARAMETERS aircode1 TYPE zsinfo-carrid.
PARAMETERS aircode2 LIKE aircode1.

SELECT carrid connid cityfrom cityto
  FROM spfli
  INTO CORRESPONDING FIELDS OF TABLE gt_info
  WHERE carrid BETWEEN aircode1 AND aircode2.

cl_demo_output=>display_data( gt_info ).
