*&---------------------------------------------------------------------*
*& Report ZRSA16_22
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa16_22.

DATA: gs_list TYPE scarr,
      gt_list LIKE TABLE OF gs_list.

CLEAR: gt_list , gs_list.
*SELECT *
*  FROM scarr
*  INTO CORRESPONDING FIELDS OF gs_list
*  WHERE carrid BETWEEN 'ZZ' AND 'UA'.
*  APPEND gs_list TO gt_list.
*  CLEAR gs_list.
*ENDSELECT.

*SELECT *
*  FROM scarr
*  INTO TABLE gt_list
*  WHERE carrid BETWEEN 'AA' AND 'UA'.

SELECT carrid carrname
  FROM scarr
  INTO CORRESPONDING FIELDS OF TABLE gt_list
  WHERE carrid BETWEEN 'AA' AND 'UA'.

WRITE sy-subrc.
WRITE sy-dbcnt.

cl_demo_output=>display_data( gt_list ).
