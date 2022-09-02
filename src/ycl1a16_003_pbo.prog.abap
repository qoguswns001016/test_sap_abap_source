*&---------------------------------------------------------------------*
*& Include          YCL1A16_002_PBO
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
 SET PF-STATUS 'S100'.
 SET TITLEBAR 'T100' with sy-datum.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_ALV_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_alv_0100 OUTPUT.
  IF gcl_grid IS BOUND.
    PERFORM refresh_grid_0100.
  ELSE.
    PERFORM create_object_0100.
    PERFORM set_alv_fieldcat0100.
    PERFORM display_alv_0100.
    PERFORM set_alv_layout0100.

  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Form refresh_grid_0100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM refresh_grid_0100 .

  CHECK gcl_grid IS BOUND.

  DATA ls_stable TYPE lvc_s_stbl.
  ls_stable-row = abap_on.
  ls_stable-col = abap_on.

  CALL METHOD gcl_grid->refresh_table_display
    EXPORTING
      is_stable      = ls_stable
      i_soft_refresh = space  "space: 설정된 필터나 정렬정보를 초기화 한다.
      "'X' : 설정된 필터나 정렬정보를 초기화 한다.
    EXCEPTIONS
      finished       = 1
      OTHERS         = 2.


ENDFORM.
