*&---------------------------------------------------------------------*
*& Include          YCL1A16_002_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form create_object_0100
*&---------------------------------------------------------------------*
FORM create_object_0100 .

  gcl_container = NEW cl_gui_custom_container(

    container_name          = 'MY_CONTAINER'

  ).

  gcl_grid = NEW cl_gui_alv_grid(
    i_parent                = gcl_container

  ).

ENDFORM.
*&---------------------------------------------------------------------*
*& Form select_data
*&---------------------------------------------------------------------*
FORM select_data .

  REFRESH gt_scarr.

  RANGES lr_carrid FOR scarr-carrid.
  RANGES lr_carrname FOR scarr-carrname.

  IF scarr-carrid IS INITIAL AND
     scarr-carrname IS INITIAL.
    "ID 와 이름이 둘다 공란인 경우

  ELSEIF scarr-carrid IS INITIAL.
    " 이름은 공란이 아닌경우
    lr_carrname-sign   = 'I'.        "I = include / E = Exclude : 포함 / 제외
    lr_carrname-option = 'EQ'.
    lr_carrname-low    = scarr-carrname.
    APPEND lr_carrname.
    CLEAR  lr_carrname.

  ELSEIF scarr-carrname IS INITIAL.
    " ID 가 공란이 아닌경우
    lr_carrid-sign    = 'I'.
    lr_carrid-option  = 'EQ'.
    lr_carrid-low     = scarr-carrid.
    APPEND lr_carrid.
    CLEAR  lr_carrid.

  ELSE.
    " ID 와 이름이 둘다 공란이 아닌경우

    lr_carrname-sign   = 'I'.        "I = include / E = Exclude : 포함 / 제외
    lr_carrname-option = 'EQ'.
    lr_carrname-low    = scarr-carrname.
    APPEND lr_carrname.
    CLEAR  lr_carrname.
    lr_carrid-sign     = 'I'.
    lr_carrid-option   = 'EQ'.
    lr_carrid-low      = scarr-carrid.
    APPEND lr_carrid.
    CLEAR  lr_carrid.

  ENDIF.

  SELECT *
      FROM scarr
      INTO TABLE @gt_scarr
      WHERE carrid   IN @lr_carrid   AND
            carrname IN @lr_carrname.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_alv_layout0100
*&---------------------------------------------------------------------*
FORM set_alv_layout0100 .

  CLEAR gs_layout.
  gs_layout-zebra = abap_on.
  gs_layout-sel_mode = 'D'.
  gs_layout-cwidth_opt = abap_on.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_alv_fieldcat0100
*&---------------------------------------------------------------------*
FORM set_alv_fieldcat0100 .

  DATA lt_fcat TYPE kkblo_t_fieldcat.

  CALL FUNCTION 'K_KKB_FIELDCAT_MERGE'
    EXPORTING
      i_callback_program     = sy-repid         " Internal table declaration program
*     i_tabname              =                  " Name of table to be displayed
      i_strucname            = 'SCARR'
      i_inclname             = sy-repid
      i_bypassing_buffer     = abap_on          " Ignore buffer while reading
      i_buffer_active        = abap_off
    CHANGING
      ct_fieldcat            = lt_fcat          " Field Catalog with Field Descriptions
    EXCEPTIONS
      inconsistent_interface = 1
      OTHERS                 = 2.

  IF lt_fcat[] IS INITIAL.
    MESSAGE 'ALV 필드 카탈로그 구성이 실패하였습니다.' TYPE 'E'.
  ELSE.
    CALL FUNCTION 'LVC_TRANSFER_FROM_KKBLO'
      EXPORTING
        it_fieldcat_kkblo = lt_fcat
      IMPORTING
        et_fieldcat_lvc   = gt_fcat
      EXCEPTIONS
        it_data_missing   = 1
        OTHERS            = 2.
  ENDIF.



ENDFORM.
*&---------------------------------------------------------------------*
*& Form display_alv_0100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_alv_0100 .

  CALL METHOD gcl_grid->set_table_for_first_display
    EXPORTING
      is_layout                     = gs_layout
    CHANGING
      it_outtab                     = gt_scarr[]
      it_fieldcatalog               = gt_fcat[]
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      others                        = 4.


ENDFORM.
