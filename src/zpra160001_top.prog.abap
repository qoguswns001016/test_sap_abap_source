*&---------------------------------------------------------------------*
*& Include ZPRA160001_TOP                           - Report ZPRA160001
*&---------------------------------------------------------------------*
REPORT zpra160001.

DATA ok_code TYPE sy-ucomm.
TABLES: mara, marc.

SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE TEXT-t01.
  PARAMETERS: pa_mkal  TYPE mkal-werks DEFAULT '1010',
              pa_berid TYPE pbid-berid DEFAULT '1010',
              pa_pbdnr TYPE pbid-pbdnr,
              pa_versb TYPE pbid-versb DEFAULT '00'.
SELECTION-SCREEN END OF BLOCK bl1.

SELECTION-SCREEN BEGIN OF BLOCK bl2 WITH FRAME TITLE TEXT-t02.
  PARAMETERS pa_crt RADIOBUTTON GROUP rg1 DEFAULT'X' USER-COMMAND mod.
  PARAMETERS pa_disp RADIOBUTTON GROUP rg1.
SELECTION-SCREEN END OF BLOCK bl2.

SELECTION-SCREEN BEGIN OF BLOCK bl3 WITH FRAME TITLE TEXT-t03.
  SELECT-OPTIONS: so_matnr FOR mara-matnr MODIF ID mar,
                  so_mtart FOR mara-mtart MODIF ID mar,
                  so_matkl FOR mara-matkl MODIF ID mar.

  SELECT-OPTIONS: so_ekgrp FOR marc-ekgrp MODIF ID mac.
  PARAMETERS: pa_dispo TYPE marc-dispo MODIF ID mac,
              pa_dismm TYPE marc-dismm MODIF ID mac.

SELECTION-SCREEN END OF BLOCK bl3.

AT SELECTION-SCREEN OUTPUT.
  PERFORM modify_screen.

  DATA: gcl_container TYPE REF TO cl_gui_docking_container,
        gcl_grid      TYPE REF TO cl_gui_alv_grid,
        gs_fcat       TYPE lvc_s_fcat,
        gt_fcat       TYPE lvc_t_fcat,
        gs_layout     TYPE lvc_s_layo.
