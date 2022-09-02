*&---------------------------------------------------------------------*
*& Report ZRSA16_32
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa16_32.

DATA gs_emp TYPE zssa16010.

PARAMETERS pa_pernr LIKE gs_emp-pernr.

INITIALIZATION.
  pa_pernr = '20000001'.


START-OF-SELECTION.
  SELECT SINGLE *
    FROM ztsa1601 " Employee Table
  INTO CORRESPONDING FIELDS OF gs_emp
    WHERE pernr = pa_pernr.
  IF sy-subrc <> 0.
    "Data is not found.
    MESSAGE i001(zmcsa16).
    RETURN.
  ENDIF.


*WRITE gs_emp-depno.
*NEW-LINE.
*WRITE gs_emp-dep-depno.
*  cl_demo_output=>display_data( gs_emp ).

SELECT SINGLE *
  from ztsa1602
  INTO gs_emp-dep
 WHERE depno = gs_emp-depno.

  cl_demo_output=>display_data( gs_emp-dep ).
