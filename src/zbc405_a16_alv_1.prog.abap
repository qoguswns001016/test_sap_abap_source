*&---------------------------------------------------------------------*
*& Report ZBC405_A20_ALV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zbc405_a16_alv_1_top.
*INCLUDE zbc405_a20_alv_top                      .    " Global Data

* INCLUDE ZBC405_A20_ALV_O01                      .  " PBO-Modules
* INCLUDE ZBC405_A20_ALV_I01                      .  " PAI-Modules
INCLUDE zbc405_a20_alv_f01                      .  " FORM-Routines
INCLUDE zbc405_a16_alv_class.

AT SELECTION-SCREEN.


AT SELECTION-SCREEN ON VALUE-REQUEST FOR pa_lv.

  gs_variant-report = sy-cprog. "F4기능을 사용할 때만 해당 구문을 탐

  CALL FUNCTION 'LVC_VARIANT_SAVE_LOAD'
    EXPORTING
*     I_TITLE         =
*     I_SCREEN_START_COLUMN       = 0
*     I_SCREEN_START_LINE         = 0
*     I_SCREEN_END_COLUMN         = 0
*     I_SCREEN_END_LINE           = 0
      i_save_load     = 'F'     "S,F,L S = SAVE F = F4 L = LOAD
*     I_TOOL          = 'LT'
*     I_TABNAME       = '1'
*     I_USER_SPECIFIC = ' '
*     I_DEFAULT       = 'X'
*     I_NO_REPTEXT_OPTIMIZE       = 'X'
*     I_DIALOG        = 'X'
*     IR_TO_CL_ALV_BDS            =
*     IR_TO_CL_ALV_VARIANT        =
*     I_BYPASSING_BUFFER          =
*     I_BUFFER_ACTIVE =
*     I_FCAT_COMPLETE =
*   IMPORTING
*     ES_SELFIELD     =
*     E_BDS_SAVE      =
*     E_GRAPHICS_SAVE =
*     E_EXIT          =
*   TABLES
*     IT_DATA         =
    CHANGING
      cs_variant      = gs_variant
*     CS_LAYOUT       =
*     CT_FIELDCAT     =
*     CT_DEFAULT_FIELDCAT         =
*     CT_SORT         =
*     CT_FILTER       =
*     CT_GROUPLEVELS_FILTER       =
*     C_SUMLEVEL      =
    EXCEPTIONS
      not_found       = 1
      wrong_input     = 2
      fc_not_complete = 3
      OTHERS          = 4.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ELSE.
    pa_lv = gs_variant-variant.
  ENDIF.

START-OF-SELECTION.

  PERFORM get_data.


  CALL SCREEN 100.

*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S100'.
  SET TITLEBAR 'T100' WITH sy-datum sy-uname.
ENDMODULE.


*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'BACK' OR 'CANC'.
      SET SCREEN 0.
      LEAVE SCREEN.

      CALL METHOD: go_alv_grid->free,
                   go_container->free.
      FREE : go_alv_grid, go_container.
    WHEN 'EXIT'.
      LEAVE PROGRAM.

      CALL METHOD: go_alv_grid->free,
                   go_container->free.
      FREE : go_alv_grid, go_container.

  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CREATE_AND_TRANSFER OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE create_and_transfer OUTPUT.


  PERFORM make_layout.
  PERFORM make_variant.
  PERFORM make_sort.
  PERFORM make_fieldcatalog.

  APPEND cl_gui_alv_grid=>mc_fc_filter TO gt_exct.
  APPEND cl_gui_alv_grid=>mc_fc_info TO gt_exct.

*  APPEND cl_gui_alv_grid=>mc_fc_excl_all to gt_exct. "toolbar 가 모두 사라지는것.

  "CONTAINER 생성
  IF go_container IS INITIAL.
    CREATE OBJECT go_container
      EXPORTING
*       parent         =
        container_name = 'MY_CONTROL_AREA'
*       style          =
*       lifetime       = lifetime_default
*       repid          =
*       dynnr          =
*       no_autodef_progid_dynnr     =
      EXCEPTIONS
*       cntl_error     = 1
*       cntl_system_error           = 2
*       create_error   = 3
*       lifetime_error = 4
*       lifetime_dynpro_dynpro_link = 5
        OTHERS         = 6.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

  ENDIF.

  "GRID 생성

  CREATE OBJECT go_alv_grid
    EXPORTING
*     i_shellstyle      = 0
*     i_lifetime        =
      i_parent = go_container
*     i_appl_events     = SPACE
*     i_parentdbg       =
*     i_applogparent    =
*     i_graphicsparent  =
*     i_name   =
*     i_fcat_complete   = SPACE
*     o_previous_sral_handler =
    EXCEPTIONS
*     error_cntl_create = 1
*     error_cntl_init   = 2
*     error_cntl_link   = 3
*     error_dp_create   = 4
      OTHERS   = 5.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
               WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.


  SET HANDLER lcl_handler=>on_doubleclick FOR go_alv_grid.
  SET HANDLER lcl_handler=>on_hotspot FOR go_alv_grid.
  SET HANDLER lcl_handler=>on_toolbar FOR go_alv_grid.
  SET HANDLER lcl_handler=>on_user_command FOR go_alv_grid.
  SET HANDLER lcl_handler=>on_button_click FOR go_alv_grid.
  SET HANDLER lcl_handler=>on_context_menu_request FOR go_alv_grid.
  SET HANDLER lcl_handler=>on_before_user_com FOR go_alv_grid.
  "METHOD 호출
  CALL METHOD go_alv_grid->set_table_for_first_display
    EXPORTING
*     i_buffer_active               =
*     i_bypassing_buffer            =
*     i_consistency_check           =
      i_structure_name              = 'SFLIGHT'
      is_variant                    = gs_variant          "ㅣ
      i_save                        = gv_save    "X grobal, A, U 유저만.  "/
      i_default                     = 'X'                 "/ variant 를 위한것,
      is_layout                     = gs_layout
*     is_print                      =
*     it_special_groups             =
      it_toolbar_excluding          = gt_exct
*     it_hyperlink                  =
*     it_alv_graphics               =
*     it_except_qinfo               =
*     ir_salv_adapter               =
    CHANGING
      it_outtab                     = gt_flt
      it_fieldcatalog               = gt_fcat
      it_sort                       = gt_sort
*     it_filter                     =
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      OTHERS                        = 4.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDMODULE.
