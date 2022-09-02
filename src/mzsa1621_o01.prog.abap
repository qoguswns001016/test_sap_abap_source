*&---------------------------------------------------------------------*
*& Include          MZSA1621_O01
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
*& Module SET_DYNNR OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE set_dynnr OUTPUT.
  CASE em_info-activetab.
    WHEN 'TAB1'.
      gv_dynnr = '0101'.
    WHen 'TAB2'.
      gv_dynnr = '0102'.
    WHEN OTHERS.
      gv_dynnr = '0101'.
      em_info-activetab = 'TAB1'.
   ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CLEAR_GV OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE clear_gv OUTPUT.
 CLEAR: gv_subrc, ok_code.
ENDMODULE.
