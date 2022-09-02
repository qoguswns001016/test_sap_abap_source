*&---------------------------------------------------------------------*
*& Report ZRCA16_EX01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrca16_ex01.

PARAMETERS pa_dan TYPE i.
PARAMETERS pa_gd LIKE pa_dan.
DATA gv_num1 TYPE i.
DATA gv_num2 LIKE gv_num1.
DATA gv_total LIKE gv_num2.

DO pa_dan TIMES.
  gv_num1 = gv_num1 + 1.
  DO 9 TIMES.
    gv_num2 = gv_num2 + 1.
    gv_total = gv_num1 * gv_num2.
    NEW-LINE.
    WRITE gv_total.
  ENDDO.
  CLEAR gv_total.
  CLEAR gv_num2.
ENDDO.
