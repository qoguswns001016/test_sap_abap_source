*&---------------------------------------------------------------------*
*& Report ZRSA16_21
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa16_21.
TYPES: BEGIN OF ts_info,
         carrid    TYPE c  LENGTH 3,
         carrname  TYPE scarr-carrname,
         connid    TYPE spfli-connid,
         countryfr TYPE spfli-countryfr,
         countryto TYPE spfli-countryto,
         atype, "TYPE c LENGTH 1
         atype_t   TYPE c LENGTH 10,
       END OF ts_info.

* Connection Internal Table
*DATA   gt_info TYPE TABLE OF ts_info.
*Structure Variable
*DATA gs_info LIKE LINE OF gt_info.
*DATA gs_info TYPE ts_info. "위에 거랑 똑같은거.
" 테이블을 먼저 만들고 스트럭쳐 변수 만들기.

DATA: gs_info TYPE ts_info,
      gt_info LIKE TABLE OF gs_info.
"스트럭쳐 변수를 먼저 만들고 인터널 테이블 만들기.

*CLEAR gs_info.
*gs_info-carrid = 'AA'.
*gs_info-connid = '0017'.
*gs_info-countryfr = 'US'.
*gs_info-countryto = 'US'.
*APPEND gs_info TO gt_info.
*CLEAR gs_info.

PARAMETERS pa_car LIKE spfli-carrid.
*PERFORM gs_info USING 'AA' '0017' 'US' 'US'.
*PERFORM gs_info USING gs_info-carrid gs_info-connid gs_info-countryfr
*                      gs_info-countryto.

SELECT carrid connid countryfr countryto
  FROM spfli
  INTO CORRESPONDING FIELDS OF TABLE gt_info
  WHERE carrid = pa_car.

LOOP AT gt_info INTO gs_info.
  "Get Atype( D , I )
*  IF gs_info-countryfr = gs_info-countryto.
*    gs_info-atype = 'D'.
*    gs_info-atype_t = '국내선'.
*  ELSE.
*    gs_info-atype = 'I'.
*    gs_info-atype_t = '해외선'.
*  ENDIF.
  PERFORM gs_info USING gs_info-countryfr gs_info-countryto
                  CHANGING gs_info-atype gs_info-atype_t.

  "Get Airline Name.
  SELECT SINGLE carrname
    FROM scarr
    INTO gs_info-carrname
    WHERE carrid = gs_info-carrid.

  MODIFY gt_info FROM gs_info
                 TRANSPORTING carrname atype atype_t.
  CLEAR gs_info.
ENDLOOP.

SORT gt_info BY atype ASCENDING.
" atype 으로 오름차순으로 하겠다.





cl_demo_output=>display_data( gt_info ).
*&---------------------------------------------------------------------*
*& Form gs_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GS_INFO_CARRID
*&      --> GS_INFO_CONNID
*&      --> GS_INFO_COUNTRYFR
*&      --> GS_INFO_COUNTRYTO
*&---------------------------------------------------------------------*
FORM add_info USING VALUE(p_carrid)
                    VALUE(p_connid)
            CHANGING VALUE(p_countryfr)
                    VALUE(p_countryto).

  DATA ls_info LIKE LINE OF gt_info.
  CLEAR ls_info.
  ls_info-carrid = p_carrid.
  ls_info-connid = p_connid.
  ls_info-countryfr = p_countryfr.
  ls_info-countryto = p_countryto.
  APPEND ls_info TO gt_info.
  CLEAR ls_info.

  CLEAR gs_info.
  p_carrid = 'AA'.
  p_connid = '0064'.
  p_countryfr = 'US'.
  p_countryto = 'US'.
  APPEND gs_info TO gt_info.
  CLEAR gs_info.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form gs_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GS_INFO_COUNTRYFR
*&      --> GS_INFO_COUNTRYTO
*&      <-- GS_INFO_ATYPE
*&      <-- GS_INFO_ATYPE_T
*&      <-- SELECT
*&      <-- SINGLE
*&      <-- CARRNAME
*&      <-- FROM
*&      <-- SCARR
*&      <-- INTO
*&      <-- GS_INFO_CARRNAME
*&      <-- WHERE
*&      <-- CARRID
*&      <-- =
*&      <-- GS_INFO_CARRID
*&---------------------------------------------------------------------*
FORM gs_info  USING   VALUE(p_countryfr)
                       VALUE(p_countryto)
              CHANGING VALUE(p_atype)
                       VALUE(p_atype_t).

  IF p_countryfr = p_countryto.
    p_atype = 'D'.
    p_atype_t = '국내선'.

  ELSE.
    p_atype = 'I'.
    p_atype_t = '해외선'.
  ENDIF.
  MODIFY gt_info FROM gs_info
                 TRANSPORTING atype atype_t.


  CLEAR p_atype.
  CLEAR p_atype_t.
ENDFORM.
