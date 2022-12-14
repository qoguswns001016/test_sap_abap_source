*---------------------------------------------------------------------*
*    view related FORM routines
*---------------------------------------------------------------------*
*...processing: ZVSA1699........................................*
FORM GET_DATA_ZVSA1699.
  PERFORM VIM_FILL_WHERETAB.
*.read data from database.............................................*
  REFRESH TOTAL.
  CLEAR   TOTAL.
  SELECT * FROM ZTSA1699 WHERE
(VIM_WHERETAB) .
    CLEAR ZVSA1699 .
ZVSA1699-MANDT =
ZTSA1699-MANDT .
ZVSA1699-LIFNR =
ZTSA1699-LIFNR .
ZVSA1699-LAND1 =
ZTSA1699-LAND1 .
ZVSA1699-NAME1 =
ZTSA1699-NAME1 .
ZVSA1699-NAME2 =
ZTSA1699-NAME2 .
ZVSA1699-VENCA =
ZTSA1699-VENCA .
ZVSA1699-CARRID =
ZTSA1699-CARRID .
ZVSA1699-MEALNUMBER =
ZTSA1699-MEALNUMBER .
ZVSA1699-PRICE =
ZTSA1699-PRICE .
ZVSA1699-WAERS =
ZTSA1699-WAERS .
<VIM_TOTAL_STRUC> = ZVSA1699.
    APPEND TOTAL.
  ENDSELECT.
  SORT TOTAL BY <VIM_XTOTAL_KEY>.
  <STATUS>-ALR_SORTED = 'R'.
*.check dynamic selectoptions (not in DDIC)...........................*
  IF X_HEADER-SELECTION NE SPACE.
    PERFORM CHECK_DYNAMIC_SELECT_OPTIONS.
  ELSEIF X_HEADER-DELMDTFLAG NE SPACE.
    PERFORM BUILD_MAINKEY_TAB.
  ENDIF.
  REFRESH EXTRACT.
ENDFORM.
*---------------------------------------------------------------------*
FORM DB_UPD_ZVSA1699 .
*.process data base updates/inserts/deletes.........................*
LOOP AT TOTAL.
  CHECK <ACTION> NE ORIGINAL.
MOVE <VIM_TOTAL_STRUC> TO ZVSA1699.
  IF <ACTION> = UPDATE_GELOESCHT.
    <ACTION> = GELOESCHT.
  ENDIF.
  CASE <ACTION>.
   WHEN NEUER_GELOESCHT.
IF STATUS_ZVSA1699-ST_DELETE EQ GELOESCHT.
     READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY>.
     IF SY-SUBRC EQ 0.
       DELETE EXTRACT INDEX SY-TABIX.
     ENDIF.
    ENDIF.
    DELETE TOTAL.
    IF X_HEADER-DELMDTFLAG NE SPACE.
      PERFORM DELETE_FROM_MAINKEY_TAB.
    ENDIF.
   WHEN GELOESCHT.
  SELECT SINGLE FOR UPDATE * FROM ZTSA1699 WHERE
  LIFNR = ZVSA1699-LIFNR .
    IF SY-SUBRC = 0.
    DELETE ZTSA1699 .
    ENDIF.
    IF STATUS-DELETE EQ GELOESCHT.
      READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY> BINARY SEARCH.
      DELETE EXTRACT INDEX SY-TABIX.
    ENDIF.
    DELETE TOTAL.
    IF X_HEADER-DELMDTFLAG NE SPACE.
      PERFORM DELETE_FROM_MAINKEY_TAB.
    ENDIF.
   WHEN OTHERS.
  SELECT SINGLE FOR UPDATE * FROM ZTSA1699 WHERE
  LIFNR = ZVSA1699-LIFNR .
    IF SY-SUBRC <> 0.   "insert preprocessing: init WA
      CLEAR ZTSA1699.
    ENDIF.
ZTSA1699-MANDT =
ZVSA1699-MANDT .
ZTSA1699-LIFNR =
ZVSA1699-LIFNR .
ZTSA1699-LAND1 =
ZVSA1699-LAND1 .
ZTSA1699-NAME1 =
ZVSA1699-NAME1 .
ZTSA1699-NAME2 =
ZVSA1699-NAME2 .
ZTSA1699-VENCA =
ZVSA1699-VENCA .
ZTSA1699-CARRID =
ZVSA1699-CARRID .
ZTSA1699-MEALNUMBER =
ZVSA1699-MEALNUMBER .
ZTSA1699-PRICE =
ZVSA1699-PRICE .
ZTSA1699-WAERS =
ZVSA1699-WAERS .
    IF SY-SUBRC = 0.
    UPDATE ZTSA1699 ##WARN_OK.
    ELSE.
    INSERT ZTSA1699 .
    ENDIF.
    READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY>.
    IF SY-SUBRC EQ 0.
      <XACT> = ORIGINAL.
      MODIFY EXTRACT INDEX SY-TABIX.
    ENDIF.
    <ACTION> = ORIGINAL.
    MODIFY TOTAL.
  ENDCASE.
ENDLOOP.
CLEAR: STATUS_ZVSA1699-UPD_FLAG,
STATUS_ZVSA1699-UPD_CHECKD.
MESSAGE S018(SV).
ENDFORM.
*---------------------------------------------------------------------*
FORM READ_SINGLE_ENTRY_ZVSA1699.
  SELECT SINGLE * FROM ZTSA1699 WHERE
LIFNR = ZVSA1699-LIFNR .
ZVSA1699-MANDT =
ZTSA1699-MANDT .
ZVSA1699-LIFNR =
ZTSA1699-LIFNR .
ZVSA1699-LAND1 =
ZTSA1699-LAND1 .
ZVSA1699-NAME1 =
ZTSA1699-NAME1 .
ZVSA1699-NAME2 =
ZTSA1699-NAME2 .
ZVSA1699-VENCA =
ZTSA1699-VENCA .
ZVSA1699-CARRID =
ZTSA1699-CARRID .
ZVSA1699-MEALNUMBER =
ZTSA1699-MEALNUMBER .
ZVSA1699-PRICE =
ZTSA1699-PRICE .
ZVSA1699-WAERS =
ZTSA1699-WAERS .
ENDFORM.
*---------------------------------------------------------------------*
FORM CORR_MAINT_ZVSA1699 USING VALUE(CM_ACTION) RC.
  DATA: RETCODE LIKE SY-SUBRC, COUNT TYPE I, TRSP_KEYLEN TYPE SYFLENG.
  FIELD-SYMBOLS: <TAB_KEY_X> TYPE X.
  CLEAR RC.
MOVE ZVSA1699-LIFNR TO
ZTSA1699-LIFNR .
MOVE ZVSA1699-MANDT TO
ZTSA1699-MANDT .
  CORR_KEYTAB             =  E071K.
  CORR_KEYTAB-OBJNAME     = 'ZTSA1699'.
  IF NOT <vim_corr_keyx> IS ASSIGNED.
    ASSIGN CORR_KEYTAB-TABKEY TO <vim_corr_keyx> CASTING.
  ENDIF.
  ASSIGN ZTSA1699 TO <TAB_KEY_X> CASTING.
  PERFORM VIM_GET_TRSPKEYLEN
    USING 'ZTSA1699'
    CHANGING TRSP_KEYLEN.
  <VIM_CORR_KEYX>(TRSP_KEYLEN) = <TAB_KEY_X>(TRSP_KEYLEN).
  PERFORM UPDATE_CORR_KEYTAB USING CM_ACTION RETCODE.
  ADD: RETCODE TO RC, 1 TO COUNT.
  IF RC LT COUNT AND CM_ACTION NE PRUEFEN.
    CLEAR RC.
  ENDIF.

ENDFORM.
*---------------------------------------------------------------------*
