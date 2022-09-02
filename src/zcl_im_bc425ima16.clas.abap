class ZCL_IM_BC425IMA16 definition
  public
  final
  create public .

public section.

  interfaces IF_EX_BADI_BOOK16 .
protected section.
private section.
ENDCLASS.



CLASS ZCL_IM_BC425IMA16 IMPLEMENTATION.


  method IF_EX_BADI_BOOK16~CHANGE_VLINE.
    c_pos = c_pos + 25.
  endmethod.


  method IF_EX_BADI_BOOK16~OUTPUT.
    DATA bname TYPE ztscustom_a16-name.

    select SINGLE name
      from ztscustom_a16
      into bname
      WHERE id = i_booking-customid.

    WRITE: bname , i_booking-order_date.
  endmethod.
ENDCLASS.
