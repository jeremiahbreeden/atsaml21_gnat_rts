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

with Interfaces;

--  Contains various "built in" operations needed for this runtime
private package System.Builtins with Pure is

   function Memory_Set
     (Target : System.Address;
      Value  : Interfaces.Unsigned_32; --  int
      Size   : Interfaces.Unsigned_32) --  size_t
     return System.Address
   with
      Convention => C,
      Export,
      External_Name => "memset";

   function Memory_Copy
     (Target : System.Address;
      Source : System.Address;
      Size   : Interfaces.Unsigned_32) --  size_t
     return System.Address
   with
      Convention => C,
      Export,
      External_Name => "memcpy";

   function Memory_Compare
     (Left  : System.Address;
      Right : System.Address;
      Size  : Interfaces.Unsigned_32) --  size_t
     return Interfaces.Integer_32
   with
      Convention => C,
      Export,
      External_Name => "memcmp";

   procedure OS_Exit (Code : Interfaces.Integer_32)
   with
      Convention => C,
      Export,
      External_Name => "exit",
      No_Return;

   procedure Last_Chance_Handler
      (Message : System.Address;
       Line    : Interfaces.Integer_32)
   with
      Convention => C,
      Export,
      External_Name => "__gnat_last_chance_handler",
      No_Return;

end System.Builtins;
