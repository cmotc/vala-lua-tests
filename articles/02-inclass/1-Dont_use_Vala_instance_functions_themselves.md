How **Not** to use Vala Functions in a Class from Lua
=====================================================

This example is not going to compile, because instance functions in classes are
different from functions at global scope. It's here so people, including me,
can study the error and figure out how to call Vala classes from Lua scripts.

In the next example this is corrected by the use of static instead of instance
members.
