*&---------------------------------------------------------------------*
*& Report YCL1A16_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ycl1a16_001.

INCLUDE YCL1A16_001_TOP. "전역 변수 선언
INCLUDE YCL1A16_001_CLS. "ALV 관련 선언
INCLUDE YCL1A16_001_SCR. "검색 화면
INCLUDE YCL1A16_001_PBO. "Process Before Output
INCLUDE YCL1A16_001_PAI. "Process After Input
INCLUDE YCL1A16_001_F01. "Perform

INITIALIZATION.
 " 프로그램 실행 시 가장 처음에 1회만 수행되는 이벤트 구간
textt01 = '검색조건'.
AT SELECTION-SCREEN OUTPUT.
 " 검색화면에서 화면이 출력되기 직전에 수행되는 구간
 " 주용도는 검색화면에 대한 제어 ( 특정필드 숨김 또는 읽기 전용 )
AT SELECTION-SCREEN.
 " 검색화면애서 사용자가 특정 이벤트를 발생시겼을 때 수행되는 구간
 " 상단위 Function Key 이벤트, 특정필드의 클릭, 엔터 등의 이벤트에서
 " 압력값에 대한 점검, 실행 권한 점검
START-OF-SELECTION.
 " 검색화면에서 실행버튼 눌렀을 때 수행되는 구간
 " 데이터 조회 & 데이터 출력 ( END-OF-SELECTION 이랑 같이 쓸수있음 )
 PERFORM select_data.
END-OF-SELECTION.
 " START-OF-SELECTION 이 끝나고 실행되는 구간
 " 데이터 출력
IF gt_scarr[] IS INITIAL.
  MESSAGE '데이터가 없습니다.' TYPE 'S' DISPLAY LIKE 'W'.
  ELSE.
    call screen 0100.
ENDIF.
