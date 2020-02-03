------------------------------------------------------------------------------
--                                                                          --
--                         GNAT COMPILER COMPONENTS                         --
--                                                                          --
--               S Y S T E M . S T O R A G E _ E L E M E N T S              --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
--       Copyright (C) 2002-2013, 2018, Free Software Foundation, Inc.      --
--                                                                          --
-- This specification is derived from the Ada Reference Manual for use with --
-- GNAT. The copyright notice above, and the license provisions that follow --
-- apply solely to the implementation dependent sections of this file.      --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
-- As a special exception under Section 7 of GPL version 3, you are granted --
-- additional permissions described in the GCC Runtime Library Exception,   --
-- version 3.1, as published by the Free Software Foundation.               --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
------------------------------------------------------------------------------

package System.Storage_Elements with Pure, No_Elaboration_Code_All is

   type Storage_Offset is range
      -(2 ** (Address_Size - 1)) .. +(2 ** (Address_Size - 1)) - 1
   with Size => Address_Size;

   subtype Storage_Count is Storage_Offset range 0 .. Storage_Offset'Last;

   type Storage_Element is mod 2**Storage_Unit;
   for Storage_Element'Size use Storage_Unit;
   type Storage_Array is array
      (Storage_Offset range <>) of aliased Storage_Element;
   for Storage_Array'Component_Size use Storage_Unit;

   --  Address Arithmetic:

   function "+"(Left : Address; Right : Storage_Offset) return Address
      with Convention => Intrinsic, Inline_Always, Pure_Function;
   function "+"(Left : Storage_Offset; Right : Address) return Address
      with Convention => Intrinsic, Inline_Always, Pure_Function;
   function "-"(Left : Address; Right : Storage_Offset) return Address
      with Convention => Intrinsic, Inline_Always, Pure_Function;
   function "-"(Left, Right : Address) return Storage_Offset
      with Convention => Intrinsic, Inline_Always, Pure_Function;

   function "mod"(Left : Address; Right : Storage_Offset) return Storage_Offset
      with Convention => Intrinsic, Inline_Always, Pure_Function;

   --  Conversion to/from integers:

   type Integer_Address is mod Memory_Size with Size => Address_Size;
   function To_Address (Value : Integer_Address) return Address
      with Convention => Intrinsic, Inline_Always, Pure_Function;
   function To_Integer (Value : Address) return Integer_Address
      with Convention => Intrinsic, Inline_Always, Pure_Function;

end System.Storage_Elements;
