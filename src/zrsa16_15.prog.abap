*&---------------------------------------------------------------------*
*& Report ZRSA16_15
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa16_15.

DATA : BEGIN OF gs_std,
         stdno    TYPE n LENGTH 8,
         sname    TYPE c LENGTH 40,
         gender   TYPE c LENGTH 1,
         gender_t TYPE c LENGTH 10,
       END OF gs_std.

DATA gt_std LIKE TABLE OF gs_std.


gs_std-stdno = '20220001'.
gs_std-sname = 'Kang'.
gs_std-gender = 'M'.
APPEND gs_std TO gt_std.
CLEAR gs_std.

gs_std-stdno = '20220002'.
gs_std-sname = 'Han'.
gs_std-gender = 'F'.
APPEND gs_std TO gt_std.
CLEAR gs_std.

LOOP AT gt_std INTO gs_std.
  gs_std-gender_t = 'Male'(t01).
  MODIFY gt_std FROM gs_std. "index sy-tabix.

  CLEAR gs_std.
ENDLOOP.

cl_demo_output=>display_data( gt_std ).

CLEAR gs_std.
*READ TABLE gt_std INDEX 1 INTO gs_std.
READ TABLE gt_std WITH KEY stdno = '20200001'
*                           gender = 'M'
INTO gs_std.

*LOOP AT gt_std INTO gs_std.
*  WRITE: sy-tabix, gs_std-stdno,
*  gs_std-sname, gs_std-gender.
*  NEW-LINE.
*  CLEAR gs_std.
*ENDLOOP.
*WRITE: / sy-tabix, gs_std-stdno,
*         gs_std-sname , gs_std-gender.
