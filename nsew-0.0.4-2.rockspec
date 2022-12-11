rockspec_format = "3.0"
package = "nsew"
version = "0.0.4-2"
source = {
   url = "git+https://github.com/Ismoh/Noita-Synchronise-Expansive-Worlds.git",
   dir = "nsew",
   tag = "0.0.4"
}
description = {
   summary = "# Noita Synchronise Expansive Worlds",
   detailed = "# Noita Synchronise Expansive Worlds",
   homepage = "https://github.com/Ismoh/Noita-Synchronise-Expansive-Worlds",
   license = "MIT"
}
dependencies = {
   "lua ~> 5.1"
}
build = {
   type = "builtin",
   modules = {
      ["bin.LuaJIT-2.0.4.jit.bc"] = "bin/LuaJIT-2.0.4/jit/bc.lua",
      ["bin.LuaJIT-2.0.4.jit.bcsave"] = "bin/LuaJIT-2.0.4/jit/bcsave.lua",
      ["bin.LuaJIT-2.0.4.jit.dis_arm"] = "bin/LuaJIT-2.0.4/jit/dis_arm.lua",
      ["bin.LuaJIT-2.0.4.jit.dis_mips"] = "bin/LuaJIT-2.0.4/jit/dis_mips.lua",
      ["bin.LuaJIT-2.0.4.jit.dis_mipsel"] = "bin/LuaJIT-2.0.4/jit/dis_mipsel.lua",
      ["bin.LuaJIT-2.0.4.jit.dis_ppc"] = "bin/LuaJIT-2.0.4/jit/dis_ppc.lua",
      ["bin.LuaJIT-2.0.4.jit.dis_x64"] = "bin/LuaJIT-2.0.4/jit/dis_x64.lua",
      ["bin.LuaJIT-2.0.4.jit.dis_x86"] = "bin/LuaJIT-2.0.4/jit/dis_x86.lua",
      ["bin.LuaJIT-2.0.4.jit.dump"] = "bin/LuaJIT-2.0.4/jit/dump.lua",
      ["bin.LuaJIT-2.0.4.jit.v"] = "bin/LuaJIT-2.0.4/jit/v.lua",
      ["bin.LuaJIT-2.0.4.jit.vmdef"] = "bin/LuaJIT-2.0.4/jit/vmdef.lua",
      ["examples.client.nsew_client.init"] = "examples/client/nsew_client/init.lua",
      ["examples.rainbow_cursor.rainbow_cursor.init"] = "examples/rainbow_cursor/rainbow_cursor/init.lua",
      ["nsew.game_patch"] = "nsew/game_patch.lua",
      ["nsew.load"] = "nsew/load.lua",
      ["nsew.native_dll"] = "nsew/native_dll.lua",
      ["nsew.rect"] = "nsew/rect.lua",
      ["nsew.test.test_world_ffi"] = "nsew/test/test_world_ffi.lua",
      ["nsew.world"] = "nsew/world.lua",
      ["nsew.world_ffi"] = "nsew/world_ffi.lua",
      ["test.load_luasocket"] = "test/load_luasocket.lua"
   },
   install = {
      bin = {
         "bin/LuaJIT-2.0.4",
         "bin/luarocks-3.9.1-windows-32",
         "bin/README.md"
      }
   },
   build = {
      type = "cmake",
   },
   test = {
      type = "command",
      script = "test/load_luasocket.lua"
   }
}
