-----------------------------------------------------------------------------
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

with System;
with Interfaces; use Interfaces;

generic
   Port_Name : Port_Type;
   Pin_Name  : Pin_Type;
package MCU.Port_IO.Generic_Pin with Pure is

   procedure Configure
      (Drive_Strength : Drive_Strength_Type := Normal;
       Pull_Enable    : Pull_Enable_Type    := Disabled;
       Input_Enable   : Input_Enable_Type   := Disabled;
       PMUX_Enable    : PMUX_Enable_Type    := Disabled)
      with Inline => True;
   procedure Output_Drive  with Inline => True;
   procedure Output_Float  with Inline => True;
   procedure Output_High   with Inline => True;
   procedure Output_Low    with Inline => True;
   procedure Output_Toggle with Inline => True;
   procedure Input_Enable  with Inline => True;
   procedure Input_Disable with Inline => True;
   function Input_High return Boolean with Inline => True;
   function Input_Low  return Boolean with Inline => True;
   procedure Group_Sampling
      (Enable : Sampling_Enable_Type := Disabled)
      with Inline => True;
   procedure Configure_PMUX
      (PMUX_Function : PMUX_Type := Function_A);

private

   type SFR_PMUX_Type is array(Integer range 0..15) of u8
      with
         Size => 16*8;
   pragma Suppress_Initialization(SFR_PMUX_Type);

   type SFR_CFG_Type is array(Integer range 0..31) of u8
      with
   	Size => 32*8;
   pragma Suppress_Initialization(SFR_CFG_Type);

   type Register_Layout is record
      DIR      : u8x4;
      DIRCLR   : u8x4;
      DIRSET   : u8x4;
      DIRTGL   : u8x4;
      OUTVAL   : u8x4;
      OUTCLR   : u8x4;
      OUTSET   : u8x4;
      OUTTGL   : u8x4;
      INPUT    : u8x4;
      CTRL     : u8x4;
      WRCONFIG : u8x4;
      EVCTRL   : u8x4;
      PMUX     : SFR_PMUX_Type;
      PINCFG   : SFR_CFG_Type;
   end record
      with
         Size => 12*32 + 16*8 + 32*8;
   pragma Suppress_Initialization(Register_Layout);

   Registers : Register_Layout with
      Address => System'To_Address(Port_Type'Enum_Rep(Port_Name)),
      Volatile => True,
      Import => True;

   pragma Suppress(All_Checks);
   Byte_Index : constant Integer := Pin_Type'Enum_Rep(Pin_Name)/8;
   Pin_Value  : constant u8
      := Shift_Left(16#01#, Pin_Type'Enum_Rep(Pin_Name) mod 8);
   PMUX_Index : constant Integer := Pin_Type'Enum_Rep(Pin_Name)/2;
   PMUX_Shift : constant Integer
      := 4 * (Pin_Type'Enum_Rep(Pin_Name) mod 2);
   PMUX_Clear_Mask : constant u8
      := not Shift_Left(16#0F#,PMUX_Shift);
   CFG_Index  : constant Integer := Pin_Type'Enum_Rep(Pin_Name);
   pragma Unsuppress(All_Checks);

end MCU.Port_IO.Generic_Pin;
