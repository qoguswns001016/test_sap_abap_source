*&---------------------------------------------------------------------*
*& Include ZRSA16_25_TOP                            - Report ZRSA16_25
*&---------------------------------------------------------------------*
REPORT zrsa16_25.

*TYPE 선언

TYPES: BEGIN OF ts_info,
         carrid   TYPE zssa1603-carrid,
         connid   TYPE zssa1603-connid,
         cityfrom TYPE zssa1603-cityfrom,
         cityto   TYPE zssa1603-cityto,
         fldate   TYPE zssa1603-fldate,
       END OF ts_info,

       tt_info TYPE TABLE OF ts_info.

*DATA 선언 (DATA Object)
DATA: gt_info TYPE tt_info,
      gs_info LIKE LINE OF gt_info.



*Selection SCreen

PARAMETERS: pa_car  TYPE zssa1603-carrid.
*            pa_con1 TYPE sflight-connid,
*            pa_con2 TYPE sflight-connid.

SELECT-OPTIONS so_con FOR gs_info-connid.








*PARAMETERS: pa_car  TYPE sbook-carrid,
*            pa_con1 TYPE sbook-connid,
*            pa_con2 LIKE pa_con1.
*
*
*DATA: BEGIN OF gs_info,
*        carrid     TYPE sflight-carrid,
*        carrname   TYPE scarr-carrname,
*        connid     TYPE sflight-connid,
*        cityfrom   TYPE spfli-cityfrom,
*        cityto     TYPE spfli-cityto,
*        fldate     TYPE sflight-fldate,
*        price      TYPE sflight-price,
*        currency   TYPE sflight-currency,
*        seatsocc   TYPE sflight-seatsocc,
*        seatsmax   TYPE sflight-seatsmax,
*        seatsocc_b TYPE sflight-seatsocc_b,
*        seatsmax_b TYPE sflight-seatsmax_b,
*        seatsocc_f TYPE sflight-seatsocc_f,
*        seatsmax_f TYPE sflight-seatsmax_f,
*        seat_e     TYPE c LENGTH 3,
*        seat_b     TYPE c LENGTH 3,
*        seat_f     TYPE c LENGTH 3,
*      END OF gs_info.
*DATA gt_info LIKE TABLE OF gs_info.
