This is a straightforward copy of the Lua example from the Vala web site
========================================================================


First, make sure you include the Lua namespace in your Vala program.

        using Lua;

Next, create the Vala functions that you want to bind to and call from the Lua
script. They need to be of the form:

        [return type] function_name(LuaVM vm)

Now create two versions of the same function. In practice, you don't actually
need to create both versions, but this example is pretty short and calling both
versions won't make it longer.

        static int my_func_static (LuaVM vm) {
            stdout.printf ("Static Vala Code From Lua Code! (%f)\n", vm.to_number (1));
            return 1;
        }

        int my_func (LuaVM vm) {
            stdout.printf ("Vala Code From Lua Code! (%f)\n", vm.to_number (1));
            return 1;
        }

Now move on to things in the main function. You should already know how to set
up your main function:

        static int main (string[] args) {

The next part of the main function is a string storing the Lua code. Use triple-
quotes to write your script as a string in your vala code for now(We'll load the
code from a file in the next tutorial). This lua script calls both the functions
we created earlier.

            string code = """
                print "Lua Code From Vala Code!"
                my_func(33)
                my_func_static(44)
            """;

Next you need to instantiate a Lua virtual machine. You'll probably do this the
same way most of the times that you use Lua from Vala and Vala from Lua.

            var vm = new LuaVM ();
            vm.open_libs ();

Now, another important part, this is where you register the functions that you
will be calling from Lua with the Lua virtual machine in your Vala program.

            vm.register ("my_func_static", my_func_static);
            vm.register ("my_func", my_func);

Finally, execute the Lua code in the variable from earlier in the virtual
machine by calling the .do\_string(string lua\_script) function.

            vm.do_string (code);

            return 0;
        }

And that's about as detailed a beginning example I can think up.

###Compile Line

        valac --save-temps --pkg lua -X -llua5.1 luatest.vala -o luatest

[Original Source](https://wiki.gnome.org/Projects/Vala/LuaSample)

###Full Example Code

        using Lua;

        static int my_func_static (LuaVM vm) {
            stdout.printf ("Static Vala Code From Lua Code! (%f)\n", vm.to_number (1));
            return 1;
        }

        int my_func (LuaVM vm) {
            stdout.printf ("Vala Code From Lua Code! (%f)\n", vm.to_number (1));
            return 1;
        }

        static int main (string[] args) {

            string code = """
                    print "Lua Code From Vala Code!"
                    my_func(33)
                    my_func_static(44)
                """;

            var vm = new LuaVM ();
            vm.open_libs ();
            vm.register ("my_func_static", my_func_static);
            vm.register ("my_func", my_func);
            vm.do_string (code);

            return 0;
        }
