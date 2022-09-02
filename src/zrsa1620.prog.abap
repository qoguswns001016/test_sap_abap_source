*&---------------------------------------------------------------------*
*& Report ZRSA1620
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa1620.

DATA: BEGIN OF gs_info,
        carrid    TYPE spfli-carrid,
        carrname  TYPE scarr-carrname,
        connid    TYPE spfli-connid,
        countryfr TYPE spfli-countryfr,
        countryto TYPE spfli-countryto,
        atype     TYPE c LENGTH 10,
      END OF gs_info.

DATA gt_info LIKE TABLE OF gs_info.

gs_info-connid = '0017'.
PERFORM gs_info USING gs_info-connid.

gs_info-connid = '0064'.
PERFORM gs_info USING gs_info-connid.

gs_info-connid = '0555'.
PERFORM gs_info USING gs_info-connid.

LOOP AT gt_info INTO  gs_info.
  IF gs_info-countryfr = gs_info-countryto.
    gs_info-atype = '국내선'.
  ELSE.
    gs_info-atype = '해외선'.
  ENDIF.
  MODIFY gt_info FROM gs_info INDEX sy-tabix.
  SELECT SINGLE carrname
    FROM scarr
    INTO CORRESPONDING FIELDS OF gs_info
  WHERE carrid = gs_info-carrid.
    MODIFY gt_info FROM gs_info INDEX sy-tabix.
  CLEAR gs_info.
ENDLOOP.

cl_demo_output=>display_data( gt_info ).
*&---------------------------------------------------------------------*
*& Form gs_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM gs_info CHANGING VALUE(p_connid).

  SELECT SINGLE carrid connid countryfr countryto
  FROM spfli
  INTO CORRESPONDING FIELDS OF gs_info
  WHERE connid = p_connid.
  APPEND gs_info TO gt_info.
  CLEAR gs_info.

ENDFORM.
