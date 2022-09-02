*&---------------------------------------------------------------------*
*& Include          MZSA1601_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GV_PNO
*&      <-- ZSSA0031
*&---------------------------------------------------------------------*
FORM get_data  USING VALUE(p_pno)
               CHANGING ps_info TYPE zssa0031.
*
*  CLEAR ps_info.
*  " Emp / Dep Table
*  SELECT SINGLE *
*    FROM ztsa0001 AS a INNER JOIN ztsa0002 AS b
*      ON a~depid = b~depid
*            INTO CORRESPONDING FIELDS OF ps_info
*    WHERE a~pernr = p_pno.
*    IF sy-subrc Is Not INITIAL.
*      RETURN.
*    ENDIF.
*  " Dep Text Table
*    SELECT SINGLE dtext
*      FROM ztsa0002_t
*      INTO ps_info-dtext
*      WHERE depid = ps_info-depid
*        AND spras = sy-langu.
*
**   " Gender Text
**      CASE ps_info-gender.
**        WHEN '1'.
**          ps_info-gender_t = 'Man'(T01).
**        WHEN '2'.
**          ps_info-gender_t = 'Woman'(t02).
**        WHEN OTHERS.
**          ps_info-gender_t = 'None'(t03).
**       ENDCASE.
*DATA: lt_domain TYPE TABLE OF DD07v,
*      ls_domain LIKE LINE OF lt_domain.
*CALL FUNCTION 'GET_DOMAIN_VALUES'
*  EXPORTING
*    domname               = 'ZDGENDER_A00'
**   TEXT                  = 'X'
**   FILL_DD07L_TAB        = ' '
* TABLES
*   VALUES_TAB            = lt_domain
**   VALUES_DD07L          =
** EXCEPTIONS
*   NO_VALUES_FOUND       = 1
*   OTHERS                = 2
*          .
*IF sy-subrc <> 0.
** Implement suitable error handling here
*ENDIF.
*
*READ TABLE lt_domain with key DOMVALUE_L = ps_info-gender
*INTO ls_domain.
*ps_info-gender_t = ls_domain-ddtext.

ENDFORM.
