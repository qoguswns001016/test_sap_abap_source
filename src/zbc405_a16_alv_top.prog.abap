*&---------------------------------------------------------------------*
*& Include ZBC405_A16_ALV_TOP                       - Report ZBC405_A16_ALV
*&---------------------------------------------------------------------*
REPORT zbc405_a16_alv.

TYPES: BEGIN OF typ_fit.
         INCLUDE TYPE sflight.
TYPES: light,
       END OF typ_fit.

DATA: gt_fit  TYPE TABLE OF typ_fit,
      gs_fit  TYPE typ_fit,
      ok_code LIKE sy-ucomm.

* ALV DATA 선언
DATA: go_container TYPE REF TO cl_gui_custom_container,
      go_alv_grid  TYPE REF TO cl_gui_alv_grid,
      gv_variant   TYPE disvariant,
      gv_save,
      gs_layout    TYPE lvc_s_layo,
      gt_sort      TYPE lvc_t_sort,
      gs_sort      TYPE lvc_s_sort.

* selection-screen

SELECT-OPTIONS: so_car FOR gs_fit-carrid MEMORY ID car,
                so_con FOR gs_fit-connid MEMORY ID con,
                so_dat FOR gs_fit-fldate.

SELECTION-SCREEN SKIP 1.
PARAMETERS: pa_lv TYPE disvariant-variant.
