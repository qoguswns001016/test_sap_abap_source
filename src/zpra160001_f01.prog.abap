*&---------------------------------------------------------------------*
*& Include          ZPRA160001_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form modify_screen
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM modify_screen .

  LOOP AT SCREEN.
    CASE screen-name.
      WHEN 'PA_PBDNR' OR 'PA_VERSB'.
        screen-input = 0.
        MODIFY SCREEN.
    ENDCASE.

    CASE 'X'.
      WHEN pa_crt.
        CASE screen-group1.
          WHEN 'MAC'.
            screen-active = 0.
            MODIFY SCREEN.
        ENDCASE.

      WHEN pa_disp.
        CASE screen-group1.
          WHEN 'MAR'.
            screen-active = 0.
            MODIFY SCREEN.
        ENDCASE.
    ENDCASE.
  ENDLOOP.

ENDFORM.
