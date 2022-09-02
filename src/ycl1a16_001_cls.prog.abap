*&---------------------------------------------------------------------*
*& Include          YCL1A16_001_CLS
*&---------------------------------------------------------------------*

"ALV
" 1. List
" ㄴ WRITE
" 2. Function ALV
" ㄴ reuse
" 3. Class ALV
" ㄴ Simple ALV ( 편집 불가 )
" ㄴ Grid ALV ( 대다수 )
" ㄴ ALV with IDA( 최신 )

"Container
" 1. Cutom Container
* 2. Docking Container ( 언제든지 화면 추가가능 )
" 3. Splitter Container ( Container 가 있으면 그 Container 를 쪼갤수 있다 독자적 x
"                         Container 가 애초에 있어야 쓸수있음. )

DATA: gr_container TYPE REF TO cl_gui_docking_container,
      gr_split     TYPE REF TO cl_gui_splitter_container,
      gr_con_top   TYPE REF TO cl_gui_container,
      gr_con_alv   TYPE REF TO cl_gui_container.

DATA: gr_alv     TYPE REF TO cl_gui_alv_grid,
      gs_layout  TYPE lvc_s_layo,
      gt_fcat    TYPE lvc_t_fcat,
      gs_fcat    TYPE lvc_s_fcat,

      gs_variant TYPE disvariant,
      gv_save    TYPE c.
