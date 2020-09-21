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

with Interfaces;
with Ada.Unchecked_Conversion;

-- Top level Microcontroller package
package MCU with Pure, No_Elaboration_Code_All is

   subtype  u8 is Interfaces.Unsigned_8;
   subtype u16 is Interfaces.Unsigned_16;
   subtype u32 is Interfaces.Unsigned_32;

   type  u8x2 is array(0..1) of  u8;
   type  u8x4 is array(0..3) of  u8;
   type u16x2 is array(0..1) of u16;

   for  u8x2'Size use 2*8;
   for  u8x4'Size use 4*8;
   for u16x2'Size use 2*16;

   pragma Suppress_Initialization(u8x2);
   pragma Suppress_Initialization(u8x4);
   pragma Suppress_Initialization(u16x2);

   function To_u16 is new Ada.Unchecked_Conversion
      (Source => u8x2,
       Target => u16);
   function To_u32 is new Ada.Unchecked_Conversion
      (Source => u8x4,
       Target => u32);
   function To_u32 is new Ada.Unchecked_Conversion
      (Source => u16x2,
       Target => u32);
   function To_u8x2 is new Ada.Unchecked_Conversion
      (Source => u16,
       Target => u8x2);
   function To_u8x4 is new Ada.Unchecked_Conversion
      (Source => u32,
       Target => u8x4);
   function To_u16x2 is new Ada.Unchecked_Conversion
      (Source => u32,
       Target => u16x2);

end MCU;
