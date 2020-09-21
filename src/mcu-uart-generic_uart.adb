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

package body MCU.Uart.Generic_Uart is
   
   use type  u8;
   use type u16;
   use type u32;
   
   procedure Configure
      (Baud      : Baud_Rate;
       Enable    : Enable_State   := Tx_And_Rx_Enabled;
       Clock     : Clock_Source   := Internal;
       Tx_Pad    : Tx_Pad_Select  := Pad_0;
       Rx_Pad    : Rx_Pad_Select  := Pad_1;
       Bits      : Data_Size      := Bits_8;
       Parity    : Parity_Mode    := None;
       Stop_Bits : Stop_Bits_Size := Bits_1)
   is begin
      
      -- Disable and clear the control register
      Registers.CTRLA := 0;
      loop
         exit when Registers.Sync_Busy = 0;
      end loop;
      
      -- Clear the 2nd control register
      Registers.CTRLB := 0;
      loop
         exit when Registers.Sync_Busy = 0;
      end loop;
      
      -- Configure the first control register except for enable:
      Registers.CTRLA :=
         Clock_Source'Enum_Rep(Clock)
         or Tx_Pad_Select'Enum_Rep(Tx_Pad)
         or Rx_Pad_Select'Enum_Rep(Rx_Pad)
         or (Parity_Mode'Enum_Rep(Parity) and Parity_Enable_Mask)
         or LSB_First_Mask;
      
      -- Configure the second control register except for enable
      Registers.CTRLB := 
         (Parity_Mode'Enum_Rep(Parity) and Parity_Type_Mask)
         or Stop_Bits_Size'Enum_Rep(Stop_Bits)
         or Data_Size'Enum_Rep(Bits);
      
      -- Set the baud rate
      Registers.Baud_Rate := Baud;
      
      -- Enable buffers first
      Registers.CTRLB := 
         Registers.CTRLB
         or (Enable_State'Enum_Rep(Enable) and CTRLB_Enable_Mask);
      loop
         exit when Registers.Sync_Busy = 0;
      end loop;
      
      -- Enable the Uart now
      Registers.CTRLA := 
         Registers.CTRLA 
         or (Enable_State'Enum_Rep(Enable) and CTRLA_Enable_Mask);
      loop
         exit when Registers.Sync_Busy = 0;
      end loop;
      
   end Configure;

   procedure Enable is 
   begin
      -- Enable the Uart now
      Registers.CTRLA := 
         Registers.CTRLA or CTRLA_Enable_Mask;
      loop
         exit when Registers.Sync_Busy = 0;
      end loop;
   end Enable;
   
   procedure Disable is 
   begin
      -- Disable the Uart now
      Registers.CTRLA := 
         Registers.CTRLA and (not CTRLA_Enable_Mask);
      loop
         exit when Registers.Sync_Busy = 0;
      end loop;
   end Disable;
   
   procedure Put_8bit_Data(Data : u8) is
   begin
      -- Wait until room to put data
      loop
         exit when (Registers.Interrupt_Flags and Tx_Flag_Mask) /= 0;
      end loop;
      
      -- Send data
      Registers.Data := Data_8bit_Mask and u16(Data);
      
   end Put_8bit_Data;
   
   procedure Put_16bit_Data(Data : u16) is
   begin
      -- Wait until room to put data
      loop
         exit when (Registers.Interrupt_Flags and Tx_Flag_Mask) /= 0;
      end loop;
      
      -- Send data
      Registers.Data := Data;
   end Put_16bit_Data;

end MCU.Uart.Generic_Uart;
