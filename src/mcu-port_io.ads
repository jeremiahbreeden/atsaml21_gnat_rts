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

package MCU.Port_IO with Pure is

   type Port_Type is (Port_A, Port_B, Port_C, Port_D);

   type Pin_Type is
      (Pin_00, Pin_01, Pin_02, Pin_03, Pin_04, Pin_05, Pin_06, Pin_07,
       Pin_08, Pin_09, Pin_10, Pin_11, Pin_12, Pin_13, Pin_14, Pin_15,
       Pin_16, Pin_17, Pin_18, Pin_19, Pin_20, Pin_21, Pin_22, Pin_23,
       Pin_24, Pin_25, Pin_26, Pin_27, Pin_28, Pin_29, Pin_30, Pin_31);

   type Drive_Strength_Type is (Normal, Strong);

   type Pull_Enable_Type is (Disabled, Enabled);

   type Input_Enable_Type is (Disabled, Enabled);

   type PMUX_Enable_Type is (Disabled, Enabled);

   type Sampling_Enable_Type is (Disabled, Enabled);

   type PMUX_Type is
      (Function_A, Function_B, Function_C, Function_D,
       Function_E, Function_F, Function_G, Function_H,
       Function_I);

private
   for Port_Type use
      (Port_A => 16#40002800#,
       Port_B => 16#40002880#,
       Port_C => 16#40002900#,
       Port_D => 16#40002980#);
   for Port_Type'Size use 32;

   for Pin_Type use
      (Pin_00 =>  0, Pin_01 =>  1, Pin_02 =>  2, Pin_03 =>  3,
       Pin_04 =>  4, Pin_05 =>  5, Pin_06 =>  6, Pin_07 =>  7,
       Pin_08 =>  8, Pin_09 =>  9, Pin_10 => 10, Pin_11 => 11,
       Pin_12 => 12, Pin_13 => 13, Pin_14 => 14, Pin_15 => 15,
       Pin_16 => 16, Pin_17 => 17, Pin_18 => 18, Pin_19 => 19,
       Pin_20 => 20, Pin_21 => 21, Pin_22 => 22, Pin_23 => 23,
       Pin_24 => 24, Pin_25 => 25, Pin_26 => 26, Pin_27 => 27,
       Pin_28 => 28, Pin_29 => 29, Pin_30 => 30, Pin_31 => 31);
   for Pin_Type'Size use 8;

   for Drive_Strength_Type use (Normal => 16#00#, Strong => 16#40#);
   for Drive_Strength_Type'Size use 8;

   for Pull_Enable_Type use (Disabled => 16#00#, Enabled => 16#04#);
   for Pull_Enable_Type'Size use 8;

   for Input_Enable_Type use (Disabled => 16#00#, Enabled => 16#02#);
   for Input_Enable_Type'Size use 8;

   for PMUX_Enable_Type use (Disabled => 16#00#, Enabled => 16#01#);
   for PMUX_Enable_Type'Size use 8;

   for Sampling_Enable_Type use (Disabled => 16#00#, Enabled => 16#FF#);
   for Sampling_Enable_Type'Size use 8;

   for PMUX_Type use
      (Function_A => 0, Function_B => 1, Function_C => 2, Function_D => 3,
       Function_E => 5, Function_F => 6, Function_G => 7, Function_H => 8,
       Function_I => 9);
   for PMUX_Type'Size use 8;

end MCU.Port_IO;

