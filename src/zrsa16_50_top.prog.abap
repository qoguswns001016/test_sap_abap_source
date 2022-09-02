*&---------------------------------------------------------------------*
*& Include ZRSA16_50_TOP                            - Report ZRSA16_50
*&---------------------------------------------------------------------*
REPORT ZRSA16_50.

PARAMETERS pa_pernr TYPE ztsa1601-pernr.

DATA: gs_proinfo TYPE zvsa16pro,
      gt_proinfo LIKE TABLE OF gs_proinfo.
