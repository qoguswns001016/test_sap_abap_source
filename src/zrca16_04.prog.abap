*&---------------------------------------------------------------------*
*& Report ZRCA16_04
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrca16_04.

PARAMETERS pa_car TYPE scarr-carrid. "char 3 => PARAMETERS pa_car TYPE c LENGTH 3.
*PARAMETERS pa_car1 TYPE c LENGTH 3.

DATA gs_info TYPE scarr.

CLEAR gs_info.
SELECT SINGLE carrid carrname
  FROM scarr
  INTO CORRESPONDING FIELDS OF gs_info " CORRESPONDING FIELDS OF  = scarr 에 필드도 똑같이 그래도 넣어줘
* INTO gs_info "필드대로 말고 앞에서 차례대로 넣어줘
 WHERE carrid = pa_car.



IF sy-subrc = 0.
  WRITE: gs_info-mandt, gs_info-carrid, gs_info-carrname.
ENDIF.
