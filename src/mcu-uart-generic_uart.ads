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
   Uart : Uart_Name;
package MCU.Uart.Generic_Uart with Pure is

   -- No 64bit math support yet, so have to hand calculate the baud
   -- rate:  Baud = 65536 * (1 - (16*Baud_Rate/Clock))

   procedure Configure
      (Baud      : Baud_Rate;
       Enable    : Enable_State   := Tx_And_Rx_Enabled;
       Clock     : Clock_Source   := Internal;
       Tx_Pad    : Tx_Pad_Select  := Pad_0;
       Rx_Pad    : Rx_Pad_Select  := Pad_1;
       Bits      : Data_Size      := Bits_8;
       Parity    : Parity_Mode    := None;
       Stop_Bits : Stop_Bits_Size := Bits_1);

   procedure Enable;
   procedure Disable;

   procedure Put_8bit_Data(Data : u8);
   procedure Put_16bit_Data(Data : u16);

private

   Registers : Register_Layout
      with
         Import,
         Volatile,
         Address => System'To_Address(Uart_Name'Enum_Rep(Uart));

end MCU.Uart.Generic_Uart;
