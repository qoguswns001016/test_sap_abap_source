*&---------------------------------------------------------------------*
*& Report ZPG_A16
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPG_A16.

"TYPES: BEGIN OF gty_mara,
"  matnr TYPE mara-matnr,
"  werks TYPE marc-werks,
"  mtart TYPE mara-mtart,
"  matkl TYPE mara-matkl,
"  ekgrp TYPE marc-ekgrp,
"  pstat TYPE marc-pstat,
"END OF gty_mara.

"data: gs_mara TYPE gty_mara,
"      gt_mara LIKE TABLE OF gs_mara.

"data ztsa1601 like TABLE OF gt_mara.

DATA: BEGIN OF gs_sbook.
  INCLUDE STRUCTURE sbook.
DATA: END OF gs_sbook.

DATA gt_sbook like TABLE OF gs_sbook.

select carrid connid fldate bookid customid custtype invoice class smoker
  from sbook
  into CORRESPONDING FIELDS OF table gt_sbook
  Where carrid = 'DL' AND custtype = 'P' AND order_date = '20201227'.

loop at gt_sbook into gs_sbook.
  IF gs_sbook-smoker = 'X' AND gs_sbook-invoice = 'X'.
    gs_sbook-class = 'F'.
  ENDIF.
  MODIFY gt_sbook FROM gs_sbook.
ENDLOOP.

  CALL METHOD cl_demo_output=>display_data
  EXPORTING
    value = gt_sbook.
