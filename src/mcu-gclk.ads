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

package MCU.GCLK with Pure is

   type GCLK_Name is 
      (GCLK_00,
       GCLK_01,
       GCLK_02,
       GCLK_03,
       GCLK_04,
       GCLK_05,
       GCLK_06,
       GCLK_07,
       GCLK_08);

   type Standby_Mode is (Off,On);
   type Division_Factor_Method is (Direct,Equation);
   type Output_State is (Disabled,Enabled);
   type Output_Mode is (Active_High,Active_Low);
   type Division_Factor_Balancing is (Off,On);
   type Enable_State is (Disabled,Enabled);

   type Clock_Source is
      (External_Oscillator,
       GCLK_IO_Input,
       Generic_Clock_01,
       Internal_Low_Power_32kHz,
       Internal_32kHz,
       External_32kHz,
       Internal_16MHz,
       Frequency_Locked_Loop_48MHz,
       Phase_Locked_Loop);

   type Peripheral_Type is
      (DFLL48MHz_Reference,
       PLL_Input,
       PLL_32kHz,
       External_Interrupt_Controller,
       Universal_Serial_Bus,
       EVSYS_Channel_00,
       EVSYS_Channel_01,
       EVSYS_Channel_02,
       EVSYS_Channel_03,
       EVSYS_Channel_04,
       EVSYS_Channel_05,
       EVSYS_Channel_06,
       EVSYS_Channel_07,
       EVSYS_Channel_08,
       EVSYS_Channel_09,
       EVSYS_Channel_10,
       EVSYS_Channel_11,
       SERCOM_Slow_1_2_3_4,
       SERCOM_Core_0,
       SERCOM_Core_1,
       SERCOM_Core_2,
       SERCOM_Core_3,
       SERCOM_Core_4,
       SERCOM_Slow_5,
       SERCOM_Core_5,
       Timer_Counter_For_Control_0_1,
       Timer_Counter_For_Control_2,
       Timer_Counter_0_1,
       Timer_Counter_2_3,
       Timer_Counter_4,
       Analog_To_Digital_Controller,
       Analog_Comparators,
       Digital_To_Analog_Controller,
       Peripheral_Touch_Controller,
       Configurable_Custom_Logic);

   type Peripheral_Write_Lock is (Unlocked,Locked);
   type Peripheral_Enable_State is (Disabled,Enabled);

private

   for GCLK_Name use 
      (GCLK_00 => 0,
       GCLK_01 => 1,
       GCLK_02 => 2,
       GCLK_03 => 3,
       GCLK_04 => 4,
       GCLK_05 => 5,
       GCLK_06 => 6,
       GCLK_07 => 7,
       GCLK_08 => 8);
   for GCLK_Name'Size use 32;

   for Standby_Mode use 
      (Off => 16#00000000#,
       On  => 16#00002000#);
   for Standby_Mode'Size use 32;

   for Division_Factor_Method use 
      (Direct   => 16#00000000#,
       Equation => 16#00001000#);
   for Division_Factor_Method'Size use 32;

   for Output_State use 
      (Disabled => 16#00000000#,
       Enabled  => 16#00000800#);
   for Output_State'Size use 32;

   for Output_Mode use 
      (Active_High => 16#00000000#,
       Active_Low  => 16#00000400#);
   for Output_Mode'Size use 32;

   for Division_Factor_Balancing use 
      (Off => 16#00000000#,
       On  => 16#00000200#);
   for Division_Factor_Balancing'Size use 32;

   for Enable_State use 
      (Disabled => 16#00000000#,
       Enabled  => 16#00000100#);
   for Enable_State'Size use 32;

   for Clock_Source'Size use 8;

   for Peripheral_Type'Size use 8;

   for Peripheral_Write_Lock use 
      (Unlocked => 16#00000000#,
       Locked   => 16#00000080#);
   for Peripheral_Write_Lock'Size use 32;

   for Peripheral_Enable_State use 
      (Disabled => 16#00000000#,
       Enabled  => 16#00000040#);
   for Peripheral_Enable_State'Size use 32;

   type Global_Register_Layout is record
      CTRLA     : u32;
      Sync_Busy : u32;
   end record;
   for Global_Register_Layout'Size use 32 + 32;
   pragma Suppress_Initialization(Global_Register_Layout);

   pragma Suppress(All_Checks);
   
   GCLK_Count : constant :=
      GCLK_Name'Pos(GCLK_Name'Last) -
      GCLK_Name'Pos(GCLK_Name'First) + 1;
   
   Peripheral_Count : constant := 
      Peripheral_Type'Pos(Peripheral_Type'Last) - 
      Peripheral_Type'Pos(Peripheral_Type'First) + 1;
   
   pragma Unsuppress(All_Checks);

   type GCLK_Array is array
      (GCLK_Name'Range)
   of u32;
   for GCLK_Array'Size use 32*GCLK_Count;
   pragma Suppress_Initialization(GCLK_Array);

   type GCLK_Register_Layout is limited record
      Clocks : GCLK_Array;
   end record;
   for GCLK_Register_Layout'Size use 32*GCLK_Count;
   pragma Suppress_Initialization(GCLK_Register_Layout);

   type Peripheral_Array is array 
      (Peripheral_Type'Range) 
   of u32;
   for Peripheral_Array'Size use 32*Peripheral_Count;
   pragma Suppress_Initialization(Peripheral_Array);

   type Peripheral_Register_Layout is limited record 
      Peripherals : Peripheral_Array;
   end record;
   for Peripheral_Register_Layout'Size use 32*Peripheral_Count;
   pragma Suppress_Initialization(Peripheral_Register_Layout);

end MCU.GCLK;
