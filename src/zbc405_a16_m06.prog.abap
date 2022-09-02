*&---------------------------------------------------------------------*
*& Report ZBC405_A16_M06
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_a16_m06.

TYPES: BEGIN OF ts_emp,
         pernr    TYPE ztsa2001-pernr,
         ename    TYPE ztsa2001-ename,
         depid    TYPE ztsa2001-depid,
         gender   TYPE ztsa2001-gender,
         gender_t TYPE c LENGTH 10,
         phone    TYPE ztsa2002-phone,
       END OF ts_emp.

DATA: gs_emp TYPE ts_emp,
      gt_emp LIKE TABLE OF gs_emp,
      gs_dep TYPE ztsa2002,
      gt_dep LIKE TABLE OF gs_dep.
*
*SELECT SINGLE pernr gender
*  FROM ztsa2001
*  INTO (gs_emp-pernr , gs_emp-gender )
*  WHERE pernr = '20220001'.
*
*WRITE: '사원번호: ' , gs_emp-pernr.
*NEW-LINE.
*WRITE: '사원명: ' , gs_emp-ename.
*NEW-LINE.
*WRITE: '부서코드: ' , gs_emp-depid.
*WRITE: /'성별: ', gs_emp-gender.

*"loop 문
*
*SELECT *
*  FROM ztsa2001
*  INTO CORRESPONDING FIELDS OF TABLE gt_emp.
*
*CLEAR gs_emp.
*LOOP AT gt_emp INTO gs_emp.
*  "gs_emp 를 바꾸는 로직
*  CASE gs_emp-gender.
*    WHEN '1'.
*      gs_emp-gender_t = '남성'.
*    WHEN '2'.
*      gs_emp-gender_t = '여성'.
*  ENDCASE.
*
*select single phone
*  from ztsa2002
*  into CORRESPONDING FIELDS OF gs_emp
*  where depid = gs_emp-depid.
*
*  MODIFY gt_emp FROM gs_emp.
*  CLEAR gs_emp.
*ENDLOOP.
SELECT *
  FROM ztsa2001
  INTO CORRESPONDING FIELDS OF TABLE gt_emp.

SELECT *
  FROM ztsa2002
  INTO CORRESPONDING FIELDS OF TABLE gt_dep
  WHERE depid BETWEEN 'D001' AND 'D003'.

   clear gs_emp.
 loop at gt_emp into gs_emp.
   READ TABLE gt_dep into gs_dep
   WITH KEY depid = gs_emp-depid.

   gs_emp-phone = gs_dep-phone.



   MODIFY gt_emp from gs_emp.
   clear: gs_emp , gs_dep.
 EnDLOOP.



cl_demo_output=>display_data( gt_emp ).
