------------------------------------------------------------------------------
--                                                                          --
--                         GNAT COMPILER COMPONENTS                         --
--                                                                          --
--              A D A . U N C H E C K E D _ C O N V E R S I O N             --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
-- This specification is derived from the Ada Reference Manual for use with --
-- GNAT.  In accordance with the copyright of that document, you can freely --
-- copy and modify this specification,  provided that if you redistribute a --
-- modified version,  any changes that you have made are clearly indicated. --
--                                                                          --
-- Modifications:                                                           --
--    Changed pragmas to aspects                                            --
--    Added GNAT specific aspects                                           --
--                                                                          --
------------------------------------------------------------------------------

generic
   type Source (<>) is limited private;
   type Target (<>) is limited private;
function Ada.Unchecked_Conversion (S : Source) return Target
   with  Import,
         Convention => Intrinsic,
         Pure,
         Pure_Function,
         Inline_Always,
         No_Elaboration_Code_All;
