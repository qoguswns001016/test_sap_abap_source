*&---------------------------------------------------------------------*
*& Include MZSA1602_1_TOP                           - Module Pool      SAPMZSA1602_1
*&---------------------------------------------------------------------*
PROGRAM SAPMZSA1602_1.

TABLES: ztsa1601, ztsa1602, ztsa1602_t.

DATA: gv_pernr LIKE ztsa1601-pernr,
      gv_date LIKE ztsa1601-entdt,
      gv_ename LIKE ztsa1601-ename,
      gv_gender LIKE ztsa1601-gender.
