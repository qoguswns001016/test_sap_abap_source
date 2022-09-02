*&---------------------------------------------------------------------*
*& Report ZRSAMEN02_16
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsamen02_16.

TABLES zssamen02.

TYPES: BEGIN OF ts_flt.
    INCLUDE TYPE sflight.
TYPES: carrname TYPE scarr-carrname,
END OF ts_flt.

DATA: gt_flt TYPE TABLE of ts_flt,
      gs_flt TYPE ts_flt.

DATA: gt_flt2 TYPE TABLE of ts_flt,
      gs_flt2 TYPE ts_flt.

*DATA 선언
DATA gs_con TYPE zssamen02.
DATA ok_code LIKE sy-ucomm.
DATA: gs_fcat TYPE lvc_s_fcat,
      gt_fcat TYPE lvc_t_fcat.
*ALV DATA
DATA: go_alv_grid TYPE ref to cl_gui_alv_grid,
      gv_variant   TYPE disvariant,
      go_container TYPE REF TO cl_gui_custom_container,
      gs_layout TYPE lvc_s_layo,
      gt_sort TYPE lvc_t_sort,
      gs_sort LIKE LINE OF gt_sort.




SELECTION-SCREEN BEGIN OF BLOCK con WITH FRAME.
SELECT-OPTIONS : so_carr for gs_con-carrid,
                 so_con for gs_con-connid,
                 so_date for gs_con-fldate.
SELECTION-SCREen END OF BLOCK con.
INCLUDE zrsamen02_16_class.
include zrsamen02_16_e01.
INCLUDE zrsamen02_16_F01.
