*----------------------------------------------------------------------*
***INCLUDE BC414_SQL_TRAVELAG_SF01
*----------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Form  GET_SELECTED_LINES
*&---------------------------------------------------------------------*
*      -->PT_TRAVELAG      text
*      <--CT_TRAVELAG_SEL  text
*----------------------------------------------------------------------*
FORM get_selected_lines  USING    pt_travelag     TYPE gty_t_stravelag
                         CHANGING ct_travelag_sel TYPE gty_t_stravelag.

  DATA lt_ids      TYPE lvc_t_roid.
  DATA ls_id       TYPE lvc_s_roid.
  DATA ls_travelag TYPE stravelag.

  CLEAR ct_travelag_sel.

  go_alv->get_selected_rows(
    IMPORTING
      et_row_no     = lt_ids ).

  LOOP AT lt_ids INTO ls_id.
    READ TABLE pt_travelag INTO ls_travelag INDEX ls_id-row_id.
    APPEND ls_travelag TO ct_travelag_sel.
  ENDLOOP.

ENDFORM.                    " GET_SELECTED_LINES


*&---------------------------------------------------------------------*
*&      Form  POPUP_TO_CONFIRM_LOSS_OF_DATA
*&---------------------------------------------------------------------*
FORM popup_to_confirm_loss_of_data.

  DATA lv_result TYPE c length 1.

  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      titlebar              = text-009
      text_question         = text-008
      display_cancel_button = space
    IMPORTING
      answer                = lv_result.
  CASE lv_result.
    WHEN '1'.
      LEAVE TO SCREEN '0000'.
    WHEN '2'.
      LEAVE TO SCREEN '0200'.
  ENDCASE.

ENDFORM.                               " POPUP_TO_CONFIRM_LOSS_OF_DATA


*&---------------------------------------------------------------------*
*&      Form  READ_DATA
*&---------------------------------------------------------------------*
*      <--CT_TRAVELAG  text
*----------------------------------------------------------------------*
FORM read_data CHANGING ct_travelag TYPE gty_t_stravelag.

  SELECT * FROM stravelag INTO TABLE ct_travelag.

ENDFORM.                               " READ_DATA


************************************************************************
********************************* YOUR CODE ****************************
************************************************************************
