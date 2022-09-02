*&---------------------------------------------------------------------*
*& Report ZRSA16_25
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zrsa16_25_top                           .    " Global Data

* INCLUDE ZRSA16_25_O01                           .  " PBO-Modules
* INCLUDE ZRSA16_25_I01                           .  " PAI-Modules
INCLUDE zrsa16_25_f01                           .  " FORM-Routines

START-OF-SELECTION.
SELECT *
  from sflight
  INTO CORRESPONDING FIELDS OF TABLE gt_info
  WHERE carrid = pa_car
  AND connid IN so_con[].
*  AND connid BETWEEN pa_con1 AND pa_con2.

  cl_demo_output=>display_data( gt_info ).





*INITIALIZATION.
*
*AT SELECTION-SCREEN OUTPUT.
*
*AT SELECTION-SCREEN.
*
*START-OF-SELECTION.
*SELECT *
*  FROM sflight
*  INTO CORRESPONDING FIELDS OF TABLE gt_info
*  WHERE carrid = pa_car
*      AND connid = pa_con1 OR carrid = pa_car AND connid = pa_con2.
*
*LOOP AT gt_info INTO gs_info.
*  SELECT SINGLE carrname
*      FROM scarr
*      INTO gs_info-carrname
*      WHERE carrid = gs_info-carrid.
*  MODIFY gt_info FROM gs_info TRANSPORTING carrname.
*
*  SELECT SINGLE cityfrom cityto
*    FROM spfli
*    INTO (gs_info-cityfrom, gs_info-cityto)
*    WHERE carrid = gs_info-carrid.
*  MODIFY gt_info FROM gs_info TRANSPORTING cityfrom cityto.
*
*  gs_info-seat_e = gs_info-seatsmax - gs_info-seatsocc.
*  gs_info-seat_b = gs_info-seatsmax_b - gs_info-seatsocc_b.
*  gs_info-seat_f = gs_info-seatsmax_f - gs_info-seatsocc_f.
*
*  MODIFY gt_info FROM gs_info.
*
*
*ENDLOOP.

cl_demo_output=>display_data( gt_info ).
