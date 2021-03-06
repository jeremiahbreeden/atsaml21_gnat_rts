/****************************************************************************
 *                                                                          *
 *                            Linker Script File                            *
 *                                                                          *
 * GNAT is free software;  you can  redistribute it  and/or modify it under * 
 * terms of the  GNU General Public License as published  by the Free Soft- * 
 * ware  Foundation;  either version 3,  or (at your option) any later ver- * 
 * sion.  GNAT is distributed in the hope that it will be useful, but WITH- * 
 * OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY * 
 * or FITNESS FOR A PARTICULAR PURPOSE.                                     * 
 *                                                                          * 
 * As a special exception under Section 7 of GPL version 3, you are granted * 
 * additional permissions described in the GCC Runtime Library Exception,   * 
 * version 3.1, as published by the Free Software Foundation.               * 
 *                                                                          * 
 * You should have received a copy of the GNU General Public License and    * 
 * a copy of the GCC Runtime Library Exception along with this program;     * 
 * see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    * 
 * <http://www.gnu.org/licenses/>.                                          * 
 *                                                                          * 
 * GNARL was developed by the GNARL team at Florida State University.       *
 * Extensive contributions were provided by Ada Core Technologies, Inc.     *
 * The  executive  was developed  by the  Real-Time  Systems  Group  at the *
 * Technical University of Madrid.                                          *
 *                                                                          *
 ****************************************************************************/

SEARCH_DIR(.)
__DYNAMIC  =  0;

_SRAM_SIZE = 32K;

ENTRY(vector_table);

MEMORY
{
  flash (rx)  : ORIGIN = 0x00000000, LENGTH = 256K
  sram (rwx)  : ORIGIN = 0x20000000, LENGTH = 32K
}

SECTIONS
{
  .text :
  {
    LONG(__stack_end)
    KEEP (*(.vectors))
    *(.text .text.* .gnu.linkonce.t*)
    *(.gnu.warning)
  } > flash

  .rodata :
  {
    *(.lit)
    *(.rodata .rodata.* .gnu.linkonce.r*)
    . = ALIGN(0x4);
    __rom_end = .;
  } > flash

  __data_load = __rom_end;
  .data : AT (__rom_end)
  {
    __data_start = .;
    *(.data .data.* .gnu.linkonce.d*)

    /* Ensure that the end of the data section is always word aligned.
       Initial values are stored in 4-bytes blocks so we must guarantee
       that these blocks do not fall out the section (otherwise they are
       truncated and the initial data for the last block are lost). */

    . = ALIGN(0x4);
    __data_end = .;
  } > sram
  __data_words = (__data_end - __data_start) >> 2;

  .bss (NOLOAD): {
   . = ALIGN(0x8);
   __bss_start = .;

   *(.bss .bss.*)
   *(COMMON)

   . = ALIGN(0x8);    /* Align the stack to 64 bits */
   __bss_end = .;

   __interrupt_stack_start = .;
   *(.interrupt_stacks)
   . = ALIGN(0x8);
   __interrupt_stack_end = .;

   __stack_start = .;
   . = ALIGN(_SRAM_SIZE);
   __stack_end = .;

   _end = .;
  } > sram

  __bss_words = (__bss_end - __bss_start) >> 2;

  /* DWARF debug sections.
     Symbols in the DWARF debugging sections are relative to the beginning
     of the section so we begin them at 0.  */
  /* DWARF 1 */
  .debug          0 : { *(.debug) }
  .line           0 : { *(.line) }
  /* GNU DWARF 1 extensions */
  .debug_srcinfo  0 : { *(.debug_srcinfo) }
  .debug_sfnames  0 : { *(.debug_sfnames) }
  /* DWARF 1.1 and DWARF 2 */
  .debug_aranges  0 : { *(.debug_aranges) }
  .debug_pubnames 0 : { *(.debug_pubnames) }
  /* DWARF 2 */
  .debug_info     0 : { *(.debug_info .gnu.linkonce.wi.*) }
  .debug_abbrev   0 : { *(.debug_abbrev) }
  .debug_line     0 : { *(.debug_line) }
  .debug_frame    0 : { *(.debug_frame) }
  .debug_str      0 : { *(.debug_str) }
  .debug_loc      0 : { *(.debug_loc) }
  .debug_macinfo  0 : { *(.debug_macinfo) }
  /* DWARF 3 */
  .debug_pubtypes 0 : { *(.debug_pubtypes) }
  .debug_ranges   0 : { *(.debug_ranges) }
  .gnu.attributes 0 : { KEEP (*(.gnu.attributes)) }
  /DISCARD/ : { *(.note.GNU-stack) *(.gnu_debuglink) *(.gnu.lto_*) }

  /DISCARD/ : { *(.ARM.extab .ARM.exidx) }
}
