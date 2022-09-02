*&---------------------------------------------------------------------*
*& Include ZPRA160002_TOP                           - Report ZPRA160002
*&---------------------------------------------------------------------*
REPORT zpra160002.

DATA ok_code TYPE sy-ucomm.

SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE TEXT-t01.
  PARAMETERS: pa_werks TYPE mast-werks DEFAULT '1010',
              pa_matnr TYPE mast-matnr.
SELECTION-SCREEN END OF BLOCK bl1.

TYPES: BEGIN OF gty_data,
         matnr TYPE mast-matnr,
         maktx TYPE makt-maktx,
         stlan TYPE mast-stlan,
         stlnr TYPE mast-stlnr,
         stlal TYPE mast-stlal,
         mara  TYPE mtart,
         matkl TYPE mara-matkl,
       END OF gty_data.

DATA: gs_data TYPE gty_data,
      gt_data LIKE TABLE OF gs_data.

"ALV DATA

DATA: gcl_container TYPE REF TO cl_gui_docking_container,
      gcl_grid      TYPE REF TO cl_gui_alv_grid.

DATA: gs_fcat    TYPE lvc_s_fcat,
      gt_fcat    TYPE lvc_t_fcat,
      gs_layout  TYPE lvc_s_layo,
      gs_variant TYPE disvariant.
