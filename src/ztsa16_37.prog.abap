*&---------------------------------------------------------------------*
*& Report ZTSA16_37
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztsa16_37.

DATA: gs_info TYPE zvsa1602, "Database View ( Structure )
      gt_info LIKE TABLE OF gs_info.

*PARAMETERS pa_dep LIKE gs_info-depno.

START-OF-SELECTION.
*select *
*  from zvsa1602 "database Table
*  into CORRESPONDING FIELDS OF TABLE gt_info
*  WHERE depno = pa_dep.

*  SELECT *
*    FROM ztsa1601 INNER JOIN ztsa1602
*      ON ztsa1601~depno = ztsa1602~depno
*    INTO CORRESPONDING FIELDS OF TABLE gt_info
*    WHERE ztsa1601~depno = pa_dep.

*SELECT pernr ename a~depno depph
*  FROM ztsa1601 as a INNER JOIN ztsa1602 as b
*    ON a~depno = b~depno
*  INTO CORRESPONDING FIELDS OF TABLE gt_info
*  WHERE a~depno = pa_dep.

  SELECT *
    FROM ztsa1601 AS emp LEFT OUTER JOIN ztsa1602 AS dep
      ON emp~depno = dep~depno
    INTO CORRESPONDING FIELDS OF TABLE gt_info.



  cl_demo_output=>display_data( gt_info ).
