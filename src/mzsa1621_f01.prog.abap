*&---------------------------------------------------------------------*
*& Include          MZSA1621_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_conn_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ZSSA1673_PERNR
*&      <-- ZSSA1673_ENAME
*&---------------------------------------------------------------------*
FORM get_conn_info  USING VALUE(p_pernr)
                    CHANGING p_ename.
  SELECT SINGLE ename
    from ztsa1601
    INTO p_ename
    WHERE pernr = p_pernr.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_emp_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ZSSA1670_EMP_PERNR
*&      <-- ZSSA1670_EMP
*&---------------------------------------------------------------------*
FORM get_emp_info  USING VALUE(p_pernr)
                   CHANGING VALUE(p_emp) TYPE zssa1670_emp.
  SELECT SINGLE *
    FROM ztsa1601
    INTO CORRESPONDING FIELDS OF p_emp
    WHERE pernr = p_pernr.

ENDFORM.
