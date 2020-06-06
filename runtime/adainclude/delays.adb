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

with System.Machine_Code;

package body Delays is

   --  Workhorse procedure
   procedure Delay_Cycles
     (Cycles : Positive)
   is
      Temp : Positive := Cycles;
   begin
      System.Machine_Code.Asm
   (Template  =>
      "LOOP%=: "     & LF & HT &
      "SUB %0,%0,#4" & LF & HT &
      "BHI LOOP%=",
    Outputs =>
      --  +r is necessary for GNAT optimizer
      Positive'Asm_Output ("+r", Temp),
    Clobber  => "cc",
    Volatile => True);
   end Delay_Cycles;

   procedure Delay_Ms
      (Milliseconds : Milliseconds_Type)
   is
      pragma Suppress (All_Checks);
      Value : constant Positive :=
         Cycles_Per_Millisecond * Milliseconds
            + Millisecond_Leftover_Cycles * Milliseconds / 1000;
      pragma Unsuppress (All_Checks);
   begin
      Delay_Cycles (Value);
   end Delay_Ms;

   procedure Delay_Us
     (Microseconds : Microseconds_Type)
   is
      pragma Suppress (All_Checks);
      Value : constant Positive :=
         Cycles_Per_Microsecond * Microseconds
            + Microsecond_Leftover_Cycles * Microseconds / 1000;
      pragma Unsuppress (All_Checks);
   begin
      Delay_Cycles (Value);
   end Delay_Us;

end Delays;
