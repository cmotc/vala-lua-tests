This is how to use Delegates to call Instance functions in Vala Classes
=======================================================================

So after much experimentation, I've found a way to declare a Lua callback
function as the delegate type within the same class where you're trying to
access the code from Lua. I think. There's one thing that's still tripping me up
but I'll just continue investigating. For now, I know for sure that this will
allow you to call an instance-level Vala function that is a member of a class
from Lua.

Of course, the essential feature of this tutorial is an instance-level Lua
virtual machine and an instance-level vala function, registered within the
virtual machine, from within the same class where it's declared. So first we
declare a class and a LuaVM without the static qualifier.

        class LuaTest{
                LuaVM vm = new LuaVM ();

Now we create the function we'll be registering with our Lua VM. This has to
otherwise work as a Lua callback function would if it were static, so it has to
return an int and take a LuaVM as an argument. To work around this with a LuaVM
hosted in the same class, I used a default value for the LuaVM which points to
the instance level LuaVM.

                Lua.CallbackFunc my_func_delegate;
                public int my_func (LuaVM vm = this.VM) {
                    stdout.printf ("Vala Code From Lua Code! (%f)\n", this.VM.to_number (1));
                    return 1;
                }

This time, after you've instantiated your LuaVM and opened the libraries, you'll
need to turn my_func into a Lua.CallbackFunc and assign it to the delegate you
just created.

                public LuaTest(){
                        VM.open_libs();
                        my_func_delegate = (Lua.CallbackFunc) my_func;

Finally, register the function with the Lua virtual machine.

                        VM.register ("my_func", my_func_delegate);

Your main function hardly changes at all.

        static int main (string[] args) {
                LuaTest s = new LuaTest();
                string code = """
                    print "Lua Code From Vala Code!"
                    my_func(33)
                """;
                s.LuaDoString(code);
                return 0;
        }

###Compile Line

        valac --save-temps --pkg lua -X -llua5.1 callafunction.vala -o callafunction

###Full Example Code

        using Lua;
        namespace Luatest{
                class LuaTest{
                        LuaVM VM = new LuaVM ();
                        Lua.CallbackFunc my_func_delegate;
                        public int my_func (LuaVM vm = this.VM) {
                            stdout.printf ("Vala Code From Lua Code! (%f)\n", this.VM.to_number (1));
                            return 1;
                        }
                        public LuaTest(){
                                VM.open_libs();
                                my_func_delegate = (CallbackFunc) my_func;
                                VM.register ("my_func", my_func_delegate);
                        }
                        public void LuaDoString(string code){
                                VM.do_string (code);
                        }
                }

                static int main (string[] args) {
                        LuaTest s = new LuaTest();
                        string code = """
                            print "Lua Code From Vala Code!"
                            my_func(33)
                        """;
                        s.LuaDoString(code);
                        return 0;
                }
        }

