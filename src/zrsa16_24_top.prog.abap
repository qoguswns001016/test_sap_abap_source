*&---------------------------------------------------------------------*
*& Include ZRSA16_24_TOP                            - Report ZRSA16_24
*&---------------------------------------------------------------------*
REPORT zrsa16_24.


" Sch Date Info
DATA: gt_info TYPE TABLE OF zsinfo00,
      gs_info LIKE LINE OF gt_info.

PARAMETERS: pa_car TYPE sbook-carrid,
            pa_con TYPE sbook-connid.
