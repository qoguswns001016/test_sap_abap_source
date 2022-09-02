FUNCTION ZFSA16_01.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_PERNR) TYPE  ZSSA0073-PERNR
*"  EXPORTING
*"     REFERENCE(EV_ENAME) TYPE  ZSSA0073-ENAME
*"----------------------------------------------------------------------

      SELECT SINGLE ename
        from ztsa0001
        into ev_ename
        WHERE pernr = iv_pernr.

ENDFUNCTION.
