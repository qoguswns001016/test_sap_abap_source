*&---------------------------------------------------------------------*
*& Include SAPMZSA1602_TOP                          - Module Pool      SAPMZSA1602
*&---------------------------------------------------------------------*
PROGRAM SAPMZSA1602.

*DATA: BEGIN OF gs_cond,
*  carrid TYPE sflight-carrid,
*  connid TYPE sflight-connid,
*  END OF gs_cond.

"Condition
"Use Screen
TABLES zssa1660. "Global.
"Use ABAP
DATA gs_cond TYPE ZSSA1660. "구조는 다르지만 똑같은 변수다 (위에랑) 위에는 화면에 인터페이스를 하고 이거는 x
DATA ok_code LIKE sy-ucomm.
