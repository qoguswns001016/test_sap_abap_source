*&---------------------------------------------------------------------*
*& Include ZBC405_A16_2_TOP                         - Report ZBC405_A16_2
*&---------------------------------------------------------------------*
REPORT zbc405_a16_2.

TABLES dv_flights.


SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-t01.

  SELECT-OPTIONS: s_carrid FOR dv_flights-carrid,
                  s_connid FOR dv_flights-connid,
                  s_fldate FOR dv_flights-fldate.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF line.

  SELECTION-SCREEN COMMENT 4(15) TEXT-t03.
  PARAMETERS pa_rad1 RADIOBUTTON GROUP rd1.
  SELECTION-SCREEN COMMENT 30(16) TEXT-t04.
  PARAMETERS pa_rad2 RADIOBUTTON GROUP rd1.
  SELECTION-SCREEN COMMENT 60(14) TEXT-t05.
  PARAMETERS pa_rad3 RADIOBUTTON GROUP rd1.

SELECTION-SCREEN END OF line.
