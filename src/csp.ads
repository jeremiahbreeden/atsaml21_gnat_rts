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

pragma Suppress(All_Checks);

with MCU; use MCU;
with MCU.Port_IO.Generic_Pin;
with MCU.GCLK.Generic_GCLK;
with MCU.GCLK.Generic_Peripheral;
with MCU.Uart.Generic_Uart;

-- Chip Support Package
package CSP is

   package Pin_B10 is new Port_IO.Generic_Pin(Port_IO.Port_B,Port_IO.Pin_10);
   package Pin_A02 is new Port_IO.Generic_Pin(Port_IO.Port_A,Port_IO.Pin_02);
   package Pin_A22 is new Port_IO.Generic_Pin(Port_IO.Port_A,Port_IO.Pin_22);
   package Pin_A23 is new Port_IO.Generic_Pin(Port_IO.Port_A,Port_IO.Pin_23);

   package GCLK_00 is new GCLK.Generic_GCLK(GCLK.GCLK_00);
   package GCLK_01 is new GCLK.Generic_GCLK(GCLK.GCLK_01);
   package GCLK_02 is new GCLK.Generic_GCLK(GCLK.GCLK_02);
   package GCLK_03 is new GCLK.Generic_GCLK(GCLK.GCLK_03);
   package GCLK_04 is new GCLK.Generic_GCLK(GCLK.GCLK_04);
   package GCLK_05 is new GCLK.Generic_GCLK(GCLK.GCLK_05);
   package GCLK_06 is new GCLK.Generic_GCLK(GCLK.GCLK_06);
   package GCLK_07 is new GCLK.Generic_GCLK(GCLK.GCLK_07);
   package GCLK_08 is new GCLK.Generic_GCLK(GCLK.GCLK_08);

   package SERCOM3_CLK is new GCLK.Generic_Peripheral(GCLK.SERCOM_Core_3);

   package UART_3 is new Uart.Generic_Uart(Uart.UART_3);

end CSP;
