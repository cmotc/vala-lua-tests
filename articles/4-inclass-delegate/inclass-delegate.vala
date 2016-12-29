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
