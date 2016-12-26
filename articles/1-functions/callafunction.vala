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
