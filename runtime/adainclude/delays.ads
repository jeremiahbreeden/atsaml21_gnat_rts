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

generic
   Clock_Frequency_Hz : Positive;
package Delays with Pure is

   subtype Microseconds_Type is Positive range 1 .. 1000;
   subtype Milliseconds_Type is Positive range 1 .. 30000;

   procedure Delay_Cycles
     (Cycles : Positive)
     with Inline => True;
   pragma Inline_Always (Delay_Cycles);

   procedure Delay_Ms
     (Milliseconds : Milliseconds_Type)
     with Inline => True;
   pragma Inline_Always (Delay_Ms);

   procedure Delay_Us
     (Microseconds : Microseconds_Type)
     with Inline => True;
   pragma Inline_Always (Delay_Us);

private

   pragma Suppress (All_Checks);

   --  Formatting Characters
   HT : constant Character := Character'Val (9);
   LF : constant Character := Character'Val (10);

   --  Calculations
   Cycles_Per_Millisecond : constant Positive
     := Clock_Frequency_Hz / 1000;
   Cycles_Per_Microsecond : constant Positive
     := Clock_Frequency_Hz / 1_000_000;

   Millisecond_Leftover_Cycles : constant Natural
     := Clock_Frequency_Hz mod 1000;
   Microsecond_Leftover_Cycles : constant Natural
      := Clock_Frequency_Hz mod 1_000_000;

   pragma Unsuppress (All_Checks);

end Delays;
