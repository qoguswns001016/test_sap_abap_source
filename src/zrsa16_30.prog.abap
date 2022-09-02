*&---------------------------------------------------------------------*
*& Report ZRSA16_30
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa16_30.

TYPES: BEGIN OF ts_info,
         stdno TYPE n LENGTH 8,
         sname TYPE c LENGTH 40,
       END OF ts_info.

" Std Info
DATA gs_std TYPE zssa1601.

gs_std-stdno = '2022001'.
gs_std-sname = 'Kang SK'.
