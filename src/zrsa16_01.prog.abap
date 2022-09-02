*&---------------------------------------------------------------------*
*& Report ZRSA16_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
  REPORT zrsa16_01.

*  PARAMETERS pa_carr TYPE scarr-carrid.
*
*  DATA gs_scarr TYPE scarr.
*
*  PERFORM get_data.

*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
*  FORM get_data .
*    SELECT SINGLE * FROM scarr
*                     INTO gs_scarr
*       WHERE carrid = pa_carr.
*
*    IF sy-subrc IS INITIAL.
*      NEW-LINE.
*      WRITE: gs_scarr-carrid,
*      gs_scarr-carrname,
*      gs_scarr-url.
*
*    ELSE.
*      WRITE TEXT-t01. "' Sorry, no data found!'.
**      MESSAGE 'Sorry, do data found!' TYPE 'i'.
*    ENDIF.
*  ENDFORM.
