
/* RAM is 240K because 16K are reserved for the bootloader */

MEMORY
{
  RAM   : ORIGIN = 0x20004000, LENGTH = 240K
}

SECTIONS
{
  .vector_table :
  {
    LONG(_estack)
    KEEP(*(.reset))
  } > RAM

  .text :
  {
    *(.text*)          /* .text* sections (code) */
    *(.rodata*)        /* .rodata* sections (constants, strings, etc.) */
    *(.ARM.extab* .gnu.linkonce.armextab.*)
    . = ALIGN(8);
    _etext = .;
  } > RAM

  ARM : {
    __exidx_start = .;
    *(.ARM.exidx*)
    __exidx_end = .;
  } > RAM


  __init_data = .;

  .data : AT(__init_data)
  {
    _data = .;
    *(.data*)
    . = ALIGN (8);
    _edata = .;
  } > RAM

  .bss :
  {
    _bss = .;
    _stack = .;
    . = . + 4096;
    _estack = .;
    *(.bss*)
    *(COMMON)
    _ebss = .;
  } > RAM

  /DISCARD/ :
  {
    *(.note.gnu.build-id*)
  }
}
