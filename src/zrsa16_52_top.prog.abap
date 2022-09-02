*&---------------------------------------------------------------------*
*& Include ZRSA16_52_TOP                            - Report ZRSA16_52
*&---------------------------------------------------------------------*
REPORT ZRSA16_52.

TABLES: scarr, spfli, sflight. " 스트럭쳐 타입.
*DATA scarr TYPE scarr. "위에랑 같은거.
PARAMETERS: pa_car LIKE scarr-carrid,
            pa_con LIKE spfli-connid.

select-OPTIONS so_dat for sflight-fldate.
