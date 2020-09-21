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

package body MCU.GCLK.Generic_GCLK is

   use type u32;

   procedure Configure
      (Clock            : Clock_Source;
       Enabled_State    : Enable_State              := Enabled;
       Clock_Output     : Output_State              := Disabled;
       Mode             : Output_Mode               := Active_High;
       Standby          : Standby_Mode              := Off;
       Balancing        : Division_Factor_Balancing := Off;
       Method           : Division_Factor_Method    := Direct)
   is begin
      GCLK_Registers.Clocks(GCLK) :=
         Clock_Source'Enum_Rep(Clock)
         or Enable_State'Enum_Rep(Enabled_State)
         or Output_State'Enum_Rep(Clock_Output)
         or Output_Mode'Enum_Rep(Mode)
         or Standby_Mode'Enum_Rep(Standby)
         or Division_Factor_Balancing'Enum_Rep(Balancing)
         or Division_Factor_Method'Enum_Rep(Method);
      loop
         exit when (Global_Registers.Sync_Busy and GCLK_Mask) = 0;
      end loop;
   end Configure;

   procedure Enable is 
   begin
      GCLK_Registers.Clocks(GCLK) := 
         GCLK_Registers.Clocks(GCLK)
         or Enable_State'Enum_Rep(Enabled);
      loop
         exit when (Global_Registers.Sync_Busy and GCLK_Mask) = 0;
      end loop;
   end Enable;

   procedure Disable is 
   begin
      GCLK_Registers.Clocks(GCLK) := 
         GCLK_Registers.Clocks(GCLK)
         and (not Enable_State'Enum_Rep(Enabled));
      loop
         exit when (Global_Registers.Sync_Busy and GCLK_Mask) = 0;
      end loop;
   end Disable;

end MCU.GCLK.Generic_GCLK;
