*&---------------------------------------------------------------------*
*& Report ZPG_A16_4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpg_a16_4.

TYPES: BEGIN OF gty_data,
         matnr TYPE mara-matnr,
         maktx TYPE makt-maktx,
         mtart TYPE mara-mtart,
         mtbez TYPE t134t-mtbez,
         mbrsh TYPE mara-mbrsh,
         mbbez TYPE t137t-mbbez,
         tragr TYPE mara-tragr,
         vtext TYPE ttgrt-vtext,
       END OF gty_data.

DATA: gs_data TYPE gty_data,
      gt_data LIKE TABLE OF gs_data.

DATA lv_tabix TYPE sy-tabix.

DATA: gs_t134t TYPE t134t,
      gs_t137t TYPE t137t,
      gs_ttgrt TYPE ttgrt,
      gt_t134t LIKE TABLE OF gs_t134t,
      gt_t137t LIKE TABLE OF gs_t137t,
      gt_ttgrt LIKE TABLE OF gs_ttgrt.

CLEAR: gs_data, gs_t134t, gs_t137t, gs_ttgrt.
REFRESH: gt_data, gt_t134t, gt_t137t, gt_ttgrt.

SELECT mtbez mtart
  FROM t134t
  INTO CORRESPONDING FIELDS OF TABLE gt_t134t
  WHERE spras = sy-langu.

SELECT mbbez mbrsh
  FROM t137t
  INTO CORRESPONDING FIELDS OF TABLE gt_t137t
  WHERE spras = sy-langu.

SELECT tragr vtext
  FROM ttgrt
  INTO CORRESPONDING FIELDS OF TABLE gt_ttgrt
  WHERE spras = sy-langu.

SELECT r~matnr k~maktx r~mtart r~mbrsh r~tragr
  FROM mara AS r INNER JOIN makt AS k
  ON r~matnr = k~matnr
  INTO CORRESPONDING FIELDS OF TABLE gt_data
  WHERE k~spras = sy-langu.

LOOP AT gt_data INTO gs_data.
  lv_tabix = sy-tabix.
  READ TABLE gt_t134t INTO gs_t134t WITH KEY mtart = gs_data-mtart.
  READ TABLE gt_t137t INTO gs_t137t WITH KEY mbrsh = gs_data-mbrsh.
  READ TABLE gt_ttgrt INTO gs_ttgrt WITH KEY tragr = gs_data-tragr.

  gs_data-mtbez = gs_t134t-mtbez.
  gs_data-mbbez = gs_t137t-mbbez.
  gs_data-vtext = gs_ttgrt-vtext.

  MODIFY gt_data FROM gs_data INDEX lv_tabix TRANSPORTING mtbez mbbez vtext.

  CLEAR: gs_data, gs_t134t, gs_t137t, gs_ttgrt.

ENDLOOP.

cl_demo_output=>display_data( gt_data ).
