*----------------------------------------------------------------------*
***INCLUDE BC414_SQL_TRAVELAG_SI01
*----------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*MODULE exit INPUT.
*
*  CASE ok_code.
*    WHEN 'EXIT'.
*      LEAVE PROGRAM.
*    WHEN 'CANCEL'.
*      CASE sy-dynnr.
*        WHEN '0100'.
*          LEAVE TO SCREEN '0000'.
*        WHEN '0200'.
*          IF sy-datar IS INITIAL.
**           no changes performed on screen
*            LEAVE TO SCREEN '0000'.
*          ELSE.
**           at least one field on table control changed.
*            PERFORM popup_to_confirm_loss_of_data.
*          ENDIF.
*      ENDCASE.
*  ENDCASE.
*
*ENDMODULE.                             " EXIT  INPUT
*
*
**&---------------------------------------------------------------------*
**&      Module  USER_COMMAND_0100  INPUT
**&---------------------------------------------------------------------*
*MODULE user_command_0100 INPUT.
*
*  CASE ok_code.
*    WHEN 'BACK'.
*      SET SCREEN '0000'.
*    WHEN 'EDIT'.
*      gv_sel_changed = abap_true.
*      CALL SCREEN '0200' STARTING AT  5  5
*                         ENDING   AT 80 15.
*      SET SCREEN '0100'.
*  ENDCASE.
*
*ENDMODULE.                             " USER_COMMAND_0100  INPUT
*
*
**&---------------------------------------------------------------------*
**&      Module  USER_COMMAND_0200  INPUT
**&---------------------------------------------------------------------*
*MODULE user_command_0200 INPUT.
*
*  CASE ok_code.
*    WHEN 'SAVE'.
**     ToDo: Save changes
*      update stravelag from TABLE gt_teavelag_sel.
*      IF sy-subrc = 0.
*         MESSAGE s000(zt03_msg) WITH 'Successfull'.
*      ELSE.
*         MESSAGE s000(zt03_msg) WITH 'not update'.
*      ENDIF.
*      SET SCREEN '0000'.
**     Stravelag data changed on database
*      gv_refresh = abap_true.
*  ENDCASE.
*
*ENDMODULE.                             " USER_COMMAND_0200  INPUT
*
*
**&---------------------------------------------------------------------*
**&      Module  TRANS_FROM_0200  INPUT
**&---------------------------------------------------------------------*
*MODULE trans_from_0200 INPUT.
*
*  MOVE-CORRESPONDING stravelag TO gs_travelag.
*  MODIFY gt_travelag_sel FROM gs_travelag INDEX tc_stravelag-current_line.
*
*ENDMODULE.                             " TRANS_FROM_0200  INPUT
