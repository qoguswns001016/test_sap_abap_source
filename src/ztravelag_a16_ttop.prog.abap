*&---------------------------------------------------------------------*
*& Include BC414_TRAVELAG_TTOP                                           *
*&---------------------------------------------------------------------*

PROGRAM sapbc414_travelag_t MESSAGE-ID bc414.

TYPES gty_t_stravelag TYPE STANDARD TABLE OF stravelag
                      WITH NON-UNIQUE DEFAULT KEY.

* Workarea for transport of field values from/to screen 100
TABLES: stravelag.

* Internal table for travel agency data buffering, corresponding workarea
DATA gt_travelag TYPE gty_t_stravelag.
DATA gs_travelag TYPE stravelag.

* Selected travel agencies, corresponding workarea
DATA gt_travelag_sel TYPE gty_t_stravelag.

* transport function code from screen 100
DATA ok_code TYPE sy-ucomm.

* Flags
DATA gv_sel_changed TYPE c LENGTH 1.  "changes performed on table control
DATA gv_refresh     TYPE c LENGTH 1.  "data displayed by ALV not up to date

* ALV related variables
DATA go_container TYPE REF TO cl_gui_custom_container.
DATA go_alv       TYPE REF TO cl_gui_alv_grid.
DATA gs_layout    TYPE        lvc_s_layo.

**************************** CONTROLS **********************************
* Table control structure on screen 100
CONTROLS: tc_stravelag TYPE TABLEVIEW USING SCREEN '0200'.
