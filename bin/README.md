# Install luarocks on Windows with Lua 5.1 and LuaJIT-2.0.4 as standalone Installation

## Install and init luarocks

1. Open `cmd.exe` as *administrator*
2. Change directory to `Noita-Synchronise-Expansive-Worlds\` (root repo level), like `cd fullPathTo\Noita-Synchronise-Expansive-Worlds` on your local system.
3. Run the following command as *administrator* in `cmd.exe`:
   ```cmd
   REM // cd fullPathTo\Noita-Synchronise-Expansive-Worlds
   set INIT_PATH=%CD%
   
   REM // resolve absolute path
   set REL_PATH=bin\luarocks-3.9.1-windows-32
   set ABS_PATH=
   rem // Save current directory and change to target directory
   pushd %REL_PATH%
   rem // Save value of CD variable (current directory)
   set ABS_PATH=%CD%
   rem // Restore original directory
   popd   
   echo Relative path: %REL_PATH%
   echo Maps to path: %ABS_PATH%
   
   REM // init luarocks
   %ABS_PATH%\luarocks --lua-version="5.1" init nsew --output="%INIT_PATH%" --homepage="https://github.com/Ismoh/Noita-Synchronise-Expansive-Worlds" --lua-versions="5.1" --license="MIT"
   ```
   [source for above](https://stackoverflow.com/questions/1645843/resolve-absolute-path-from-relative-path-and-or-file-name)
4. Result should look like this:
   ```cmd
   Initializing project 'nsew' for Lua 5.1 ...
   -------------------------------------------
   
   Checking your Lua installation ...
   
   Wrote template at C:\Users\Ismoh-PC\IdeaProjects\Noita-Synchronise-Expansive-Worlds -- you should now edit and finish it.
   
   Adding entries to .gitignore ...
   Preparing ./.luarocks/ ...
   Wrote .luarocks/config-5.1.lua
   Preparing ./lua_modules/ ...
   Preparing ./luarocks.bat ...
   Preparing ./lua.bat for version 5.1...
   ```
5. If you run `luarocks help` in `Noita-Synchronise-Expansive-Worlds\` directory, it should work now.

## Make use of LuaJIT-2.0.4
1. Check LuaJITs doc for compiling it on [Windows](https://luajit.org/install.html#windows).
2. After compiling LuaJIT, copy the following files into destination directory: ([Double check here on 3.](https://gist.github.com/Egor-Skriptunoff/cb952f7eaf39b7b1bf739b818ece87cd))
    - `luajit.exe` and `lua51.dll` (`lua51.lib`?) into `bin\LuaJIT-2.0.4\bin`
    - Install jit.* modules by copying `*\LuaJIT-2.0.4\src\jit` into `bin\LuaJIT-2.0.4\jit`
    - Add includes by copying `lauxlib.h`, `lua.h`, `lua.hpp`, `luaconf.h`, `lualib.h` from `*\LuaJIT-2.0.4\src` into `bin\LuaJIT-2.0.4\include`
3. Change `\.luarocks\config-5.1.lua` like so, but use your local absolute path to `bin\LuaJIT-2.0.4\`:
   ```lua
   lua_interpreter = "luajit.exe"
   variables = {
    LUA_BINDIR = "yourAbsolutePathTo\\bin\\LuaJIT-2.0.4\\bin", -- LUA_BINDIR = "C:\\msys64\\mingw32\\bin",
    LUA_DIR = "yourAbsolutePathTo\\bin\\LuaJIT-2.0.4", -- LUA_DIR = "C:\\msys64\\mingw32",
    LUA_INCDIR = "yourAbsolutePathTo\\bin\\LuaJIT-2.0.4\\include" -- LUA_INCDIR = "C:\\msys64\\mingw32/include/lua5.1"
   }
   ```
4. Run `luarocks help` in `\ ` directory again. Done!

## Create a rockspec
Do not run this, if there already is a *.rockspec file!
```cmd
luarocks write_rockspec --output="nsew-0.0.4-1.rockspec" --license="MIT" --lua-versions="5.1" --rockspec-format="3.0"
```

## Run unit test
```cmd
luarocks test
```
[docs](https://github.com/luarocks/luarocks/wiki/test#test-types)

## Check for updates on dependencies
Run `luarocks list` in `\ ` directory.

## Install all dependencies defined in nsew-*.rockspec
Run `luarocks install --only-deps nsew-*.rockspec`. Replace `*` with the version number of the rockspec.

### Install dependencies related to build process
Follow install steps on [vcpkg](https://vcpkg.io/en/getting-started.html) and install it as a git submodule.
Run `git submodule add https://github.com/Microsoft/vcpkg.git` to add vckpg as a submodule.
After that run `.\vcpkg\bootstrap-vcpkg.bat` to install vcpkg.

## LuaRocks build
Change default cmake generator with the following config changes in `.luarocks\config-5.1.lua`:
```lua
lua_interpreter = "luajit.exe"
cmake_generator = "Ninja"
variables = {
   -- your local absolute paths
}
```
[related-issue-1](https://github.com/luarocks/luarocks/issues/509#issuecomment-800368236)
[related-issue-2](https://github.com/luarocks/luarocks/issues/1476#issuecomment-1346771079)

Version mismatch? There was the following error:
```cmd
CMake Error at CMakeLists.txt:1 (cmake_minimum_required):
CMake 3.22 or higher is required.  You are running version 3.21.4
```
Update your cmake version by updating MSYS2: [How-to!](https://www.msys2.org/docs/updating/)
Read carefully!