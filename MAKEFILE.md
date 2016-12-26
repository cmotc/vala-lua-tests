Notes about passing arguments to valac
======================================

Vala libraries come as .vapi files, and you can load them with the --pkg option.

        Vala .vapi package
           --pkg lua \

After vala is turned into C, the C is then compiled for the target platform.
This means you have to make sure you tell ld to use lua to development.

        Pass this option to the C Compiler
        -X -llua5.1 \

For some reason this option isn't specified in all the tutorials out there,
people must be working with some different defaults. Not sure. But on my system,
this second part is definitely necessary.

Also, /usr/lib/pkgconfig/lua.pc needs to be a symlink to
/usr/lib/x86_64-linux-gnu/pkgconfig/lua5.1.pc. It needs to have the following
permissions

        lrwxrwxrwx root root /usr/lib/pkgconfig/lua.pc /usr/lib/x86_64-linux-gnu/pkgconfig/lua5.1.pc

this should be as simple as running:

        sudo ln -s /usr/lib/x86_64-linux-gnu/pkgconfig/lua5.1.pc /usr/lib/pkgconfig/lua.pc
