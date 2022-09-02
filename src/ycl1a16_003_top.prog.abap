*&---------------------------------------------------------------------*
*& Include          YCL1A16_002_TOP
*&---------------------------------------------------------------------*

DATA : ok_code TYPE sy-ucomm,
       save_ok TYPE sy-ucomm.

TABLES scarr.

DATA: gt_scarr TYPE TABLE OF scarr.

SELECTION-SCREEN BEGIN OF SCREEN 0101 AS SUBSCREEN.
  SELECTION-SCREEN BEGIN OF BLOCK b01 WITH FRAME TITLE TEXT-t01.
    SELECT-OPTIONS s_carrid FOR scarr-carrid.
    SELECT-OPTIONS s_carrnm FOR scarr-carrname.
    SELECTION-SCREEN PUSHBUTTON /1(20) TEXT-l01 USER-COMMAND search.
  SELECTION-SCREEN END OF BLOCK b01.
SELECTION-SCREEN END OF SCREEN 0101.
