*&---------------------------------------------------------------------*
*& Report ZRSA16_10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSA16_10.

DATA : gv_a TYPE i,
       gv_b LIKE gv_a,
       gv_r LIKE gv_b.

gv_a = 10.
gv_b = 20.

*Subroutine
PERFORM cal USING gv_a gv_b   "나는 FORM 에 gv_a 값을 보낼거야~
            CHANGING gv_r.


WRITE gv_r.
*&---------------------------------------------------------------------*
*& Form cal
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM cal USING VALUE(p_a) "나는 로컬변수인 p_a 에 gv_a 값을 받을거야~
               VALUE(p_b)
         CHANGING
               VALUE(p_r).
  DO 9 TIMES.
      WRITE 'Party Tonight'.
     p_r = p_r + 1.

     DATA p_f TYPE i.
     p_f = 23.
  ENDDO.


  gv_r = p_a + p_b.
ENDFORM.
