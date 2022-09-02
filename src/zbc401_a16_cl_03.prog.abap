*&---------------------------------------------------------------------*
*& Report ZBC401_T03_CL_03
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc401_a16_cl_03.


CLASS cl_1 DEFINITION.
  PUBLIC SECTION.
    DATA: num1 TYPE i.
    METHODS: pro IMPORTING num2 TYPE i.
    EVENTS: cutoff,
            cuton.
ENDCLASS.

CLASS cl_1 IMPLEMENTATION.
  METHOD pro.
    num1 = num2.
    IF num2 >= 5.
      RAISE EVENT cutoff.
    ELSE.
      RAISE EVENT cuton.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

CLASS cl_event DEFINITION.
  PUBLIC SECTION.
    METHODS: handling_cutoff FOR EVENT cutoff OF cl_1,
      handling_cuton FOR EVENT cuton OF cl_1.
ENDCLASS.


CLASS cl_event IMPLEMENTATION.
  METHOD handling_cutoff.
    WRITE: 'Handling the CutOff'.
    WRITE: / 'Event has been processed'.
  ENDMETHOD.

  METHOD handling_cuton.
    WRITE: 'BBABABABABAB'.
  ENDMETHOD.
ENDCLASS.



START-OF-SELECTION.
  DATA: main1 TYPE REF TO cl_1.
  DATA: eventh1 TYPE REF TO cl_event.

  CREATE OBJECT main1.
  CREATE OBJECT eventh1.

  SET HANDLER eventh1->handling_cutoff FOR main1.
  main1->pro( 1 ).
