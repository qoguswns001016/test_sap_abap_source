*&---------------------------------------------------------------------*
*& Report ZRSA16_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa16_05.

*DATA gv_ecode TYPE c LENGTH 4 VALUE 'SYNC'.
CONSTANTS gc_ecode TYPE c LENGTH 4 VALUE 'SYNC'.

WRITE 'New Name'(t02).
WRITE 'New Name'(t02).

*WRITE text-t01.
*WRITE text-t01.

*WRITE 'Last Name :'.
*WRITE 'Name :'.

*WRITE gc_ecode.
*
*gc_ecode = 'TEST'.

*TYPES t_name TYPE c LENGTH 10.
*
*DATA gv_name TYPE t_name.
*DATA gv_cname TYPE t_name.

*DATA gv_d1 TYPE d.
*DATA gv_d2 TYPE sy-datum.
*
*WRITE: gv_d1,gv_d2.

*DATA: gv_c1 TYPE c LENGTH 1,
*      gv_c2(1) TYPE c,
*      gv_c3 TYPE c,
*      gv_c4.

*DATA: gv_n1 TYPE n,
*      gv_n2 TYPE n LENGTH 2,
*      gv_i TYPE i.
*
*WRITE: gv_n1, gv_n2, gv_i.
