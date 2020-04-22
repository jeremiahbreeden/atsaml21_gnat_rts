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

with System.Machine_Code;
with System.Address_To_Access_Conversions;
with Interfaces;

package body System.Startup is

   subtype LD_Type is Interfaces.Unsigned_32;

   --  Data Section constants.  Do not use constants directly.
   --  Instead, use 'Address as Linker symbols are addresses
   LD_Data_Start : constant LD_Type;
   pragma Import (Asm, LD_Data_Start, "__data_start");
   LD_Data_End   : constant LD_Type;
   pragma Import (Asm, LD_Data_End, "__data_end");
   LD_Data_Load  : constant LD_Type;
   pragma Import (Asm, LD_Data_Load, "__data_load");

   --  BSS Section constants.  Do not use constants directly.
   --  Instead, use 'Address as Linker symbols are addresses
   LD_BSS_Start  : constant LD_Type;
   pragma Import (Asm, LD_BSS_Start, "__bss_start");
   LD_BSS_End    : constant LD_Type;
   pragma Import (Asm, LD_BSS_End, "__bss_end");

   --  Stack constants.  Do not use constants directly.
   --  Instead, use 'Address as Linker symbols are addresses
   LD_Stack_End  : constant LD_Type;
   pragma Import (Asm, LD_Stack_End, "__stack_end");

   procedure Copy_Data;
   procedure Clear_BSS;
   procedure Initialize_Stack_Pointer with Inline_Always => True;

   procedure Start_ROM
     with
     Export,
     Convention => C,
     External_Name => "_start_rom";
   procedure Start_RAM
     with
     Export,
     Convention => C,
     External_Name => "_start_ram";

   procedure Initialize_Stack_Pointer is
   begin
      System.Machine_Code.Asm
         (Template => "mov sp, %0",
          Inputs   => System.Address'Asm_Input ("r", LD_Stack_End'Address),
          Volatile => True,
          Clobber  => "sp");
   end Initialize_Stack_Pointer;

   procedure Copy_Data is
      Source_Address      : System.Address := LD_Data_Load'Address;
      Destination_Address : System.Address := LD_Data_Start'Address;
      package Convert is new System.Address_To_Access_Conversions
        (Object => Interfaces.Unsigned_32);
   begin
      while Destination_Address < LD_Data_End'Address
      loop
         Convert.To_Pointer (Destination_Address).all
           := Convert.To_Pointer (Source_Address).all;
         Source_Address      := Source_Address      + Address'(4);
         Destination_Address := Destination_Address + Address'(4);
      end loop;
   end Copy_Data;

   procedure Clear_BSS is
      Current_Address : System.Address := LD_BSS_Start'Address;
      package Convert is new System.Address_To_Access_Conversions
        (Object => Interfaces.Unsigned_32);
   begin
      while Current_Address < LD_BSS_End'Address
      loop
         Convert.To_Pointer (Current_Address).all := 0;
         Current_Address := Current_Address + Address'(4);
      end loop;
   end Clear_BSS;

   procedure Main;
   pragma Import (Asm, Main, "main");
   procedure Exit_Startup (Code : Interfaces.Integer_32);
   pragma Import (C, Exit_Startup, "exit");

   procedure Start_ROM is
   begin
      Copy_Data;
      Clear_BSS;
      Main;
      Exit_Startup (0);
   end Start_ROM;

   procedure Start_RAM is
   begin
      Initialize_Stack_Pointer;
      Clear_BSS;
      Main;
      Exit_Startup (0);
   end Start_RAM;

   procedure Reset_Handler is
   begin
      Start_ROM;

      loop
         null;
      end loop;
   end Reset_Handler;

end System.Startup;
