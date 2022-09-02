FUNCTION ZFSA16_21.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_CARRID) TYPE  ZSSA0080-CARRID
*"     REFERENCE(IV_CONNID) TYPE  ZSSA0080-CONNID
*"  EXPORTING
*"     REFERENCE(ES_AIRLINE) TYPE  ZSSA0081
*"     REFERENCE(ES_CONN) TYPE  ZSSA0082
*"     REFERENCE(EV_SUBRC) TYPE  SY-SUBRC
*"----------------------------------------------------------------------

  PERFORM get_conn_info USING iv_carrid
                              iv_connid
                        CHANGING
                                 es_conn
                                 ev_subrc.
  IF ev_subrc IS INITIAL.
    PERFORM get_airline_info USING iv_carrid
                             CHANGING es_airline.
  ENDIF.



ENDFUNCTION.
