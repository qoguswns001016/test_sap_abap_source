*&---------------------------------------------------------------------*
*& Include          ZBC405_A16_EXAM_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  CASE pa_edit.
    WHEN 'X'.
      SET PF-STATUS 'S100'.
    WHEN OTHERS.
      SET PF-STATUS 'S100' EXCLUDING 'SAVE'.
  ENDCASE.
  SET TITLEBAR 'T100' WITH sy-datum sy-uname.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CREAT_ALV_OBJECT OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE creat_alv_object OUTPUT.
  IF go_container IS INITIAL.
    CREATE OBJECT go_container
      EXPORTING
        container_name = 'MY_CONTROL_AREA'.
    IF sy-subrc = 0.
      CREATE OBJECT go_alv
        EXPORTING
          i_parent = go_container.
      IF sy-subrc = 0.
        "layout
        PERFORM set_layout.
        PERFORM set_fieldcatalog.

        APPEND cl_gui_alv_grid=>mc_fc_loc_cut TO gt_exct.
        APPEND cl_gui_alv_grid=>mc_fc_loc_copy TO gt_exct.
        APPEND cl_gui_alv_grid=>mc_mb_paste TO gt_exct.
        APPEND cl_gui_alv_grid=>mc_fc_loc_undo TO gt_exct.
        APPEND cl_gui_alv_grid=>mc_fc_loc_append_row TO gt_exct.
        APPEND cl_gui_alv_grid=>mc_fc_loc_insert_row TO gt_exct.
        APPEND cl_gui_alv_grid=>mc_fc_loc_delete_row TO gt_exct.
        APPEND cl_gui_alv_grid=>mc_fc_loc_copy_row TO gt_exct.

        CALL METHOD go_alv->register_edit_event
          EXPORTING
            i_event_id = cl_gui_alv_grid=>mc_evt_enter.
        SET HANDLER lcl_handler=>on_toolbar FOR go_alv.
        SET HANDLER lcl_handler=>on_user_command FOR go_alv.
        SET HANDLER lcl_handler=>on_double_click FOR go_alv.
        SET HANDLER lcl_handler=>on_data_changed FOR go_alv.

        CALL METHOD go_alv->set_table_for_first_display
          EXPORTING
*           i_buffer_active      =
*           i_bypassing_buffer   =
*           i_consistency_check  =
            i_structure_name     = 'ZTSPFLI_A16'
            is_variant           = gs_variant
*           i_save               =
            i_default            = 'X'
            is_layout            = gs_layout
*           is_print             =
*           it_special_groups    =
            it_toolbar_excluding = gt_exct
*           it_hyperlink         =
*           it_alv_graphics      =
*           it_except_qinfo      =
*           ir_salv_adapter      =
          CHANGING
            it_outtab            = gt_spfli
            it_fieldcatalog      = gt_fcat
*           it_sort              =
*           it_filter            =
*          EXCEPTIONS
*           invalid_parameter_combination = 1
*           program_error        = 2
*           too_many_lines       = 3
*           others               = 4
          .
        IF sy-subrc <> 0.
*         Implement suitable error handling here
        ENDIF.

      ENDIF.
      IF sy-subrc <> 0.
*       MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*                  WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
      ENDIF.

    ENDIF.
  ENDIF.
ENDMODULE.
