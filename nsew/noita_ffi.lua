--- Noita world functionality exposed.
-- @module nsew.noita_ffi

local noita_ffi = {}

local ffi = require("ffi")

ffi.cdef([[

typedef void* __thiscall placeholder_memfn(void*);

struct Position {
    int x;
    int y;
};

struct Colour {
    uint8_t r;
    uint8_t g;
    uint8_t b;
    uint8_t a;
};

struct AABB {
    struct Position top_left;
    struct Position bottom_right;
};

enum CellType {
    CELL_TYPE_NONE = 0,
    CELL_TYPE_LIQUID = 1,
    CELL_TYPE_GAS = 2,
    CELL_TYPE_SOLID = 3,
    CELL_TYPE_FIRE = 4,
};

struct Cell_vtable {
    void (__thiscall *destroy)(struct Cell*, char dealloc);
    enum CellType (__thiscall *get_cell_type)(struct Cell*);
    void* field2_0x8;
    void* field3_0xc;
    void* field4_0x10;
    struct Colour (__thiscall *get_colour)(struct Cell*);
    void* field6_0x18;
    void (__thiscall *set_colour)(struct Cell*, struct Colour);
    void* field8_0x20;
    void* field9_0x24;
    void* field10_0x28;
    void* field11_0x2c;
    void* (__thiscall *get_material)(void *);
    void* field13_0x34;
    void* field14_0x38;
    void* field15_0x3c;
    void* field16_0x40;
    void* field17_0x44;
    void* field18_0x48;
    void* field19_0x4c;
    struct Position * (__thiscall *get_position)(void *, struct Position *);
    void* field21_0x54;
    void* field22_0x58;
    void* field23_0x5c;
    void* field24_0x60;
    void* field25_0x64;
    void* field26_0x68;
    void* field27_0x6c;
    void* field28_0x70;
    void* field29_0x74;
    void* field30_0x78;
    void* field31_0x7c;
    void* field32_0x80;
    void* field33_0x84;
    void* field34_0x88;
    void* field35_0x8c;
    void* field36_0x90;
    void* field37_0x94;
    void* field38_0x98;
    void (__thiscall *remove)(struct Cell*);
    void* field40_0xa0;
};

struct Cell {
    struct Cell_vtable* vtable;
};

struct CLiquidCell {
    struct Cell cell;

    int hp;
    int unknown[3];
    uintptr_t material_ptr;
    int x;
    int y;
    int unknown2[4];
    struct Colour colour;
    unsigned not_colour;
};

typedef struct Cell (*cell_array)[0x40000];

struct ChunkMap {
    int unknown[2];
    cell_array* (*cells)[0x40000];
    int unknown2[8];
};

struct GridWorld_vtable {
    placeholder_memfn* unknown[3];
    struct ChunkMap* (__thiscall *get_chunk_map)(struct GridWorld* this);
    placeholder_memfn* unknown2[30];
};

struct GridWorld {
    struct GridWorld_vtable* vtable;
    int unknown[318];
    int world_update_count;
    struct ChunkMap chunk_map;
    int unknown2[41];
    struct GridWorldThreadImpl* mThreadImpl;
};

struct GridWorldThreaded_vtable;

struct GridWorldThreaded {
    struct GridWorldThreaded_vtable* vtable;
    int unknown[287];
    struct AABB update_region;
};

struct vec_pGridWorldThreaded {
    struct GridWorldThreaded** begin;
    struct GridWorldThreaded** end_;
    struct GridWorldThreaded** capacity_end;
};

struct WorldUpdateParams {
    struct AABB update_region;
    int unknown;
    struct GridWorldThreaded* grid_world_threaded;
};

struct vec_WorldUpdateParams {
    struct WorldUpdateParams* begin;
    struct WorldUpdateParams* end_;
    struct WorldUpdateParams* capacity_end;
};

struct GridWorldThreadImpl {
    int chunk_update_count;
    struct vec_pGridWorldThreaded updated_grid_worlds;

    int world_update_params_count;
    struct vec_WorldUpdateParams world_update_params;

    int grid_with_area_count;
    struct vec_pGridWorldThreaded with_area_grid_worlds;

    int another_count;
    int another_vec[3];

    int some_kind_of_ptr;
    int some_kind_of_counter;

    int last_vec[3];
};

typedef struct Cell** __thiscall get_pixel_f(struct ChunkMap*, int x, int y);
typedef bool __thiscall chunk_loaded_f(struct ChunkMap*, int x, int y);

typedef void __thiscall remove_cell_f(struct GridWorld*, void* cell, int x, int y, bool);
typedef struct Cell* __thiscall construct_cell_f(struct GridWorld*, int x, int y, void* material_ptr, void* memory);

]])

--- Access a pixel in the world.
-- @function get_pixel
-- @param chunk_map chunk map
-- @tparam int x coordinate
-- @tparam int y coordinate
-- @return Pointer to a pointer to a cell. You can write a cell created from
-- @{construct_cell} to this pointer to add a cell into the world. If there's
-- already a cell at this position, make sure to call @{remove_cell} first.
noita_ffi.get_pixel = ffi.cast("get_pixel_f*", 0x07bf560)

--- Remove a cell from the world.
-- @function remove_cell
-- @param grid_world
-- @param cell pointer to the cell you want to remove
-- @tparam int x coordinate
-- @tparam int y coordinate
-- @tparam bool noidea no idea
noita_ffi.remove_cell = ffi.cast("remove_cell_f*", 0x6a83c0)

--- Create a new cell.
-- @function construct_cell
-- @param grid_world
-- @tparam int x coordinate
-- @tparam int y coordinate
-- @param material_ptr pointer to material
-- @param pointer to memory to use. nullptr will make this function allocate its
-- own memory
noita_ffi.construct_cell = ffi.cast("construct_cell_f*", 0x691b70)

--- Check if a chunk is loaded.
-- @function chunk_loaded
-- @param chunk_map
-- @tparam int x world coordinate
-- @tparam int y world coordinate
-- @usage
-- if noita_ffi.chunk_loaded(chunk_map, x, y) then
--   local cell = noita_ffi.get_pixel(chunk_map, x, y)
--   -- ...
noita_ffi.chunk_loaded = ffi.cast("chunk_loaded_f*", 0x7bf440)

noita_ffi.Position = ffi.typeof("struct Position")
noita_ffi.Colour = ffi.typeof("struct Colour")
noita_ffi.AABB = ffi.typeof("struct AABB")
noita_ffi.CellType = ffi.typeof("enum CellType")
noita_ffi.Cell = ffi.typeof("struct Cell")
noita_ffi.CLiquidCell = ffi.typeof("struct CLiquidCell")
noita_ffi.ChunkMap = ffi.typeof("struct ChunkMap")
noita_ffi.GridWorld = ffi.typeof("struct GridWorld")
noita_ffi.GridWorldThreaded = ffi.typeof("struct GridWorldThreaded")
noita_ffi.WorldUpdateParams = ffi.typeof("struct WorldUpdateParams")
noita_ffi.GridWorldThreadImpl = ffi.typeof("struct GridWorldThreadImpl")

--- Get the grid world.
-- @return pointer to the grid world
function noita_ffi.get_grid_world()
    local game_global = ffi.cast("void**", 0x100d558)[0]
    local world_data = ffi.cast("void**", ffi.cast("char*", game_global) + 0xc)[0]
    local grid_world = ffi.cast("struct GridWorld**", ffi.cast("char*", world_data) + 0x44)[0]
    return grid_world
end

local material_props_size = 0x28c

--- Turn a standard material id into a material pointer.
-- @param id material id that is used in the standard Noita functions
-- @return pointer to internal material data (aka cell data).
-- @usage local gold_ptr = noita_ffi.get_material_ptr(CellFactory_GetType("gold"))
function noita_ffi.get_material_ptr(id)
    local game_global = ffi.cast("char**", 0x100d558)[0]
    local cell_factory = ffi.cast('char**', (game_global + 0x18))[0]
    local begin = ffi.cast('char**', cell_factory + 0x18)[0]
    local ptr = begin + material_props_size * id
    return ptr
end

--- Turn a material pointer into a standard material id.
-- @param ptr pointer to a material (aka cell data)
-- @treturn int material id that is accepted by standard Noita functions such as
-- `CellFactory_GetUIName` and `ConvertMaterialOnAreaInstantly`.
-- @usage local mat_id = noita_ffi.get_material_id(cell.vtable.get_material(cell))
-- @see get_material_ptr
function noita_ffi.get_material_id(ptr)
    local game_global = ffi.cast("char**", 0x100d558)[0]
    local cell_factory = ffi.cast('char**', (game_global + 0x18))[0]
    local begin = ffi.cast('char**', cell_factory + 0x18)[0]
    local offset = ffi.cast('char*', ptr) - begin
    return offset / material_props_size
end

return noita_ffi
