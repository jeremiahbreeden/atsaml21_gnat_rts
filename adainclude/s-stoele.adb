------------------------------------------------------------------------------
--                                                                          --
--                         GNAT COMPILER COMPONENTS                         --
--                                                                          --
--               S Y S T E M . S T O R A G E _ E L E M E N T S              --
--                                                                          --
--                                 B o d y                                  --
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

with Ada.Unchecked_Conversion;

package body System.Storage_Elements is

   function To_Address_Impl is new Ada.Unchecked_Conversion
      (Source => Storage_Offset,
       Target => Address)
      with Inline_Always;

   function To_Storage_Offset_Impl is new Ada.Unchecked_Conversion
      (Source => Address,
       Target => Storage_Offset)
      with Inline_Always;

   function "+"(Left : Address; Right : Storage_Offset) return Address is
      (Left + To_Address_Impl (Right));
   function "+"(Left : Storage_Offset; Right : Address) return Address is
      (To_Address_Impl (Left) + Right);
   function "-"(Left : Address; Right : Storage_Offset) return Address is
      (Left - To_Address_Impl (Right));
   function "-"(Left, Right : Address) return Storage_Offset is
      (To_Storage_Offset_Impl (Left - Right));

   function "mod"
      (Left  : Address;
       Right : Storage_Offset)
       return Storage_Offset
   is ("mod" (To_Storage_Offset_Impl (Left), Right));

   function To_Address_Impl is new Ada.Unchecked_Conversion
      (Source => Integer_Address,
       Target => Address)
      with Inline_Always;

   function To_Integer_Impl is new Ada.Unchecked_Conversion
      (Source => Address,
       Target => Integer_Address)
      with Inline_Always;

   function To_Address (Value : Integer_Address) return Address is
      (To_Address_Impl (Value));
   function To_Integer (Value : Address) return Integer_Address is
      (To_Integer_Impl (Value));

end System.Storage_Elements;
