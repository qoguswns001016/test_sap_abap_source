*&---------------------------------------------------------------------*
*& Include          ZRSA16_52_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form set_init
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_init .
  pa_car = 'AA'.
  pa_con = '0017'.

  CLEAR: so_dat[], so_dat. " <- 는 스트럭쳐 sa_dat[] 는 배열
  so_dat-sign = 'I'.
  so_dat-option = 'BT'.
  so_dat-low = sy-datum - 365.
  so_dat-high = sy-datum.

  APPEND so_dat TO so_dat[].
*  APPEND so_dat to so_dat. 위 아래 다 같은 말이다.
*  APPEND so_dat.
  CLEAR so_dat.
ENDFORM.
