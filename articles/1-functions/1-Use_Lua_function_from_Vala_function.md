This is an example of how to call functions in lua scripts from Vala programs
=============================================================================

In this example we're going to learn the simplest way to load external lua code
from a file and how to call a function from that lua code within Vala.

First, let's create a file named code.lua containing a function.

        function test_code()
            print "Lua Code From Vala Code!"
            my_func(33)
        end

In this example we'll only create one version of the function to register with
the Lua virtual machine.

        int my_func (LuaVM vm) {
            stdout.printf ("Vala Code From Lua Code! (%f)\n", vm.to_number (1));
            return 1;
        }

Now, create the main function like you [did before](0example.html),
instantiating the Virtual Machine and preparing the libraries, register your
function, and then...

        static int main (string[] args) {
            var vm = new LuaVM ();
            vm.open_libs ();
            vm.register ("my_func", my_func);

Load the file containing the Lua code into the virtual machine using the
.do\_file(string path\_to\_code) function. Vala will use the relative path if
you use a relative path, or an absolute path if you use an absolute path.

            vm.do_file("code.lua");

Now finally, use the .do\_string(string lua\_script) to call the function you
just loaded.

            vm.do_string("""test_code()""");
            return 0;
        }

And that's how you load a script containing functions and call a function in a
Lua script from Vala.

###Compile Line

valac --save-temps --pkg lua -X -llua5.1 callafunction.vala -o callafunction

###Full Example Code

**Lua Script(code.lua)**

        function test_code()
            print "Lua Code From Vala Code!"
            my_func(33)
        end

**Vala Code(callafunction.vala)**

        using Lua;

        int my_func (LuaVM vm) {
            stdout.printf ("Vala Code From Lua Code! (%f)\n", vm.to_number (1));
            return 1;
        }

        static int main (string[] args) {
            var vm = new LuaVM ();
            vm.open_libs ();
            vm.register ("my_func", my_func);
            vm.do_file("code.lua");
            vm.do_string("""test_code()""");
            return 0;
        }
