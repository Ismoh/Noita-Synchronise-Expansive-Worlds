rockspec_format = "3.0"
package = "nsew"
version = "0.0.4-2"
source = {
   url = "git+https://github.com/Ismoh/Noita-Synchronise-Expansive-Worlds.git",
   tag = "0.0.4"
}
description = {
   summary = "# Noita Synchronise Expansive Worlds",
   detailed = "# Noita Synchronise Expansive Worlds",
   homepage = "https://github.com/Ismoh/Noita-Synchronise-Expansive-Worlds",
   license = "MIT"
}
dependencies = {
   "lua == 5.1"
}
build_dependencies = {
   "ldoc == 1.4.6"
}
build = {
   type = "cmake",
   variables = {
      CMAKE = "cmake -S . -B build -G Ninja ^",
      CMAKE_TOOLCHAIN_FILE = "C:/vcpkg/scripts/buildsystems/vcpkg.cmake",
      VCPKG_TARGET_TRIPLET = "x86-windows-static",
      CMAKE_CXX_FLAGS = "\"/D_WIN32_WINNT=0x0601 /DWINVER=0x0601 /DWIN32 /D_WINDOWS /EHsc /MD\"",
      NSEW_EXTERNAL_MAP = "OFF",
      LUAJIT_COMPILED = "D:/a/Noita-Synchronise-Expansive-Worlds/Noita-Synchronise-Expansive-Worlds/LuaJIT/LuaJIT-2.0.4",
      NSEW_PREBUILT_DOCS_DIR = "D:/a/Noita-Synchronise-Expansive-Worlds/Noita-Synchronise-Expansive-Worlds/doc",
      CMAKE_BUILD_TYPE = "Release"
   }
}
test = {
   type = "command",
   script = "test/load_luasocket.lua"
}