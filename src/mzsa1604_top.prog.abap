*&---------------------------------------------------------------------*
*& Include MZSA1604_TOP                             - Module Pool      SAPMZSA1604
*&---------------------------------------------------------------------*
PROGRAM SAPMZSA1604.

" Condition
TABLES zssa0073.
DATA gs_cond TYPE zssa0073.

" Employee Info
TABLES zssa0070.
DATA gs_emp TYPE zssa0070.

" Dep Info
TABLES zssa0071.
DATA gs_dep TYPE zssa0071.

"Radio Button

DATA: gv_r1 TYPE c LENGTH 1,
      gv_r2(1),
      gv_r3.
