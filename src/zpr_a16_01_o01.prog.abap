*&---------------------------------------------------------------------*
*& Include          ZPR_A16_01_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S100'.
  SET TITLEBAR 'T100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module SET_SCREEN OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE set_screen OUTPUT.
  PERFORM set_screen.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module SET_FCAT_LAYOUT OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE set_fcat_layout OUTPUT.
  PERFORM set_fcat_layout.
ENDMODULE.