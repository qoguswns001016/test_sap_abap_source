*&---------------------------------------------------------------------*
*& Report ZPG_A16_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpg_a16_1.

TYPES: BEGIN OF gty_sflight,
         carrid     TYPE sflight-carrid,
         connid     TYPE sflight-connid,
         fldate     TYPE sflight-fldate,
         currency   TYPE sflight-currency,
         planetype  TYPE sflight-planetype,
         seatsocc_b TYPE sflight-seatsocc_b,
       END OF gty_sflight.

DATA gs_sflight TYPE gty_sflight.
DATA gt_sflight LIKE TABLE OF gs_sflight.

SELECT carrid connid fldate currency planetype seatsocc_b
  FROM sflight
  INTO CORRESPONDING FIELDS OF TABLE gt_sflight
  WHERE currency = 'USD' AND planetype = '747-400'.

LOOP AT gt_sflight into gs_sflight.
  CASE gs_sflight-carrid.
    WHEN 'UA'.
      gs_sflight-seatsocc_b = gs_sflight-seatsocc_b + 5.
  ENDCASE.
    MODIFY gt_sflight from gs_sflight.
ENDLOOP.

cl_demo_output=>display_data( gt_sflight ).
