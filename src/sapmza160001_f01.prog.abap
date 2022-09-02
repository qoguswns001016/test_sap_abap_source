*&---------------------------------------------------------------------*
*& Include          SAPMZA160001_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form f4_werks
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f4_werks .

  select werks, name1, ekorg, land1
    into table @DATA(lt_werks)
    from t001w.

    IF sy-subrc NE 0.

      EXIT.
    ENDIF.

    CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
      EXPORTING

        retfield               = 'WERKS'
       DYNPPROG               = sy-repid
       DYNPNR                 = sy-dynnr
       DYNPROFIELD            = 'GS_DATA-WERKS'
       WINDOW_TITLE           = TEXT-t01
       VALUE_ORG              = 'S'
      tables
        value_tab              = lt_werks.
ENDFORM.
