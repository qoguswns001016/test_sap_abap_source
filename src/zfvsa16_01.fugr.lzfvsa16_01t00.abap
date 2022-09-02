*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZVSA1699........................................*
TABLES: ZVSA1699, *ZVSA1699. "view work areas
CONTROLS: TCTRL_ZVSA1699
TYPE TABLEVIEW USING SCREEN '0030'.
DATA: BEGIN OF STATUS_ZVSA1699. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZVSA1699.
* Table for entries selected to show on screen
DATA: BEGIN OF ZVSA1699_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZVSA1699.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSA1699_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZVSA1699_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZVSA1699.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVSA1699_TOTAL.

*.........table declarations:.................................*
TABLES: ZTSA1699                       .
