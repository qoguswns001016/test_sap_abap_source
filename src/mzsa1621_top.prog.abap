*&---------------------------------------------------------------------*
*& Include MZSA1621_TOP                             - Module Pool      SAPMZSA1621
*&---------------------------------------------------------------------*
PROGRAM SAPMZSA1621.

DATA ok_code TYPE sy-ucomm.
DATA gv_subrc TYPE sy-subrc.
DATA gv_dynnr TYPE sy-dynnr.

"Employee Info
TABLES zssa1670_emp.

"Department Info
TABLES zssa1671_dep.

"Condition
TABLES zssa1673.

"Control
CONTROLS em_info TYPE TABSTRIP.
