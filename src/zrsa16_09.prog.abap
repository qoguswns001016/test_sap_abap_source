*&---------------------------------------------------------------------*
*& Report ZRSA16_09
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSA16_09.

DATA gv_d TYPE sy-datum.

gv_d = sy-datum - 356.

CLEAR gv_d.

IF gv_d IS INITIAL. "'0000000'.
  WRITE 'No Date'.

ENDIF.
  WRITE 'Exist Date'.

*DATA gv_cnt type.
*
*DO 10 TIMES.
*  gv_cnt = gv_cnt + 1.
*  WRITE sy-index.
*  DO 5 TIMES.
*    WRITE sy-index.
*  ENDDO.
*  WRITE sy-index.
*  NEW-LINE.
*
*ENDDO.
