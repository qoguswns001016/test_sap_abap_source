*&---------------------------------------------------------------------*
*& Include ZBC405_A16_TOP                           - Module Pool      ZBC405_A16
*&---------------------------------------------------------------------*
PROGRAM zbc405_a16.

DATA: gs_flt TYPE dv_flights.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-t01.

PARAMETERS: p_car TYPE dv_flights-carrid
                  MEMORY ID car OBLIGATORY
                  DEFAULT 'LH' VALUE CHECK,
            p_con TYPE s_conn_id MEMORY ID con OBLIGATORY.

SELECT-OPTIONS: s_fldate for dv_flights-fldate.
SELECTION-SCREEN END OF BLOCK b1.

PARAMETERS: p_str TYPE string LOWER CASE
            MODIF ID mod.

PARAMETERS: p_chk AS CHECKBOX DEFAULT 'X'
            MODIF ID mod.

PARAMETERS: p_rad1 RADIOBUTTON GROUP rd1,
            p_rad2 RADIOBUTTON GROUP rd1,
            p_rad3 RADIOBUTTON GROUP rd1.

INITIALIZATION.
s_fldate-low = sy-datum.
s_fldate-hight = sy-datum.

s_fldate-sign = 'I'.
s_fldate-option = 'BT'.

*set PARAMETER ID 'Z01' field p_car.
*get PARAMETER ID 'z01' field p_car.

*INITIALIZATION.
*loop at SCREEN.
*  IF screen-group = 'MOD'.
*
*    screen-input = 0.
*    screen-output = 1.
*  ENDIF.
*  ENDLOOP.
