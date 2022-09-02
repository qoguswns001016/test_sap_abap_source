*&---------------------------------------------------------------------*
*& Include ZPR_A16_01_TOP                           - Report ZPR_A16_01
*&---------------------------------------------------------------------*
REPORT ZPR_A16_01.

TABLES ztsa1601.

SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME title text-t01.
  select-OPTIONS so_pernr for ztsa1601-pernr.

SELECTION-SCREEN END OF block bl1.

DATA: gs_data type ztsa1601,
      gt_data like TABLE OF gs_data.

"ALV DATA

DATA: gcl_container TYPE REF TO cl_gui_docking_container,
      gcl_grid TYPE REF TO cl_gui_alv_grid,
      gs_fcat TYPE lvc_s_fcat,
      gt_fcat type lvc_t_fcat,
      gs_layout TYPE lvc_s_layo,
      gs_variant TYPE disvariant,
      gs_stable TYPE lvc_s_stbl.

data gv_okcode TYPE sy-ucomm.
