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

with System;

package body MCU.GCLK.Generic_Peripheral is
   
   use type u32;

   procedure Configure
      (GCLK             : GCLK_Name;
       Enabled_State    : Peripheral_Enable_State := Enabled;
       Write_Lock_State : Peripheral_Write_Lock   := Unlocked)
   is begin
      Peripheral_Registers.Peripherals(Peripheral) :=
         GCLK_Name'Enum_Rep(GCLK)
         or Peripheral_Enable_State'Enum_Rep(Enabled_State)
         or Peripheral_Write_Lock'Enum_Rep(Write_Lock_State);
      
      loop
         exit when (Peripheral_Registers.Peripherals(Peripheral)
            and Peripheral_Enable_State'Enum_Rep(Enabled_State)) 
            = Peripheral_Enable_State'Enum_Rep(Enabled_State);
      end loop;
   end Configure;
   
   procedure Enable is 
   begin
      Peripheral_Registers.Peripherals(Peripheral) :=
         Peripheral_Registers.Peripherals(Peripheral)
         or Peripheral_Enable_State'Enum_Rep(Enabled);

      loop
         exit when (Peripheral_Registers.Peripherals(Peripheral)
            and Peripheral_Enable_State'Enum_Rep(Enabled)) 
            /= 0;
      end loop;
   end Enable;

   procedure Disable is 
   
   begin
      Peripheral_Registers.Peripherals(Peripheral) :=
         Peripheral_Registers.Peripherals(Peripheral)
         and (not Peripheral_Enable_State'Enum_Rep(Enabled));

      loop
         exit when (Peripheral_Registers.Peripherals(Peripheral)
            and Peripheral_Enable_State'Enum_Rep(Enabled)) 
            = 0;
      end loop;
   end Disable;

end MCU.GCLK.Generic_Peripheral;
