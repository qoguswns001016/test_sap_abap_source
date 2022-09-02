*&---------------------------------------------------------------------*
*& Report ZPG_A16_3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpg_a16_3.

TYPES: BEGIN OF gty_spfli,
         carrid   TYPE spfli-carrid,
         carrname TYPE scarr-carrname,
         url      TYPE scarr-url,
         connid   TYPE spfli-connid,
         airpfrom TYPE spfli-airpfrom,
         airpto   TYPE spfli-airpto,
         deptime  TYPE spfli-deptime,
         arrtime  TYPE spfli-arrtime,
       END OF gty_spfli.

TYPES: BEGIN OF gty_scarr,
         carrid   TYPE scarr-carrid,
         carrname TYPE scarr-carrname,
         url      TYPE scarr-url,
       END OF gty_scarr.

DATA: gs_spfli TYPE gty_spfli,
      gt_spfli LIKE TABLE OF gs_spfli,
      gs_scarr TYPE gty_scarr,
      gt_scarr LIKE TABLE OF gs_scarr.

DATA lv_tabix TYPE sy-tabix.

clear: gs_spfli, gs_scarr.
REFRESh: gt_spfli, gt_scarr.

select carrid connid airpfrom airpto deptime arrtime
  from spfli
  into CORRESPONDING FIELDS OF TABLE gt_spfli.

select carrid carrname url
  from scarr
  into CORRESPONDING FIELDS OF TABLE gt_scarr.

LOOP AT gt_spfli into gs_spfli.
 lv_tabix = sy-tabix.
READ TABLE gt_scarr into gs_scarr WITH key carrid = gs_spfli-carrid.
  gs_spfli-carrname = gs_scarr-carrname.
  gs_spfli-url = gs_scarr-url.
  MODIFY gt_spfli from gs_spfli INDEX lv_tabix TRANSPORTING carrname url.
  clear: gs_spfli, gs_scarr.

ENDLOOP.

cl_demo_output=>display_data( gt_spfli ).
