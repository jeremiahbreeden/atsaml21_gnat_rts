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

package body MCU.Port_IO.Generic_Pin is

   procedure Configure
      (Drive_Strength : Drive_Strength_Type := Normal;
       Pull_Enable    : Pull_Enable_Type    := Disabled;
       Input_Enable   : Input_Enable_Type   := Disabled;
       PMUX_Enable    : PMUX_Enable_Type    := Disabled)
   is
   begin
      Registers.PINCFG(CFG_Index) :=
         u8(Drive_Strength_Type'Enum_Rep(Drive_Strength))
         or u8(Pull_Enable_Type'Enum_Rep(Pull_Enable))
         or u8(Input_Enable_Type'Enum_Rep(Input_Enable))
         or u8(PMUX_Enable_Type'Enum_Rep(PMUX_Enable));
   end Configure;

   procedure Output_Drive
   is
   begin
      Registers.DIRSET(Byte_Index) := Pin_Value;
   end Output_Drive;

   procedure Output_Float
   is
   begin
      Registers.DIRCLR(Byte_Index) := Pin_Value;
   end Output_Float;

   procedure Output_High
   is
   begin
      Registers.OUTSET(Byte_Index) := Pin_Value;
   end Output_High;

   procedure Output_Low
   is
   begin
      Registers.OUTCLR(Byte_Index) := Pin_Value;
   end Output_Low;

   procedure Output_Toggle
   is
   begin
      Registers.OUTTGL(Byte_Index) := Pin_Value;
   end Output_Toggle;

   procedure Input_Enable
   is
   begin
      Registers.PINCFG(CFG_Index) := Registers.PINCFG(CFG_Index) or Pin_Value;
   end Input_Enable;

   procedure Input_Disable
   is
   begin
      Registers.PINCFG(CFG_Index) := Registers.PINCFG(CFG_Index) and not Pin_Value;
   end Input_Disable;

   function Input_High return Boolean
   is
   begin
      return ((Registers.INPUT(Byte_Index) and Pin_Value) /= 0);
   end Input_High;

   function Input_Low return Boolean
   is
   begin
      return ((Registers.INPUT(Byte_Index) and Pin_Value) = 0);
   end Input_Low;

   procedure Group_Sampling
      (Enable : Sampling_Enable_Type := Disabled)
   is
   begin
      Registers.CTRL(Byte_Index) := Sampling_Enable_Type'Enum_Rep(Enable);
   end Group_Sampling;

   procedure Configure_PMUX
      (PMUX_Function : PMUX_Type := Function_A)
   is
   begin
      Registers.PMUX(PMUX_Index)
         := (Registers.PMUX(PMUX_Index) and PMUX_Clear_Mask)
         or Shift_Left(PMUX_Type'Enum_Rep(PMUX_Function),PMUX_Shift);
   end Configure_PMUX;

end MCU.Port_IO.Generic_Pin;
