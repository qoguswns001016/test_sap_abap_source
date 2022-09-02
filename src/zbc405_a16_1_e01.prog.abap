*&---------------------------------------------------------------------*
*& Include          ZBC405_A20_E01
*&---------------------------------------------------------------------*

SELECT *
  FROM dv_flights
  INTO gs_flt
  WHERE carrid = p_car AND connid = p_con AND fldate IN so_flda.

  WRITE : /10(5) gs_flt-carrid, 16(5) gs_flt-connid, 22(10) gs_flt-fldate,
            gs_flt-price CURRENCY gs_flt-currency, gs_flt-currency.

ENDSELECT.
