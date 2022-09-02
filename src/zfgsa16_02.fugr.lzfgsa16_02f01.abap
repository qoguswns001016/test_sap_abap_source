*----------------------------------------------------------------------*
***INCLUDE LZFGSA16_02F01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_conn_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> IV_CARRID
*&      --> IV_CONNID
*&      <-- ES_CONN
*&      <-- EV_SUBRC
*&---------------------------------------------------------------------*
FORM get_conn_info  USING VALUE(p_carrid)
                          VALUE(p_connid)
                    CHANGING p_conn TYPE zssa0082
                             p_subrc.

  SELECT SINGLE *
    from spfli
    INTO CORRESPONDING FIELDS OF p_conn
    WHERE carrid = p_carrid
    AND connid = p_connid.
    IF  sy-subrc <> 0.
        sy-subrc = 4.
        RETURN.
    ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_airline_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> IV_CARRID
*&      <-- ES_AIRLINE
*&---------------------------------------------------------------------*
FORM get_airline_info  USING VALUE(p_carrid)
                       CHANGING VALUE(p_airline) TYPE zssa0081.
  SELECT SINGLE *
    FROM scarr
    into CORRESPONDING FIELDS OF p_airline
    WHERE carrid = p_carrid.

ENDFORM.
