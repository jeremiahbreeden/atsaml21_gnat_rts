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

package MCU.Uart with Pure is
   
   type Uart_Name is
      (UART_0,
       UART_1,
       UART_2,
       UART_3,
       UART_4,
       UART_5);
   
   subtype Baud_Rate is u16;
   
   type Enable_State is
      (Disabled,
       Tx_Enabled,
       Rx_Enabled,
       Tx_And_Rx_Enabled);
   
   type Clock_Source is
      (External,
       Internal);
   
   type Data_Size is
      (Bits_8,
       Bits_9,
       Bits_5,
       Bits_6,
       Bits_7);
   
   type Parity_Mode is
      (None,
       Even,
       Odd);
   
   type Stop_Bits_Size is
      (Bits_1,
       Bits_2);
   
   type Tx_Pad_Select is 
      (Pad_0,
       Pad_2,
       Pad_0_RTS_CTS);
   
   type Rx_Pad_Select is
      (Pad_0,
       Pad_1,
       Pad_2,
       Pad_3);
   
private
   
   for Uart_Name use
      (UART_0 => 16#42000000#,
       UART_1 => 16#42000400#,
       UART_2 => 16#42000800#,
       UART_3 => 16#42000C00#,
       UART_4 => 16#42001000#,
       UART_5 => 16#43000400#);
   for Uart_Name'Size use 32;
   
   for Enable_State use
      (Disabled          => 16#00000000#,
       Tx_Enabled        => 16#00010002#,
       Rx_Enabled        => 16#00020002#,
       Tx_And_Rx_Enabled => 16#00030002#);
   For Enable_State'Size use 32;
   CTRLA_Enable_Mask : constant := 16#00000002#;
   CTRLB_Enable_Mask : constant := 16#00030000#;
   
   for Clock_Source use
      (External => 16#00000000#,
       Internal => 16#00000004#);
   for Clock_Source'Size use 32;
   
   for Data_Size use
      (Bits_8 => 16#00#,
       Bits_9 => 16#01#,
       Bits_5 => 16#05#,
       Bits_6 => 16#06#,
       Bits_7 => 16#07#);
   for Data_Size'Size use 32;
   
   for Parity_Mode use
      (None => 16#00000000#,
       Even => 16#01000000#,
       Odd  => 16#01002000#);
   for Parity_Mode'Size use 32;
   Parity_Enable_Mask : constant := 16#01000000#;
   Parity_Type_Mask   : constant := 16#00002000#;
   
   for Stop_Bits_Size use
      (Bits_1 => 16#00000000#,
       Bits_2 => 16#00004000#);
   for Stop_Bits_Size'Size use 32;
   
   for Tx_Pad_Select use 
      (Pad_0         => 16#00000000#,
       Pad_2         => 16#00010000#,
       Pad_0_RTS_CTS => 16#00020000#);
   for Tx_Pad_Select'Size use 32;
   
   for Rx_Pad_Select use
      (Pad_0 => 16#00000000#,
       Pad_1 => 16#00100000#,
       Pad_2 => 16#00200000#,
       Pad_3 => 16#00400000#);
   for Rx_Pad_Select'Size use 32;
   
   LSB_First_Mask : constant := 16#40000000#;
   
   Data_8bit_Mask : constant := 16#00FF#;
   Tx_Flag_Mask   : constant := 16#01#;
   
   type Register_Layout is limited record
      CTRLA                  : u32;
      CTRLB                  : u32;
      Reserved01             : u32;
      Baud_Rate              : u16;
      Rxpl                   : u8;
      Reserved02             : u8;
      Reserved03             : u32;
      Clear_Interrupt_Enable : u8;
      Reserved04             : u8;
      Set_Interrupt_Enable   : u8;
      Reserved05             : u8;
      Interrupt_Flags        : u8;
      Reserved06             : u8;
      Status                 : u16;
      Sync_Busy              : u32;
      Reserved07             : u32;
      Reserved08             : u32;
      Data                   : u16;
      Reserved09             : u16;
      Reserved10             : u32;
      Debug_Control          : u8;
   end record;
   pragma Suppress_Initialization(Register_Layout);

end MCU.Uart;
