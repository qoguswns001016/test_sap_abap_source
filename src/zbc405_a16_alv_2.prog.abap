*&---------------------------------------------------------------------*
*& Report ZBC405_A16_ALV_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zbc405_a16_alv_2_top                    .    " Global Data
*INCLUDE zbc405_a16_alv_2_class.
*INCLUDE zbc405_a16_alv_2_o01                    .  " PBO-Modules
*INCLUDE zbc405_a16_alv_2_i01                    .  " PAI-Modules
*INCLUDE zbc405_a16_alv_2_f01                    .  " FORM-Routines
*
*INITIALIZATION.
*  gs_variant-report = sy-cprog.
*
*AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_layout.
*
*AT SELECTION-SCREEN.
**  PERFORM get_data.
*  CALL SCREEN 100.
