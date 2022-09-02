*&---------------------------------------------------------------------*
*& Report ZRSA16_12
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSA16_12.

DATA gv_carrname TYPE scarr-carrname.
PARAMETERS pa_carr TYPE scarr-carrid.

PERFORM cal_carr USING pa_carr
                 CHANGING gv_carrname.

PERFORM display_carr USING gv_carrname.
*&---------------------------------------------------------------------*
*& Form cal_carr
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM cal_carr USING p_carr
              CHANGING p_cname.
  SELECT SINGLE carrname
    FROM scarr
    INTO p_cname
  WHERE carrid = p_carr.
    WRITE 'test gv_carrname'.
    WRITE gv_carrname.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form display_carr
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_CARR
*&      <-- VALUE(P_CNAME)
*&---------------------------------------------------------------------*
FORM display_carr USING VALUE(p_cname).
  WRITE p_cname.

ENDFORM.
