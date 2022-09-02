*&---------------------------------------------------------------------*
*& Include          MZSA1650_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form meal_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ZSSA16VEN_CON_CARRID
*&      --> ZSSA16VEN_CON_MEALNUMBER
*&      <-- ZSSA16MEAL
*&---------------------------------------------------------------------*
FORM meal_info  USING VALUE(p_carrid)
                      VALUE(p_mealnumber)
                CHANGING p_meal TYPE zssa16meal
                         p_ven TYPE zssa16ven
                         p_subrc.

  SELECT SINGLE *
    FROM smeal AS s INNER JOIN smealt AS t
    ON s~mealnumber = t~mealnumber
    INTO CORRESPONDING FIELDS OF p_meal
    WHERE s~carrid = p_carrid
       AND t~carrid = p_carrid
       AND s~mealnumber = p_mealnumber.

  SELECT SINGLE carrname
    FROM scarr
    INTO p_meal-carrname
    WHERE carrid = p_carrid.

  SELECT SINGLE price waers
  FROM ztsa16ven AS z INNER JOIN smeal AS s
  ON z~mealno = s~mealnumber
  INTO CORRESPONDING FIELDS OF p_meal
  WHERE z~mealno = p_mealnumber
    AND z~carrid = p_carrid.

  PERFORM ven_info USING zssa16ven_con-carrid zssa16ven_con-mealnumber
                      CHANGING p_ven .




ENDFORM.
*&---------------------------------------------------------------------*
*& Form ven_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ZSSA16VEN_CON_CARRID
*&      --> ZSSA16VEN_CON_MEALNUMBER
*&      <-- ZSSA16VEN
*&---------------------------------------------------------------------*
FORM ven_info  USING VALUE(p_carrid)
                     VALUE(p_mealnumber)
               CHANGING p_ven TYPE zssa16ven.

  SELECT SINGLE *
    FROM ztsa16ven
    INTO CORRESPONDING FIELDS OF p_ven
    WHERE carrid = p_carrid AND mealno = p_mealnumber.

  SELECT SINGLE landx
    FROM t005t
    INTO p_ven-landx50
    WHERE land1 = p_ven-land1 AND spras = sy-langu.


*  PERFORM get_domain USING 'S_MEALTYPE'
*                            p_ven-mealtype
*                     CHANGING p_ven-mealtype_t.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_domain
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&      --> ZSSA16VEN_MEALTYPE
*&      <-- MEALTYPE_T
*&---------------------------------------------------------------------*
FORM get_domain  USING VALUE(p_dmeal)
                       VALUE(p_dvenca)
                       VALUE(p_zmeal)
                       VALUE(p_zvenca)
                       CHANGING p_mealt
                                p_vencat.


  DATA: lt_domain TYPE TABLE OF dd07v,
        ls_domain LIKE LINE OF lt_domain.



  CALL FUNCTION 'GET_DOMAIN_VALUES'
    EXPORTING
      domname         = p_dmeal
*     TEXT            = 'X'
*     FILL_DD07L_TAB  = ' '
    TABLES
      values_tab      = lt_domain
*     VALUES_DD07L    =
    EXCEPTIONS
      no_values_found = 1
      OTHERS          = 2.

  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  READ TABLE lt_domain WITH KEY domvalue_l = p_zmeal INTO ls_domain.
  p_mealt = ls_domain-ddtext.

   CLEAR: lt_domain, ls_domain.


  CALL FUNCTION 'GET_DOMAIN_VALUES'
    EXPORTING
      domname         = p_dvenca
*     TEXT            = 'X'
*     FILL_DD07L_TAB  = ' '
    TABLES
      values_tab      = lt_domain
*     VALUES_DD07L    =
    EXCEPTIONS
      no_values_found = 1
      OTHERS          = 2.

  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  READ TABLE lt_domain WITH KEY domvalue_l = p_zvenca INTO ls_domain.
  p_vencat = ls_domain-ddtext.

  CLEAR: lt_domain, ls_domain.




ENDFORM.
