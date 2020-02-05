------------------------------------------------------------------------------
--                                                                          --
--                         GNAT COMPILER COMPONENTS                         --
--                                                                          --
--                           I N T E R F A C E S                            --
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

package Interfaces with Pure, No_Elaboration_Code_All is

   type Integer_8  is range -2**(8 - 1) .. 2**(8 - 1) - 1
      with Size => 8;
   type Integer_16 is range -2**(16 - 1) .. 2**(16 - 1) - 1
      with Size => 16;
   type Integer_32 is range -2**(32 - 1) .. 2**(32 - 1) - 1
      with Size => 32;
   type Integer_64 is range -2**(64 - 1) .. 2**(64 - 1) - 1
      with Size => 64;

   type Unsigned_8  is mod 2**8  with Size => 8;
   type Unsigned_16 is mod 2**16 with Size => 16;
   type Unsigned_32 is mod 2**32 with Size => 32;
   type Unsigned_64 is mod 2**64 with Size => 64;

   function Shift_Left
      (Value  : Unsigned_8;
       Amount : Natural)
       return Unsigned_8
      with Import, Convention => Intrinsic, Pure_Function, Inline_Always;
   function Shift_Right
      (Value  : Unsigned_8;
       Amount : Natural)
       return Unsigned_8
      with Import, Convention => Intrinsic, Pure_Function, Inline_Always;
   function Shift_Right_Arithmetic
      (Value  : Unsigned_8;
       Amount : Natural)
       return Unsigned_8
      with Import, Convention => Intrinsic, Pure_Function, Inline_Always;
   function Rotate_Left
      (Value  : Unsigned_8;
       Amount : Natural)
       return Unsigned_8
      with Import, Convention => Intrinsic, Pure_Function, Inline_Always;
   function Rotate_Right
      (Value  : Unsigned_8;
       Amount : Natural)
       return Unsigned_8
      with Import, Convention => Intrinsic, Pure_Function, Inline_Always;

   function Shift_Left
      (Value  : Unsigned_16;
       Amount : Natural)
       return Unsigned_16
      with Import, Convention => Intrinsic, Pure_Function, Inline_Always;
   function Shift_Right
      (Value  : Unsigned_16;
       Amount : Natural)
       return Unsigned_16
      with Import, Convention => Intrinsic, Pure_Function, Inline_Always;
   function Shift_Right_Arithmetic
      (Value  : Unsigned_16;
       Amount : Natural)
       return Unsigned_16
      with Import, Convention => Intrinsic, Pure_Function, Inline_Always;
   function Rotate_Left
      (Value  : Unsigned_16;
       Amount : Natural)
       return Unsigned_16
      with Import, Convention => Intrinsic, Pure_Function, Inline_Always;
   function Rotate_Right
      (Value  : Unsigned_16;
       Amount : Natural)
       return Unsigned_16
      with Import, Convention => Intrinsic, Pure_Function, Inline_Always;

   function Shift_Left
      (Value  : Unsigned_32;
       Amount : Natural)
       return Unsigned_32
      with Import, Convention => Intrinsic, Pure_Function, Inline_Always;
   function Shift_Right
      (Value  : Unsigned_32;
       Amount : Natural)
       return Unsigned_32
      with Import, Convention => Intrinsic, Pure_Function, Inline_Always;
   function Shift_Right_Arithmetic
      (Value  : Unsigned_32;
       Amount : Natural)
       return Unsigned_32
      with Import, Convention => Intrinsic, Pure_Function, Inline_Always;
   function Rotate_Left
      (Value  : Unsigned_32;
       Amount : Natural)
       return Unsigned_32
      with Import, Convention => Intrinsic, Pure_Function, Inline_Always;
   function Rotate_Right
      (Value  : Unsigned_32;
       Amount : Natural)
       return Unsigned_32
      with Import, Convention => Intrinsic, Pure_Function, Inline_Always;

   function Shift_Left
      (Value  : Unsigned_64;
       Amount : Natural)
       return Unsigned_64
      with Import, Convention => Intrinsic, Pure_Function, Inline_Always;
   function Shift_Right
      (Value  : Unsigned_64;
       Amount : Natural)
       return Unsigned_64
      with Import, Convention => Intrinsic, Pure_Function, Inline_Always;
   function Shift_Right_Arithmetic
      (Value  : Unsigned_64;
       Amount : Natural)
       return Unsigned_64
      with Import, Convention => Intrinsic, Pure_Function, Inline_Always;
   function Rotate_Left
      (Value  : Unsigned_64;
       Amount : Natural)
       return Unsigned_64
      with Import, Convention => Intrinsic, Pure_Function, Inline_Always;
   function Rotate_Right
      (Value  : Unsigned_64;
       Amount : Natural)
       return Unsigned_64
      with Import, Convention => Intrinsic, Pure_Function, Inline_Always;

end Interfaces;
