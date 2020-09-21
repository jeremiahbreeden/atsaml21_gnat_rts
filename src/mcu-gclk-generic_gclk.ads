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

generic 
   GCLK : GCLK_Name;
package MCU.GCLK.Generic_GCLK with Pure is

   procedure Configure
      (Clock            : Clock_Source;
       Enabled_State    : Enable_State              := Enabled;
       Clock_Output     : Output_State              := Disabled;
       Mode             : Output_Mode               := Active_High;
       Standby          : Standby_Mode              := Off;
       Balancing        : Division_Factor_Balancing := Off;
       Method           : Division_Factor_Method    := Direct);

   procedure Enable;
   procedure Disable;

private

   Global_Registers : Global_Register_Layout
      with
         Import,
         Volatile,
         Address => System'To_Address(16#40001800#);

   GCLK_Registers : GCLK_Register_Layout
      with
         Import,
         Volatile,
         Address => System'To_Address(16#40001820#);

   use all type u32;
   
   GCLK_Mask : constant u32 
      := Shift_Left(16#01#,GCLK_Name'Enum_Rep(GCLK) + 2);

end MCU.GCLK.Generic_GCLK;
