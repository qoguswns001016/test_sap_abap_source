*&---------------------------------------------------------------------*
*& Report ZPG_A16_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpg_a16_2.

TYPES: BEGIN OF gty_mara,
         matnr TYPE mara-matnr,
         maktx TYPE makt-maktx,
         mtart TYPE mara-mtart,
         matkl TYPE mara-matkl,
       END OF gty_mara.

DATA: gs_mara TYPE gty_mara,
      gt_mara LIKE TABLE OF gs_mara.

TYPES: BEGIN OF gty_makt,
         matnr TYPE makt-matnr,
         maktx TYPE makt-maktx,
       END OF gty_makt.

DATA: gs_makt TYPE gty_makt,
      gt_makt LIKE TABLE OF gs_makt.

DATA lv_tabix TYPE sy-tabix.

clear: gs_makt , gs_mara.
REFRESH: gt_makt , gt_mara.

SELECT matnr maktx
  FROM makt
  INTO CORRESPONDING FIELDS OF TABLE gt_makt
  WHERE spras = sy-langu.

SELECT matnr mtart matkl
  FROM mara
  INTO CORRESPONDING FIELDS OF TABLE gt_mara.

LOOP AT gt_mara INTO gs_mara.
  lv_tabix = sy-tabix.
  READ TABLE gt_makt INTO gs_makt WITH KEY matnr = gs_mara-matnr.
  gs_mara-maktx = gs_makt-maktx.
  MODIFY gt_mara FROM gs_mara INDEX lv_tabix TRANSPORTING maktx.
ENDLOOP.


cl_demo_output=>display_data( gt_mara ).
