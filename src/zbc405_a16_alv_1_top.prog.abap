*&---------------------------------------------------------------------*
*& Include ZBC405_A20_ALV_TOP                       - Report ZBC405_A20_ALV
*&---------------------------------------------------------------------*
REPORT zbc405_a20_alv.

"Common Variable
DATA ok_code LIKE sy-ucomm.

*DATA: gt_flt TYPE TABLE OF sflight,
*      gs_flt TYPE sflight.

TYPES: BEGIN OF ts_flt.
         INCLUDE TYPE sflight.
TYPES:   changes_possible TYPE icon-id,
         btn_text         TYPE c LENGTH 10,
         light            TYPE c LENGTH 1,
         row_color        TYPE c LENGTH 4,
         it_color         TYPE lvc_t_scol,
         it_styl          TYPE lvc_t_styl,
         tankcap          TYPE saplane-tankcap,
         cap_unit         TYPE saplane-cap_unit,
         weight           TYPE saplane-weight,
         wei_unit         TYPE saplane-wei_unit,
       END OF ts_flt.

DATA : gs_flt TYPE ts_flt,
       gt_flt LIKE TABLE OF gs_flt.


"ALV DATA 선언
DATA : go_container TYPE REF TO cl_gui_custom_container,  "SCREEN에 container 를 만들어줌.
       go_alv_grid  TYPE REF TO cl_gui_alv_grid,             "ALV를 위한 GRID
       gs_variant   TYPE disvariant,
       gv_save(1),
       gs_layout    TYPE lvc_s_layo,
       gt_sort      TYPE lvc_t_sort,
       gt_exct      TYPE ui_functions,

       gt_fcat      TYPE lvc_t_fcat,
       gs_fcat      TYPE lvc_s_fcat,
       gs_sort      LIKE LINE OF gt_sort,
       gs_color     TYPE lvc_s_scol,
       gs_styl      TYPE lvc_s_styl.





"Selection Screen
SELECT-OPTIONS : so_car FOR gs_flt-carrid MEMORY ID car,
                 so_con FOR gs_flt-connid MEMORY ID con,
                 so_dat FOR gs_flt-fldate.

SELECTION-SCREEN SKIP 3.          "3줄의 공백
PARAMETERS p_date TYPE sy-datum DEFAULT '20201001'.

PARAMETERS : pa_lv TYPE disvariant-variant.
"disvariant의 variant 값을 받음?
