*&---------------------------------------------------------------------*
*& Report ZBC405_A16_M04
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE ZBC405_A16_M04_TOP                      .    " Global Data

* INCLUDE ZBC405_A16_M04_O01                      .  " PBO-Modules
* INCLUDE ZBC405_A16_M04_I01                      .  " PAI-Modules
* INCLUDE ZBC405_A16_M04_F01                      .  " FORM-Routines

INITIALIZATION. "초기값 설정
gv_text = '버튼'.
gv_chg = 1.

tab1 = 'car Info'.
tab2 = 'fldate'.
tab3 = 'connid'.

"PBO
AT SELECTION-SCREEN OUTPUT.
  LOOP AT SCREEN.
    CASE SCREEN-GROUP1.
      WHEN 'GR1'.
        SCREEN-ACTIVE = gv_chg.
        MODIFY SCREEN.
     ENDCASE.

  ENDLOOP.

"PAI
AT SELECTION-SCREEN.
  CHECK sy-dynnr = '1000'.
  CASE sscrfields-ucomm.
    WHEN 'ON'.
      CASE gv_chg.
        WHEN '1'.
      gv_chg = 0.
        WHEN '0'.
      gv_chg = 1.
      ENDCASE.
  ENDCASE.
