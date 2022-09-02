*&---------------------------------------------------------------------*
*& Report ZPG_A16_5
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPG_A16_5.

TYPES: BEGIN OF gty_data,
  ktopl TYPE ska1-ktopl,
  ktplt TYPE t004t-ktplt,
  saknr TYPE ska1-saknr,
  saknrt TYPE skat-txt50,
  ktoks TYPE ska1-ktoks,
  ktokst TYPE t077z-txt30,
  END OF gty_data.

DATA: gs_data TYPE gty_data,
      gt_data like TABLE OF gs_data.
DATA: gs_ktplt TYPE t004t,
      gt_ktplt like TABLE OF gs_ktplt,
      gs_saknr TYPE skat,
      gt_saknr like TABLE OF gs_saknr,
      gs_ktokst TYPE t077z,
      gt_ktokst like TABLE OF gs_ktokst.

data lv_tabix TYPE sy-tabix.

clear: gs_data, gs_ktplt, gs_saknr, gs_ktokst.
REFRESH: gt_data, gt_ktplt, gt_saknr, gt_ktokst.

select ktplt
  from t004t
  into CORRESPONDING FIELDS OF TABLE gt_ktplt
  where spras = sy-langu.

select txt50
  from skat
  into CORRESPONDING FIELDS OF TABLE gt_saknr
  where spras = sy-langu.

select txt30
  from t077z
  into CORRESPONDING FIELDS OF TABLE gt_ktokst
  WHERE spras = sy-langu.

select ktopl saknr ktoks
  from ska1
  into CORRESPONDING FIELDS OF TABLE gt_data.

LOOP AT gt_data into gs_data.
  lv_tabix = sy-tabix.
  READ TABLE gt_ktplt into gs_ktplt WITH key ktopl = gs_data-ktopl.
  READ TABLE gt_saknr into gs_saknr WITH key saknr = gs_data-saknr.
  READ TABLE gt_ktokst into gs_ktokst WITH key ktoks = gs_data-ktoks.

  gs_data-ktplt = gs_ktplt-ktplt.
  gs_data-saknrt = gs_saknr-txt50.
  gs_data-ktokst = gs_ktokst-txt30.

  MODIFY gt_data from gs_data INDEX lv_tabix.

ENDLOOP.

cl_demo_output=>display_data( gt_data ).
