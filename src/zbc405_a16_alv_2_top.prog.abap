*&---------------------------------------------------------------------*
*& Include ZBC405_A16_ALV_2_TOP                     - Report ZBC405_A16_ALV_2
*&---------------------------------------------------------------------*
REPORT zbc405_a16_alv_2.

TABLES ztsbook_a16.

SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME.
  SELECT-OPTIONS : so_car FOR ztsbook_a16-carrid OBLIGATORY MEMORY ID car,
                   so_con FOR ztsbook_a16-connid MEMORY ID con,
                   so_fld FOR ztsbook_a16-fldate,
                  so_cus FOR ztsbook_a16-customid.
  SELECTION-SCREEN SKIP 2.
  PARAMETERS p_layout TYPE disvariant-variant.
SELECTION-SCREEN END OF BLOCK bl1.




TYPES BEGIN OF ts_sbook.
    INCLUDE TYPE ztsbook_a16.
TYPES: light type c LENGTH 1,
       telephone TYPE ztscustom_a16-telephone,
       email TYPE ztscustom_a16-email,
       row_color TYPE c LENGTH 4,
       it_color TYPE lvc_t_col.
TYPES : END OF ts_sbook.

DATA : gs_sbook TYPE ts_sbook,
       gt_sbook TYPE TABLE of ts_sbook.

DATA: ok_code TYPE sy-ucomm.

*-- FOR ALV 변수
DATA: go_container TYPE REF TO cl_gui_custom_container,
      go_alv       TYPE REF TO cl_gui_alv_grid.

DATA: gs_variant TYPE disvariant,
      gs_layout  TYPE lvc_s_layo,
      gt_sort TYPE lvc_t_sort,
      gs_sort TYPE lvc_s_sort,
      gs_color TYPE lvc_s_scol,
      gt_exct TYPE  ui_functions,
      gt_fcat TYPE lvc_t_fcat,
      gs_fcat TYPE lvc_s_fcat.
