*&---------------------------------------------------------------------*
*& Report ZBC400_SA16_COMPUTE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc400_sa16_compute.

PARAMETERS pa_int1 TYPE i DEFAULT 0.
PARAMETERS pa_int2 LIKE pa_int1 DEFAULT 0.
PARAMETERS pa_op TYPE c LENGTH 1.

DATA gv_result LIKE pa_int1.

PERFORM in_result USING pa_int1 pa_int2
                  CHANGING pa_op gv_result.

*&---------------------------------------------------------------------*
*& Form in_result
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM in_result USING VALUE(p_int1)
                     VALUE(p_int2)
               CHANGING p_op p_result.

  IF pa_int1 = '' OR pa_int2 = ''.
    WRITE '숫자를 제대로 입력하십시오.'.
    EXIT.
  ELSE.
    CASE p_op.
      WHEN'+'.
        p_result = p_int1 + p_int2.
      WHEN '-'.
        p_result = p_int1 - p_int2.
      WHEN '*'.
        p_result = p_int1 * p_int2.
      WHEN '/'.
        p_result = p_int1 / p_int2.
      WHEN OTHERS.
        WRITE '연산기호를 다시 입력해주세요.'.
    ENDCASE.


    WRITE p_result.
    CLEAR p_result.


  ENDIF.
ENDFORM.

*CASE pa_op.
*  WHEN '+'.
*    IF pa_int1 = '' OR pa_int2 = ''.
*      WRITE '숫자를 제대로 입력하십시오.'.
*      EXIT.
*    ELSEIF
*      gv_result = pa_int1 + pa_int2.
*      WRITE gv_result.
*      CLEAR gv_result.
*    ENDIF.
*  WHEN '-'.
*    IF pa_int1 = '' OR pa_int2 = ''.
*      WRITE '숫자를 제대로 입력하십시오.'.
*      EXIT.
*    ELSEIF
*      gv_result = pa_int1 - pa_int2.
*      WRITE gv_result.
*      CLEAR gv_result.
*    ENDIF.
*  WHEN '*'.
*    IF pa_int1 = '' OR pa_int2 = ''.
*      WRITE '숫자를 제대로 입력하십시오.'.
*      EXIT.
*    ELSEIF
*      gv_result = pa_int1 * pa_int2.
*      WRITE gv_result.
*      CLEAR gv_result.
*    ENDIF.
*  WHEN '/'.
*    IF pa_int1 = '' OR pa_int2 = ''.
*      WRITE '숫자를 제대로 입력하십시오.'.
*      WRITE '숫자를 제대로 입력하십시오.'.
*      EXIT.
*    ELSEIF
*      gv_result = pa_int1 / pa_int2.
*      WRITE gv_result.
*      CLEAR gv_result.
*    ENDIF.
*  WHEN OTHERS.
*    WRITE '연산 기호가 아닙니다.'.
*
*ENDCASE.
