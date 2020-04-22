------------------------------------------------------------------------------
--                      Copyright (C) 2016 - Present                        --
--                            Jeremiah Breeden                              --
--                           All Rights Reserved                            --
--                                                                          --
--  This library is free software;  you can redistribute it and/or modify   --
--  it under terms of the  GNU General Public License  as published by the  --
--  Free Software  Foundation;  either version 3,  or (at your  option) any --
--  later version. This library is distributed in the hope that it will be  --
--  useful, but WITHOUT ANY WARRANTY;  without even the implied warranty of --
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                    --
--                                                                          --
--  As a special exception under Section 7 of GPL version 3, you are        --
--  granted additional permissions described in the GCC Runtime Library     --
--  Exception, version 3.1, as published by the Free Software Foundation.   --
--                                                                          --
--  You should have received a copy of the GNU General Public License and   --
--  a copy of the GCC Runtime Library Exception along with this program;    --
--  see the files COPYING and COPYING.RUNTIME respectively.  If not, see    --
--  <http://www.gnu.org/licenses/>.                                         --
--                                                                          --
--  As a special exception, if other files instantiate generics from this   --
--  unit, or you link this unit with other files to produce an executable,  --
--  this  unit  does not  by itself cause  the resulting executable to be   --
--  covered by the GNU General Public License. This exception does not      --
--  however invalidate any other reasons why the executable file might be   --
--  covered by the GNU Public License.                                      --
------------------------------------------------------------------------------

package Interrupts with Pure, No_Elaboration_Code_All is

   Reset       : constant String := "Reset_Handler";
   NMI         : constant String := "NMI_Handler";
   Hard_Fault  : constant String := "Hard_Fault_Handler";
   SVC         : constant String := "SVC_Handler";
   Pend_SV     : constant String := "Pend_SV_Handler";
   System_Tick : constant String := "System_Tick_Handler";
   System      : constant String := "System_Handler";
   WDT         : constant String := "WDT_Handler";
   RTC         : constant String := "RTC_Handler";
   EIC         : constant String := "EIC_Handler";
   NVMC        : constant String := "NVMC_Handler";
   DMAC        : constant String := "DMAC_Handler";
   USB         : constant String := "USB_Handler";
   EVSYS       : constant String := "EVSYS_Handler";
   SERCOM0     : constant String := "SERCOM0_Handler";
   SERCOM1     : constant String := "SERCOM1_Handler";
   SERCOM2     : constant String := "SERCOM2_Handler";
   SERCOM3     : constant String := "SERCOM3_Handler";
   SERCOM4     : constant String := "SERCOM4_Handler";
   SERCOM5     : constant String := "SERCOM5_Handler";
   TCC0        : constant String := "TCC0_Handler";
   TCC1        : constant String := "TCC1_Handler";
   TCC2        : constant String := "TCC2_Handler";
   TC0         : constant String := "TC0_Handler";
   TC1         : constant String := "TC1_Handler";
   TC2         : constant String := "TC2_Handler";
   TC3         : constant String := "TC3_Handler";
   TC4         : constant String := "TC4_Handler";
   ADC         : constant String := "ADC_Handler";
   AC          : constant String := "AC_Handler";
   DAC         : constant String := "DAC_Handler";
   PTC         : constant String := "PTC_Handler";
   AES         : constant String := "AES_Handler";
   TRNG        : constant String := "TRNG_Handler";

private

   --  Handler Imports.
   procedure NMI_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.NMI;
   procedure Hard_Fault_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.Hard_Fault;
   procedure SVC_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.SVC;
   procedure Pend_SV_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.Pend_SV;
   procedure System_Tick_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.System_Tick;
   procedure System_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.System;
   procedure WDT_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.WDT;
   procedure RTC_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.RTC;
   procedure EIC_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.EIC;
   procedure NVMC_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.NVMC;
   procedure DMAC_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.DMAC;
   procedure USB_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.USB;
   procedure EVSYS_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.EVSYS;
   procedure SERCOM0_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.SERCOM0;
   procedure SERCOM1_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.SERCOM1;
   procedure SERCOM2_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.SERCOM2;
   procedure SERCOM3_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.SERCOM3;
   procedure SERCOM4_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.SERCOM4;
   procedure SERCOM5_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.SERCOM5;
   procedure TCC0_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.TCC0;
   procedure TCC1_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.TCC1;
   procedure TCC2_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.TCC2;
   procedure TC0_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.TC0;
   procedure TC1_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.TC1;
   procedure TC2_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.TC2;
   procedure TC3_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.TC3;
   procedure TC4_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.TC4;
   procedure ADC_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.ADC;
   procedure AC_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.AC;
   procedure DAC_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.DAC;
   procedure PTC_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.PTC;
   procedure AES_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.AES;
   procedure TRNG_Handler
     with
     Import => True,
     Convention => C,
     External_Name => Interrupts.TRNG;

   --  Make all the imported functions weak so
   --  that the programmer only needs to populate
   --  the ones being used.  Would also like to alias
   --  them all to a dummy ISR, but cannot get GNAT
   --  to do that correctly yet.
   pragma Weak_External (NMI_Handler);
   pragma Weak_External (Hard_Fault_Handler);
   pragma Weak_External (SVC_Handler);
   pragma Weak_External (Pend_SV_Handler);
   pragma Weak_External (System_Tick_Handler);
   pragma Weak_External (System_Handler);
   pragma Weak_External (WDT_Handler);
   pragma Weak_External (RTC_Handler);
   pragma Weak_External (EIC_Handler);
   pragma Weak_External (NVMC_Handler);
   pragma Weak_External (DMAC_Handler);
   pragma Weak_External (USB_Handler);
   pragma Weak_External (EVSYS_Handler);
   pragma Weak_External (SERCOM0_Handler);
   pragma Weak_External (SERCOM1_Handler);
   pragma Weak_External (SERCOM2_Handler);
   pragma Weak_External (SERCOM3_Handler);
   pragma Weak_External (SERCOM4_Handler);
   pragma Weak_External (SERCOM5_Handler);
   pragma Weak_External (TCC0_Handler);
   pragma Weak_External (TCC1_Handler);
   pragma Weak_External (TCC2_Handler);
   pragma Weak_External (TC0_Handler);
   pragma Weak_External (TC1_Handler);
   pragma Weak_External (TC2_Handler);
   pragma Weak_External (TC3_Handler);
   pragma Weak_External (TC4_Handler);
   pragma Weak_External (ADC_Handler);
   pragma Weak_External (AC_Handler);
   pragma Weak_External (DAC_Handler);
   pragma Weak_External (PTC_Handler);
   pragma Weak_External (AES_Handler);
   pragma Weak_External (TRNG_Handler);

   --  Generate the table to be placed into memory.
   type Interrupt_Vector_Address is access procedure with Convention => C;
   type Interrupt_Vector_Table is array (1 .. 44) of Interrupt_Vector_Address;
   pragma Suppress_Initialization (Interrupt_Vector_Table);

   -- Import from System.Startup
   procedure Reset_Handler
   with
      Convention => C,
      Import,
      External_Name => Interrupts.Reset;

   Vector_Table : constant array (1 .. 44) of Interrupt_Vector_Address :=
     (1  => Reset_Handler'Access,
      2  => NMI_Handler'Access,
      3  => Hard_Fault_Handler'Access,
      4  .. 10 => null,
      11 => SVC_Handler'Access,
      12 .. 13 => null,
      14 => Pend_SV_Handler'Access,
      15 => System_Tick_Handler'Access,
      16 => System_Handler'Access,
      17 => WDT_Handler'Access,
      18 => RTC_Handler'Access,
      19 => EIC_Handler'Access,
      20 => NVMC_Handler'Access,
      21 => DMAC_Handler'Access,
      22 => USB_Handler'Access,
      23 => EVSYS_Handler'Access,
      24 => SERCOM0_Handler'Access,
      25 => SERCOM1_Handler'Access,
      26 => SERCOM2_Handler'Access,
      27 => SERCOM3_Handler'Access,
      28 => SERCOM4_Handler'Access,
      29 => SERCOM5_Handler'Access,
      30 => TCC0_Handler'Access,
      31 => TCC1_Handler'Access,
      32 => TCC2_Handler'Access,
      33 => TC0_Handler'Access,
      34 => TC1_Handler'Access,
      35 => TC2_Handler'Access,
      36 => TC3_Handler'Access,
      37 => TC4_Handler'Access,
      38 => ADC_Handler'Access,
      39 => AC_Handler'Access,
      40 => DAC_Handler'Access,
      41 => PTC_Handler'Access,
      42 => AES_Handler'Access,
      43 => TRNG_Handler'Access,
      44 => null);
   pragma Export (C, Vector_Table, "vector_table");
   pragma Linker_Section (Vector_Table, ".vectors");

end Interrupts;
