*&---------------------------------------------------------------------*
*& Include          ZBC405_A16_EXAM_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.
  CASE ok_code.
    WHEN 'BACK' OR 'EXIT' OR 'CANC'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  DATA ls_ans TYPE c LENGTH 1.

  CASE ok_code.
WHEN 'SAVE'.
  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      titlebar       = 'Data Save'
      text_question  = 'Do you want save?'
      text_button_1  = 'YES'(001)
*     ICON_BUTTON_1  = ' '
      text_button_2  = 'NO'(002)
*     ICON_BUTTON_2  = ' '
*     DEFAULT_BUTTON = '1'
*     DISPLAY_CANCEL_BUTTON       = 'X'
    IMPORTING
      answer         = ls_ans
    EXCEPTIONS
      text_not_found = 1
      OTHERS         = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  IF ls_ans = '1'.
    PERFORM data_save.
  ENDIF.


ENDCASE.
ENDMODULE.
