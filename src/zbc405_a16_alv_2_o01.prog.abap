*&---------------------------------------------------------------------*
*& Include          ZBC405_A16_ALV_2_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S100'.
  SET TITLEBAR 'T100' WITH sy-datum.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CREATE_ALV_OBJECT OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE create_alv_object OUTPUT.

  IF go_container IS INITIAL.
    CREATE OBJECT go_container
      EXPORTING
        container_name = 'MY_CONTROL_AREA'.
    IF sy-subrc EQ 0.
      CREATE OBJECT go_alv
        EXPORTING
          i_parent = go_container.

      IF sy-subrc EQ 0.
*        PERFORM set_variant.
*      PERFORM set_layout.
*      PERFORM set_sort.
*      PERFORM make_fieldcatalog.

      APPEND cl_gui_alv_grid=>mc_fc_filter to gt_exct.
      APPEND cl_gui_alv_grid=>mc_fc_info to gt_exct.

      set HANDLER lcl_handler=>on_doubleclick for go_alv.
        CALL METHOD go_alv->set_table_for_first_display
          EXPORTING
*           i_buffer_active  =
*           i_bypassing_buffer            =
*           i_consistency_check           =
            i_structure_name = 'ZTSBOOK_A16' "  기본적으로 테이블안에 있는 필드들을 표에 보여주는것
            is_variant       = gs_variant
            i_save           = 'A'      " ' ' A  X  U 설정이 누가 가능한지 모두, 나만, 등..
            i_default        = 'X'
            is_layout        = gs_layout
*           is_print         =
*           it_special_groups             =
           it_toolbar_excluding          = gt_exct
*           it_hyperlink     =
*           it_alv_graphics  =
*           it_except_qinfo  =
*           ir_salv_adapter  =
          CHANGING
            it_outtab        = gt_sbook
           it_fieldcatalog  = gt_fcat
            it_sort          = gt_sort
*           it_filter        =
*      EXCEPTIONS
*           invalid_parameter_combination = 1
*           program_error    = 2
*           too_many_lines   = 3
*           others           = 4
          .
        IF sy-subrc <> 0.
*     Implement suitable error handling here
        ENDIF.
      ENDIF.

    ENDIF.

  ELSE.
*-- refresh alv method
  ENDIF.

ENDMODULE.
