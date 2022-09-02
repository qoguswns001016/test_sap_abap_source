*&---------------------------------------------------------------------*
*& Include ZRSA16_31_TOP                            - Module Pool      ZRSA16_31
*&---------------------------------------------------------------------*
PROGRAM zrsa16_31.
*
*" Employee List
*DATA: gs_emp TYPE zssa1604,
*      gt_emp LIKE TABLE OF gs_emp.
*
*
*PARAMETERS: pa_ent_b LIKE gs_emp-entdt,
*            pa_ent_e LIKE gs_emp-entdt.
*
*START-OF-SELECTION.
*  SELECT *
*    FROM ztsa1601
*    INTO CORRESPONDING FIELDS OF TABLE gt_emp
*    WHERE entdt BETWEEN pa_ent_b AND pa_ent_e.
*  IF sy-subrc IS NOT INITIAL.
**      MESSAGE i...
*    RETURN.
*  ENDIF.
*  cl_demo_output=>display_data( gt_emp ).
