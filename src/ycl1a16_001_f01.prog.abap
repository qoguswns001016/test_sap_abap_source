*&---------------------------------------------------------------------*
*& Include          YCL1A16_001_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form select_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM select_data .
  REFRESH gt_scarr. " Internal Table 초기화

  SELECT *
    FROM scarr
    INTO TABLE @gt_scarr
    WHERE carrid IN @so_car AND
          carrname IN @so_carnm.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form create_object_0100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM create_object_0100 .
  CREATE OBJECT gr_container
    EXPORTING
      repid     = sy-repid                 " Report to Which This Docking Control is Linked
      dynnr     = sy-dynnr                 " Screen to Which This Docking Control is Linked
      extension = 2000                     " Control Extension
    EXCEPTIONS
     cntl_error                  = 1                " Invalid Parent Control
     cntl_system_error           = 2                " System Error
     create_error                = 3                " Create Error
     lifetime_error              = 4                " Lifetime Error
     lifetime_dynpro_dynpro_link = 5                " LIFETIME_DYNPRO_DYNPRO_LINK
     others    = 6.

  CREATE OBJECT gr_split
    EXPORTING
      parent                  = gr_container                   " Parent Container
      rows                    = 2                    " Number of Rows to be displayed
      columns                 = 1                   " Number of Columns to be Displayed
    EXCEPTIONS
      cntl_error              = 1                  " See Superclass
      cntl_system_error       = 2                  " See Superclass
      others                  = 3.

*  call METHOD gr_split->get_container
*    EXPORTING
*      row       = 1                 " Row
*      column    = 1                " Column
*    RECEIVING
*      container =  gr_con_top                " Container
*    .

*    gr_split->get_container(
*      EXPORTING
*        row       =                  " Row
*        column    =                  " Column
**      RECEIVING
**        container =                  " Container
*    ).

    gr_con_top = gr_split->get_container( ROW = 1 column = 1 ).
    gr_con_alv = gr_split->get_container( ROW = 2 column = 1 ).

  CREATE OBJECT gr_alv
    EXPORTING
      i_parent                = gr_con_alv                  " Parent Container
    EXCEPTIONS
      error_cntl_create       = 1                " Error when creating the control
      error_cntl_init         = 2                " Error While Initializing Control
      error_cntl_link         = 3                " Error While Linking Control
      error_dp_create         = 4                " Error While Creating DataProvider Control
      others                  = 5
    .
*  gr_alv = new cl_gui_alv_grid( i_parent = gr_con_alv ).
*  gr_alv = new #( i_parent = gr_con_alv ).

*    gr_alv = new cl_gui_alv_grid(
**      i_shellstyle            = 0
**      i_lifetime              =
*      i_parent                =
**      i_appl_events           = space
**      i_parentdbg             =
**      i_applogparent          =
**      i_graphicsparent        =
**      i_name                  =
**      i_fcat_complete         = space
**      o_previous_sral_handler =
*    ).

ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_alv_layout_0100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_alv_layout_0100 .
  clear gs_layout.
  gs_layout-zebra = ABAP_ON. " 'X'
  gs_layout-sel_mode = 'D'.
  gs_layout-cwidth_opt = ABAP_on.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_alv_fieldcat_0100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_alv_fieldcat_0100 .

  DATA lt_fcat TYPE kkblo_t_fieldcat.

  call function 'KK_KKB_FIELDCAT_MERGE'
    EXPORTING
      i_callback_program     = sy-repid                 " Internal table declaration program
*      i_tabname              = '' "구조체 (TEABLES)                 " Name of table to be displayed
      i_strucname            = 'SCARR'
      i_inclname             = sy-repid
      i_bypassing_buffer     = ABAP_ON                 " Ignore buffer while reading
      i_buffer_active        = ABAP_OFF
    CHANGING
      ct_fieldcat            = lt_fcat             " Field Catalog with Field Descriptions
    EXCEPTIONS
      inconsistent_interface = 1
      others                 = 2
    .
  IF lt_fcat[] IS INITIAL.
    MESSAGE '필드 카탈로그 구성 중 오류가 발생하였습니다' TYPE'E'.
  ELSE.
    call FUNCTION 'LLVC_TRANSFER_FROM_KKBLO'
      EXPORTING
        it_fieldcat_kkblo         = lt_fcat
      IMPORTING
        et_fieldcat_lvc           = gt_fcat
      EXCEPTIONS
        it_data_missing           = 1
        others                    = 2
      .
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

  call METHOD gr_alv->set_table_for_first_display
    EXPORTING
      is_layout                     = gs_layout                 " Layout
    CHANGING
      it_outtab                     = gt_scarr[]                  " Output Table
      it_fieldcatalog               = gt_fcat[]                 " Field Catalog
    EXCEPTIONS
      invalid_parameter_combination = 1                " Wrong Parameter
      program_error                 = 2                " Program Errors
      too_many_lines                = 3                " Too many Rows in Ready for Input Grid
      others                        = 4
    .

ENDFORM.
