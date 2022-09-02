*&---------------------------------------------------------------------*
*& Include MZSA0010_TOP                             - Module Pool      SAPMZSA0010
*&---------------------------------------------------------------------*
PROGRAM sapmzsa0010.

"Common Variable
DATA ok_code TYPE sy-ucomm.
DATA gv_subrc TYPE sy-subrc. "0 / 0 <>
DATA gv_dynnr TYPE sy-dynnr.

"Condition
TABLES zssa0080. "Use Screen
" Use ABAP
*DATA gs_cond TYPE zssa0080.

" Airline Info
TABLES zssa0081.
*DATA gs_airline TYPE zssa0081.

" Connction Info
TABLES zssa0082.
*DATA gs_conn TYPE zssa0082.

" Tab Strip
CONTROLS ts_info TYPE TABSTRIP.
