*&---------------------------------------------------------------------*
*& Report ZRCA16_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrca16_02.
PARAMETERS pa_step TYPE i.
PARAMETERS pa_syear(1) TYPE c.
DATA gv_step2 LIKE pa_step.
DATA gv_cal LIKE gv_step2.
DATA gv_step1 LIKE gv_cal.
DATA gv_new_lev LIKE gv_step1.

CASE pa_syear.
  WHEN '1'.
    IF pa_step >= 3.
      gv_new_lev = 3.
    ELSE.
      gv_new_lev = pa_step.
    ENDIF.
  WHEN '2'.
    If pa_step >= 5.
      gv_new_lev = 5.
    ELSE.
      gv_new_lev = pa_step.
    ENDIF.
  WHEN '3'.
    if pa_step >= 7.
      gv_new_lev = 7.
    ELSE.
      gv_new_lev = pa_step.
    ENDIF.
  WHEN: '4' , '5'.
    if pa_step >= 9.
      gv_new_lev = 9.
    ELSE.
      gv_new_lev = pa_step.
    ENDIF.
  WHEN '6'.
      gv_new_lev = 9.
  WHEN OTHERS.


ENDCASE.


DO gv_new_lev TIMES.
  gv_step1 = gv_step1 + 1.
  CLEAR gv_step2.
  DO 9 TIMES.
    gv_step2 = gv_step2 + 1.
    gv_cal = gv_step1 * gv_step2.
    WRITE: gv_step1 ,'*', gv_step2, '=', gv_cal.
    NEW-LINE.
  ENDDO.
  WRITE '----------------------------------------'.
  NEW-LINE.
  CLEAR gv_step2.
  CLEAR gv_cal.
ENDDO.
CLEAR gv_step1.
