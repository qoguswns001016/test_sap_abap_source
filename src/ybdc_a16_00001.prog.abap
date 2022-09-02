*&---------------------------------------------------------------------*
*& Report YBDC_A16_00001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT YBDC_A16_00001.
*data : it_mara type TABLE of mara.
TYPES : BEGIN OF yt_mara.
TYPES : matnr TYPE mara-matnr.
TYPES : mbrsh TYPE mara-mbrsh.
TYPES : mtart TYPE mara-mtart.
TYPES : maktx TYPE makt-maktx.
TYPES : meins TYPE mara-meins.
*TYPES : field2(10).
TYPES : END OF yt_mara.

DATA : gt_mara TYPE TABLE OF yt_mara.
DATA : wa_mara TYPE yt_mara.

DATA: BEGIN OF i_bdctab OCCURS 0.
        INCLUDE STRUCTURE bdcdata.
DATA: END OF i_bdctab.



DATA       BEGIN OF i_msg OCCURS 10.
INCLUDE STRUCTURE bdcmsgcoll.
DATA END OF i_msg.

DATA       BEGIN OF gt_msg OCCURS 10.
INCLUDE STRUCTURE bdcmsgcoll.
DATA END OF gt_msg.

PARAMETERS : g_mode TYPE c OBLIGATORY DEFAULT 'A'.

DATA : l_rc TYPE i.
DATA : l_ftab   TYPE filetable,
       filename TYPE string.


START-OF-SELECTION.


* /BDEL  " 현재 세션의 bdc삭제
* /NBEN   "현재 bdc 세션종료
* /BDA  "모든 transaction 단계 조회
* /BDE  " 에러만 조회.
*

*g_mode = 'A'.   "  E,  N,


  CALL METHOD cl_gui_frontend_services=>file_open_dialog
    EXPORTING
      window_title            = 'File open'
*     default_extension       =
      default_filename        = space
      file_filter             = '*.*'
*     with_encoding           =
      initial_directory       = 'C:\'
      multiselection          = space
    CHANGING
      file_table              = l_ftab    "gt_mara
      rc                      = l_rc
*     user_action             =
*     file_encoding           =
    EXCEPTIONS
      file_open_dialog_failed = 1
      cntl_error              = 2
      error_no_gui            = 3
      not_supported_by_gui    = 4
      OTHERS                  = 5.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  READ TABLE l_ftab INTO filename INDEX 1.
*
  CHECK sy-subrc EQ 0.

  CALL FUNCTION 'GUI_UPLOAD'
    EXPORTING
      filename            = filename
      filetype            = 'ASC'
      has_field_separator = 'X'
    TABLES
      data_tab            = gt_mara.



*perform other_func.


  LOOP AT gt_mara INTO wa_mara.

    PERFORM f_bdc_data USING :
       'X' 'SAPLMGMM'     '0060',  "
       ' ' 'RMMG1-MATNR'   wa_mara-matnr,
       ' ' 'RMMG1-MBRSH'   wa_mara-mbrsh,
       ' ' 'RMMG1-MTART'   wa_mara-mtart,
       ' ' 'BDC_OKCODE'   '/00'.



*& SELECT VIEW ; POPUP
    PERFORM f_bdc_data USING :
      'X' 'SAPLMGMM'     '0070',  "
      ' ' 'MSICHTAUSW-KZSEL(01)'   'X',
      ' ' 'MSICHTAUSW-KZSEL(02)'   'X',
      ' ' 'BDC_OKCODE'   '=ENTR'.



    PERFORM f_bdc_data USING :
      'X' 'SAPLMGMM'     '4004',  "
      ' ' 'MAKT-MAKTX'  wa_mara-maktx,
      ' ' 'MARA-MEINS'  wa_mara-meins,
      ' ' 'BDC_OKCODE'   '=ENTR'.



    PERFORM f_bdc_data USING :
      'X' 'SAPLMGMM'     '4004',  "
      ' ' 'BDC_OKCODE'   '=BU'.

*
*2. CALL TRANSACTION ta WITH|WITHOUT AUTHORITY-CHECK
*                      USING bdc_tab { {[MODE mode] [UPDATE upd]}
*                                    |  [OPTIONS FROM opt] }
*                                       [MESSAGES INTO itab].



    CALL TRANSACTION 'MM01'  USING i_bdctab MODE g_mode
                             MESSAGES INTO i_msg.


    LOOP AT i_msg.
      WRITE : / i_msg-msgtyp, i_msg-msgv1.
    ENDLOOP.


    CLEAR : i_bdctab, i_msg. REFRESH : i_bdctab, i_msg.


  ENDLOOP.

*---------------------------------------------------------
FORM f_bdc_data USING p_dynbegin p_name p_value.

  IF p_dynbegin = 'X'.
    CLEAR i_bdctab.
    MOVE : p_name  TO i_bdctab-program,
           p_value TO i_bdctab-dynpro,
           'X'   TO i_bdctab-dynbegin.
    APPEND i_bdctab.
  ELSE.
    CLEAR i_bdctab.
    MOVE : p_name   TO i_bdctab-fnam,
           p_value  TO i_bdctab-fval.
    APPEND i_bdctab.
  ENDIF.
ENDFORM. " BDC_DATA
*&---------------------------------------------------------------------*
*& Form other_func
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM other_func .


*
*  CALL FUNCTION 'WS_FILENAME_GET'
*       EXPORTING
**           DEF_FILENAME     = ' '
*          def_path         = 'C:\'
*          mask             = ',*.*,*.*.'
*          mode             = 'O'
*          title            = text-005
*       IMPORTING
*          filename         = p_path
*       EXCEPTIONS
*          OTHERS           = 1.
*
*
*    CALL FUNCTION 'GUI_UPLOAD'
*      EXPORTING
*       filename                      = p_path
*       filetype                      = 'ASC'
*       has_field_separator           = 'X'
*      TABLES
*        data_tab                      = gt_mara .

*
*wa_mara-matnr = 'T30019'.
*wa_mara-maktx = 'TEST BDC'.
*wa_mara-mtart = 'ROH'.
*wa_mara-mbrsh = 'M'.
*wa_mara-meins = 'EA'.
*APPEND wa_mara TO gt_mara.
*
*
*wa_mara-matnr = 'T30020'.
*wa_mara-maktx = 'TEST BDC'.
*wa_mara-mtart = 'ROH'.
*wa_mara-mbrsh = 'M'.
*wa_mara-meins = 'EA'.
*APPEND wa_mara TO gt_mara.
*
*
*wa_mara-matnr = 'T30021'.
*wa_mara-maktx = 'TEST BDC'.
*wa_mara-mtart = 'ROH'.
*wa_mara-mbrsh = 'M'.
*wa_mara-meins = 'EA'.
*APPEND wa_mara TO gt_mara.

ENDFORM.
