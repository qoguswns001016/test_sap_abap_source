*&---------------------------------------------------------------------*
*& Report ZRSA16_14
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa16_14.

* Transoarent Table = Structure Type
DATA gs_scarr TYPE scarr.

PARAMETERS pa_carr LIKE gs_scarr-carrid.

SELECT SINGLE carrid carrname currcode
    FROM scarr
    INTO gs_scarr
  WHERE carrid = pa_carr.

  WRITE : gs_scarr, gs_scarr-carrname , gs_scarr-currcode.

*TYPES: BEGIN OF ts_cat,
*         home TYPE c LENGTH 10,
*         name TYPE c LENGTH 10,
*         age  TYPE i,
*       END OF ts_cat.


*DATA : gv_cat_name TYPE c LENGTH 10,
*       gv_cat_age  TYPE i.
*
*DATA: BEGIN OF gs_cat,
*        name TYPE c LENGTH 10,
*        age  TYPE i,
*      END OF gs_cat.
