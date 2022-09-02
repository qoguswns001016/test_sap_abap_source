*&---------------------------------------------------------------------*
*& Report ZRSA1610
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa1610.

DATA: BEGIN OF gs_info,
        carrid    TYPE spfli-carrid,
        carrname  TYPE scarr-carrname,
        connid    TYPE spfli-connid,
        countryfr TYPE spfli-countryfr,
        countryto TYPE spfli-countryto,
        atype     TYPE c LENGTH 10,
      END OF gs_info.

DATA gt_info LIKE TABLE OF gs_info.

cl_demo_output=>display_data( gt_info ).
