#! /bin/sh
valac --save-temps --pkg lua -X -llua5.1 luatest.vala -o luatest
