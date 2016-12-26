How **Not** to use Vala Functions in a Class from Lua
=====================================================

This example is not going to compile, because instance functions in classes are
different from functions at global scope. It's here so people, including me,
can study the error and figure out how to call Vala classes from Lua scripts.

In the next example this is corrected by the use of static instead of instance
members.

###Compile Line

        valac --save-temps --pkg lua -X -llua5.1 luatest.vala -o luatest

###Full Example Code

        using Lua;
        namespace LuaTest{
                class LuaTest{
                        int my_func (LuaVM vm) {
                            stdout.printf ("Vala Code From Lua Code! (%f)\n", vm.to_number (1));
                            return 1;
                        }

                        static int main (string[] args) {

                            string code = """
                                    print "Lua Code From Vala Code!"
                                    my_func(33)
                                """;

                            var vm = new LuaVM ();
                            vm.open_libs ();
                            vm.register ("my_func", my_func);
                            vm.do_string (code);

                            return 0;
                        }
                }
        }
