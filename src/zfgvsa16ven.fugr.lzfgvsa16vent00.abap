*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZVSA16VEN.......................................*
TABLES: ZVSA16VEN, *ZVSA16VEN. "view work areas
CONTROLS: TCTRL_ZVSA16VEN
TYPE TABLEVIEW USING SCREEN '0010'.
DATA: BEGIN OF STATUS_ZVSA16VEN. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZVSA16VEN.
* Table for entries selected to show on screen
DATA: BEGIN OF ZVSA16VEN_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZVSA16VEN.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSA16VEN_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZVSA16VEN_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZVSA16VEN.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSA16VEN_TOTAL.

*.........table declarations:.................................*
TABLES: ZTSA16VEN                      .
