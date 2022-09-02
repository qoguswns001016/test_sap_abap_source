*&---------------------------------------------------------------------*
*& Include ZRSA16_40_TOP                            - Report ZRSA16_40
*&---------------------------------------------------------------------*
REPORT ZRSA16_40.

DATA pa_depdname TYPE zssa1640-majid.

DATA: gs_stdinfo TYPE zssa1640,
      gt_stdinfo LIKE TABLE OF gs_stdinfo.
