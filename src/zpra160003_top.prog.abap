*&---------------------------------------------------------------------*
*& Include ZPRA160003_TOP                           - Report ZPRA160003
*&---------------------------------------------------------------------*
REPORT ZPRA160003.

SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE text-t01.
  select-OPTIONS so_car for SCARR-CARRID.
  SELECT-OPTIONS so_con for sflight-connid.
  SELECT-OPTIONS so_pltype for sflight-planetype.
SELECTION-SCREEN end OF BLOCK bl1.
