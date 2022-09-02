*&---------------------------------------------------------------------*
*& Report ZRSA16_06
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa16_06.
*
*PARAMETERS pa_i TYPE i.
*PARAMETERS pa_class TYPE c LENGTH 1.
*" A, B, C, D 만 입력 가능
*DATA gv_result LIKE pa_i.

* 10보다 크면 출력
* 20보다 크면 10추가로 더하세요.

*IF  pa_i < 20.
*  WRITE pa_i.
*ELSEIF pa_i > 20.
*  gv_i = pa_i + 10.
*  WRITE gv_i.
*ENDIF.

"강사님꺼
*IF pa_i > 20.
*  gv_result = pa_i + 10.
*  WRITE gv_result.
*ELSE.
*  IF pa_i > 10.
*    gv_result = pa_i.
*    WRITE gv_result.
*  ENDIF.
*ENDIF.

* 추가문제 A반 이라면, 입력한 값에 모두 100을 추가하세요
*IF pa_i > 20.
*  CLEAR gv_result.
*  gv_result = pa_i + 10.
*  IF pa_class = 'A'.
*    gv_result = gv_result + 100.
*  ENDIF.
*  WRITE gv_result.
*ELSEIF pa_i > 10.
*  CLEAR gv_result.
*  gv_result = pa_i.
*  IF pa_class = 'A'.
*    gv_result = pa_i + 100.
*  ENDIF.
*  WRITE gv_result.
*ELSE.
*  CLEAR gv_result.
*  WRITE gv_result.
*ENDIF.
*CLEAR result.

*CASE pa_class.
*  WHEN 'A'.
*    gv_result = pa_i + 100.
*  WHEN OTHERS.
*
*ENDCASE.
