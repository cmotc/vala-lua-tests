using Lua;

class LuaTest{
        public delegate int my_func(LuaVM vm);
        public int my_func_test (LuaVM vm) {
            stdout.printf ("Vala Code From Lua Code! (%f)\n", vm.to_number (1));
            return 1;
        }
        public LuaTest(){
                this.my_func = this.my_func_test;
        }
}

static int main (string[] args) {
        LuaTest s = new LuaTest();
        string code = """
            print "Lua Code From Vala Code!"
            my_func(33)
        """;

        var vm = new LuaVM ();
        vm.open_libs ();
        vm.register ("my_func", s.my_func);
        vm.do_string (code);

        return 0;
}
