*&---------------------------------------------------------------------*
*& Report ZRSA16_24
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zrsa16_24_top                           .    " Global Data

* INCLUDE ZRSA16_24_O01                           .  " PBO-Modules
* INCLUDE ZRSA16_24_I01                           .  " PAI-Modules
INCLUDE zrsa16_24_f01                           .  " FORM-Routines

*Event
*LOAD-OF-PROGRAM. " INITIALIZATION 이랑 똑같이 RunTime 에 띡 한번만 실행된다. 하지만 밑에와 달리 아무곳에서나 사용가능.
INITIALIZATION. " 최초에(RunTime에 딱 한번 실행된다. ( TYPE '1').  Excuteple program 에서 만 사용할수있다.
*  select SINGLE carrid connid
*    from spfli
*    INTO (pa_car, pa_con).
  IF sy-uname = 'KD-A-16'.
    pa_car = 'AA'.
    pa_con = '0017'.
  ENDIF.

AT SELECTION-SCREEN OUTPUT. " PBO 셀렉션 스크린이 시작되기전에 실행(selection screen 화면 뜨기전에).

AT SELECTION-SCREEN. "PAI 프로세스 에프터 인풋. "selection screen 에서 실행버튼을 실행했을때 바로 뜬다.
 If pa_con is INITIAL.
*   MESSAGE i016(pn) WITH 'Check'.
*   STOP. " i message 를 쓰면 아래로 넘어가지는데 stop 을 쓰면 넘어가지 않는다 하지만 w 나 e 를 쓰는게 훨씬 좋다.
   MESSAGE w016(pn) WITH 'Check'.
 ENDIF.
START-OF-SELECTION. " selection screen 에서 실행버튼 눌렀을때 selection screen 은 없어지고 뜬다.

  " Get Info List
  PERFORM get_info.
  WRITE 'test'. " 이렇게 WRITE 를 쓰면 밑에 메세지를 s016으로 쓰면 메세지가 WRITE buffer 영역에 뜨게 된다.
  IF gt_info IS INITIAL.
    "S 밑에 message 가 뜨고 그냥 아래있는 코드도 실행된다.
    "I 파업창으로 message 가 뜨고 아래있는 코드도 실행된다.
    "E 밑에 에러가 뜨고 selection screen에서 넘어가지 않고 다시 selection screen 이 실행된다.
    "W 밑에 경고가 뜨고 다시 한번 누르면 아래있는 코드로 넘어간다.
    "A
    "X dump 경고가 뜨면서 끝난다.
    MESSAGE i016(pn) WITH 'Data is not found'.
    RETURN. " return 을 하면 다시 selection screen 으로 간다.
  ENDIF.
  cl_demo_output=>display_data( gt_info ).
*IF gs_info is not INITIAL.
*cl_demo_output=>display_data( gt_info ).
*ELSE.
*ENDIF.
