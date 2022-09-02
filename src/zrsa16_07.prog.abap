*&---------------------------------------------------------------------*
*& Report ZRSA16_07
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa16_07.

PARAMETERS pa_date TYPE sy-datum.
DATA gv_date LIKE pa_date.
PARAMETERS pa_class TYPE c LENGTH 4.
DATA gv_class TYPE string  VALUE 'ABAP Workbench'.

WRITE pa_date.

gv_date = pa_date.

WRITE gv_date.

IF pa_class = 'SYNC'.
  IF gv_date >= '20220721'.
    gv_class = 'ABAP Dictionary'.
    WRITE gv_class.
    CLEAR pa_date.
    CLEAR gv_class.

  ELSEIF pa_date >= '20230714'.
    gv_class = '취업'.
    WRITE gv_class.
    CLEAR pa_date.
    CLEAR gv_class.

  ELSEIF pa_date <= '20220707'.
    gv_class = 'SAPUI5'.
    WRITE gv_class.
    CLEAR pa_date.
    CLEAR gv_class.
  ELSE.
    WRITE '교육 준비중.'.
  ENDIF.
ELSE.
    WRITE '다음 기회에 수강.'.
ENDIF.
