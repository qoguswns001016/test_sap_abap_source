*&---------------------------------------------------------------------*
*& Include          YCL1A16_001_SCR
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b01 WITH FRAME TITLE textt01.

SELECT-OPTIONS so_car for gs_scarr-carrid.
SELECT-OPTIONS so_carnm for scarr-carrname.

selection-screen END OF BLOCK b01.
