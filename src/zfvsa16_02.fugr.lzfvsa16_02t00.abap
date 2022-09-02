*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZVSA16PRO.......................................*
TABLES: ZVSA16PRO, *ZVSA16PRO. "view work areas
CONTROLS: TCTRL_ZVSA16PRO
TYPE TABLEVIEW USING SCREEN '0030'.
DATA: BEGIN OF STATUS_ZVSA16PRO. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZVSA16PRO.
* Table for entries selected to show on screen
DATA: BEGIN OF ZVSA16PRO_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZVSA16PRO.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSA16PRO_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZVSA16PRO_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZVSA16PRO.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSA16PRO_TOTAL.

*.........table declarations:.................................*
TABLES: ZTSA16PRO                      .
TABLES: ZTSA16PRO_T                    .
