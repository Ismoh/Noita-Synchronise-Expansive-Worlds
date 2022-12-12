rockspec_format = "3.0"
package = "nsew"
version = "dev-3"
source = {
   url = "git+https://github.com/Ismoh/Noita-Synchronise-Expansive-Worlds.git",
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
   type = "command",
   build_command = "./vcpkg install boost-system:x86-windows-static && " ..
           "./vcpkg install boost-asio:x86-windows-static && " ..
           "mkdir build && " ..
           "cmake -S . -B build -G Ninja ^ " ..
           "-DCMAKE_TOOLCHAIN_FILE=./vcpkg/scripts/buildsystems/vcpkg.cmake ^ " ..
           "-DVCPKG_TARGET_TRIPLET=x86-windows-static ^ " ..
           "-DCMAKE_CXX_FLAGS=\"/D_WIN32_WINNT=0x0601 /DWINVER=0x0601 /DWIN32 /D_WINDOWS /EHsc /MD\" ^ " ..
           "-DNSEW_EXTERNAL_MAP=OFF ^ " ..
           "-DNSEW_PREBUILT_DOCS_DIR=./doc ^ " ..
           "-DCMAKE_BUILD_TYPE=Release",
    install_command = "cmake --build build && " ..
           "cd build && " ..
           "ctest --output-on-failure"
           --.. " && cpack"
   ,
}
test = {
   type = "command",
   script = "test/load_luasocket.lua"
}