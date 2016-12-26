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
