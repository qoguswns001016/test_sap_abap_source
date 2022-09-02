class ZCL_BC425_16_NBD_PX definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_EX_BC425_16_PX_BADI .
protected section.
private section.
ENDCLASS.



CLASS ZCL_BC425_16_NBD_PX IMPLEMENTATION.


  method IF_EX_BC425_16_PX_BADI~WRITE_ADDITIONAL_COLS.

      WRITE: i_wa_spfli-distance, i_wa_spfli-distid.

  endmethod.
ENDCLASS.
