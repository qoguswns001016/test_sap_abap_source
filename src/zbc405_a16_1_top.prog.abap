*&---------------------------------------------------------------------*
*& Include ZBC405_A20_1_TOP                         - Report ZBC405_A20_1
*&---------------------------------------------------------------------*
REPORT zbc405_a20_1.

DATA gs_flt TYPE dv_flights.

TABLES : dv_flights.

SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE TEXT-t01.
  SELECT-OPTIONS : so_flda FOR dv_flights-fldate.

  SELECTION-SCREEN SKIP 3.

  PARAMETERS : p_car TYPE dv_flights-carrid MEMORY ID car
               OBLIGATORY DEFAULT 'LH' VALUE CHECK,
               p_con TYPE s_conn_id MEMORY ID con.
SELECTION-SCREEN END OF BLOCK bl1.


PARAMETERS : p_str TYPE string LOWER CASE MODIF ID mod.

SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS : p_chk AS CHECKBOX DEFAULT 'X' MODIF ID mod.

PARAMETERS : p_rad1 RADIOBUTTON GROUP gr1,
             p_rad2 RADIOBUTTON GROUP gr1,
             p_rad3 RADIOBUTTON GROUP gr1.
SELECTION-SCREEN END OF LINE.
