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

package body System.Builtins is

   use Interfaces;

   function Memory_Set
     (Target : System.Address;
      Value  : Interfaces.Unsigned_32; --  int
      Size   : Interfaces.Unsigned_32) --  size_t
     return System.Address
   is
      pragma Suppress (All_Checks);
      Data : array (Unsigned_32'Range) of Unsigned_8
         with Import, Convention => C, Address => Target, Volatile_Components;
      Value_8 : constant Unsigned_8 := Unsigned_8 (Value);
      Index   : Unsigned_32 := Data'First;
   begin
      while Index < Size loop
         Data (Index) := Value_8;
         Index := Index + 1;
      end loop;
      return Target;
   end Memory_Set;

   function Memory_Copy
     (Target : System.Address;
      Source : System.Address;
      Size   : Interfaces.Unsigned_32) --  size_t
     return System.Address
   is
      pragma Suppress (All_Checks);
      Target_Data : array (Unsigned_32'Range) of Unsigned_8
         with Import, Convention => C, Address => Target, Volatile_Components;
      Source_Data : array (Unsigned_32'Range) of Unsigned_8
         with Import, Convention => C, Address => Source;
      Index : Unsigned_32 := Target_Data'First;
   begin
      while Index < Size loop
         Target_Data (Index) := Source_Data (Index);
         Index := Index + 1;
      end loop;
      return Target;
   end Memory_Copy;

   function Memory_Compare
     (Left  : System.Address;
      Right : System.Address;
      Size  : Interfaces.Unsigned_32) --  size_t
     return Interfaces.Integer_32
   is
      pragma Suppress (All_Checks);
      Left_Data : array (Unsigned_32'Range) of Integer_8
         with Import, Convention => C, Address => Left, Volatile_Components;
      Right_Data : array (Unsigned_32'Range) of Integer_8
         with Import, Convention => C, Address => Right;
      Index : Unsigned_32 := Left_Data'First;
   begin
      while Index < Size loop
         if Left_Data (Index) /= Right_Data (Index) then
            return Integer_32 (Left_Data (Index) - Right_Data (Index));
         end if;
         Index := Index + 1;
      end loop;
      return 0;
   end Memory_Compare;

   procedure OS_Exit (Code : Interfaces.Integer_32) is
      pragma Unreferenced (Code);
   begin
      loop
         null;
      end loop;
   end OS_Exit;

   procedure Last_Chance_Handler
      (Message : System.Address;
       Line    : Interfaces.Integer_32)
   is
      pragma Unreferenced (Message, Line);
   begin
      loop
         null;
      end loop;
   end Last_Chance_Handler;

end System.Builtins;