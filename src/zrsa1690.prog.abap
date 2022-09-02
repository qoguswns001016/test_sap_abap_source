*&---------------------------------------------------------------------*
*& Report ZRSA1690
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSA1690.

TABLES ztsa1699.

DATA gs_info LIKE zssa1693.
DATA gt_info LIKE TABLE OF gs_info.

PARAMETERS pa_carr TYPE ztsa1699-carrid.
SELECT-OPTIONS s_meal FOR ztsa1699-mealnumber.
PARAMETERS pa_venca as LISTBOX VISIBLE LENGTH 20.

INITIALIZATION.

AT SELECTION-SCREEN OUTPUT.

AT SELECTION-SCREEN.

START-OF-SELECTION.
