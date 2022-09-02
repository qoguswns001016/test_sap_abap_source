*&---------------------------------------------------------------------*
*& Include          ZBC405_A16_EXAM_E01
*&---------------------------------------------------------------------*
INITIALIZATION.
  gs_variant-report = sy-repid.

AT SELECTION-SCREEN on VALUE-REQUEST FOR pa_var.
  CALL FUNCTION 'LVC_VARIANT_SAVE_LOAD'
   EXPORTING

     I_SAVE_LOAD                 = 'F'
    CHANGING
      cs_variant                  = gs_variant
            .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ELSE.
    pa_var = gs_variant-variant.
  ENDIF.

START-OF-SELECTION.
  PERFORM get_data.
  PERFORM set_data.
  CALL SCREEN 100.
