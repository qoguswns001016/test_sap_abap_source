*&---------------------------------------------------------------------*
*& Report ZRSA16_33
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSA16_33.

DATA gs_dep TYPE zssa1607.
DATA: gt_emp TYPE TABLE OF zssa0006,
      gs_emp LIKE LINE OF gt_emp.

PARAMETERS pa_dep TYPE ztsa1602-depno.

START-OF-SELECTION.
select SINGLE *
  from ztsa1602
  INTO CORRESPONDING FIELDS OF gs_dep
  WHERE depno = pa_dep.

  cl_demo_output=>display_data( gs_dep ).

  select *
    from ztsa1601
    INTO CORRESPONDING FIELDS OF TABLE gt_emp
    WHERE depno = gs_dep-depno.

    cl_demo_output=>display_data( gt_emp ).
