*&---------------------------------------------------------------------*
*& Include ZBC405_A16_EXAM_TOP                      - Report ZBC405_A16_EXAM
*&---------------------------------------------------------------------*
REPORT zbc405_a16_exam.

TABLES ztspfli_a16.
TABLES sairport.

SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE TEXT-t01.
  SELECT-OPTIONS so_car FOR ztspfli_a16-carrid MEMORY ID car.
  SELECT-OPTIONS so_con FOR ztspfli_a16-connid.
SELECTION-SCREEN END OF BLOCK bl1.

*ALV
DATA : go_container TYPE REF TO cl_gui_custom_container,
       go_alv       TYPE REF TO cl_gui_alv_grid.

DATA: gs_variant TYPE disvariant,
      gv_save    TYPE c LENGTH 1,
      gs_layout  TYPE lvc_s_layo,
      gt_sort    TYPE lvc_t_sort,
      gs_sort    LIKE LINE OF gt_sort,
      gt_fcat    TYPE lvc_t_fcat,
      gs_fcat    LIKE LINE OF gt_fcat,
      gs_color   TYPE lvc_s_scol,
      gt_exct    TYPE ui_functions,
      gs_exct  LIKE LINE OF gt_exct.

SELECTION-SCREEN BEGIN OF BLOCK bl2 WITH FRAME.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(11) TEXT-t02.
    PARAMETERS pa_var LIKE gs_variant-variant.
    SELECTION-SCREEN COMMENT pos_high(15) TEXT-t03.
    PARAMETERS pa_edit AS CHECKBOX USER-COMMAND edit.
  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK bl2.

DATA ok_code TYPE sy-ucomm.

TYPES BEGIN OF ts_spfli.
INCLUDE TYPE ztspfli_a16.
TYPES: countid    TYPE c LENGTH 1,
       ficon      TYPE icon-id,
       light      TYPE c LENGTH 1,
       row_color  TYPE c LENGTH 1,
       it_color   TYPE lvc_t_scol,
       to_tzone   TYPE c LENGTH 6,
       from_tzone TYPE c LENGTH 6,
       mo_check   TYPE c LENGTH 1,

       END OF ts_spfli.

DATA: gs_spfli TYPE ts_spfli,
      gt_spfli LIKE TABLE OF gs_spfli,
      gs_airp  TYPE sairport,
      gt_airp  LIKE TABLE OF gs_airp.
