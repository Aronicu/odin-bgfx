package bgfx

// TODO: [04-16-2025] WASM?
when ODIN_OS == .Windows {
	@(export) foreign import lib "windows/..." // TODO: Add Windows static and dyn lib path
} else when ODIN_OS == .Linux  {
	foreign import lib {
        // TODO: Linux debug 
        "system:stdc++",
        "libs/linux/libbgfxRelease.a",
        "libs/linux/libbxRelease.a",
        "libs/linux/libbimgRelease.a",
    }
} else when ODIN_OS == .Darwin {
	@(export) foreign import lib "macos/..." // TODO: Add MacOS static and dyn lib path
} else {
	@(export) foreign import lib "system:bgfx"
}

Encoder :: distinct rawptr
Arg_List :: distinct rawptr

Fatal :: enum {
    Debug_Check,
    Invalid_Shader,
    Unable_To_Initialize,
    Unable_To_Create_Texture,
    Device_Lost,
    Count,
}

Renderer_Type :: enum {
    Noop,
    AGC,
    Direct3D11,
    Direct3D12,
    GNM,
    Metal,
    NVN,
    OpenGLES, // OpenGL ES 2.0+
    OpenGL,   // OpenGL 2.1+
    Vulkan,
    Count,
}

Access :: enum {
    Read,
    Write,
    ReadWrite,
    Count,
}

Attrib :: enum {
    Position,
    Normal,
    Tangent,
    Bitangent,
    Color0,
    Color1,
    Color2,
    Color3,
    Indices,
    Weight,
    Texcoord0,
    Texcoord1,
    Texcoord2,
    Texcoord3,
    Texcoord4,
    Texcoord5,
    Texcoord6,
    Texcoord7,
    Count,
}

Attrib_Type :: enum {
    Uint8,
    Uint10,
    Int16,
    Half,
    Float,
    Count,
}

Texture_Format :: enum {
    BC1,
    BC2,
    BC3,
    BC4,
    BC5,
    BC6H,
    BC7,
    ETC1,
    ETC2,
    ETC2A,
    ETC2A1,
    PTC12,
    PTC14,
    PTC12A,
    PTC14A,
    PTC22,
    PTC24,
    ATC, 
    ATCE,
    ATCI,
    ASTC4X4,
    ASTC5X4,
    ASTC5X5,
    ASTC6X5,
    ASTC6X6,
    ASTC8X5,
    ASTC8X6,
    ASTC8X8,
    ASTC10X5,
    ASTC10X6,
    ASTC10X8,
    ASTC10X10,
    ASTC12X10,
    ASTC12X12,
    UNKNOWN,
    R1,
    A8,
    R8, 
    R8I,
    R8U,
    R8S,
    R16,
    R16I,
    R16U,
    R16F,
    R16S,
    R32I,
    R32U,
    R32F,
    RG8,
    RG8I,
    RG8U,
    RG8S,
    RG16,
    RG16I,
    RG16U,
    RG16F,
    RG16S,
    RG32I,
    RG32U,
    RG32F,
    RGB8,
    RGB8I,
    RGB8U,
    RGB8S,
    RGB9E5F,
    BGRA8,
    RGBA8,
    RGBA8I,
    RGBA8U,
    RGBA8S,
    RGBA16,
    RGBA16I,
    RGBA16U,
    RGBA16F,
    RGBA16S,
    RGBA32I,
    RGBA32U,
    RGBA32F,
    B5G6R5,
    R5G6B5,
    BGRA4,
    RGBA4,
    BGR5A1,
    RGB5A1,
    RGB10A2,
    RG11B10F,
    UNKNOWNDEPTH,
    D16,
    D24,
    D24S8,
    D32,
    D16F,
    D24F,
    D32F,
    D0S8,
    Count,
}

Uniform_Type :: enum {
    Sampler, // Sampler
    End,     // Reserved, do not use
    Vec4,    // 4 floats vector
    Mat3,    // 3x3 matrix
    Mat4,    // 4x4 matrix
    Count,
}

Backbuffer_Ratio :: enum {
    Equal,     // Equal to backbuffer
    Half,      // One half size of backbuffer
    Quarter,   // One quarter size of backbuffer
    Eighth,    // One eighth size of backbuffer
    Sixteenth, // One sixteenth size of backbuffer
    Double,    // Double size of backbuffer
    Count,
}

Occlusion_Query_Result :: enum {
    Invisible,
    Visible,
    No_Result,
    Count,
}

Topology :: enum {
    Tri_List,                   
    Tri_Strip,                 
    Line_List,                
    Line_Strip,              
    Point_List,             
    Count,
}

Topology_Convert :: enum {
    Tri_List_Flip_Winding, /** ( 0) Flip winding order of triangle list. */
    Tri_Strip_Flip_Winding, /** ( 1) Flip winding order of triangle strip. */
    Tri_List_To_Line_List, /** ( 2) Convert triangle list to line list. */
    Tri_Strip_To_Tri_List, /** ( 3) Convert triangle strip to triangle list. */
    Line_Strip_To_Line_List, /** ( 4) Convert line strip to line list. */
    Count,
}

Topology_Sort :: enum {
    Direction_Front_To_Back_Min,
    Direction_Front_To_Back_Avg,
    Direction_Front_To_Back_Max,
    Direction_Back_To_Front_Min,
    Direction_Back_To_Front_Avg,
    Direction_Back_To_Front_Max,
    Distance_Front_To_Back_Min, 
    Distance_Front_To_Back_Avg, 
    Distance_Front_To_Back_Max, 
    Distance_Back_To_Front_Min, 
    Distance_Back_To_Front_Avg, 
    Distance_Back_To_Front_Max, 
    Count,
}

View_Mode :: enum {
    Default,
    Sequential,
    Depth_Ascending,
    Depth_Descending,
    Count,
}

Native_Window_Handle_Type :: enum {
    Default,
    Wayland,
    Count,
}

Render_Frame :: enum {
    No_Context,
    Render,
    Timeout,
    Exiting,
    Count,
}

View_Id :: u16

Dynamic_Index_Buffer_Handle :: struct { idx: u16, }
Dynamic_Vertex_Buffer_Handle :: struct { idx: u16, }
Frame_Buffer_Handle :: struct { idx: u16, }
Index_Buffer_Handle :: struct { idx: u16, }
Indirect_Buffer_Handle :: struct { idx: u16, }
Occlusion_Query_Handle :: struct { idx: u16, }
Program_Handle :: struct { idx: u16, }
Shader_Handle :: struct { idx: u16, }
Texture_Handle :: struct { idx: u16, }
Uniform_Handle :: struct { idx: u16, }
Vertex_Buffer_Handle :: struct { idx: u16, }
Vertex_Layout_Handle :: struct { idx: u16, }

Caps_GPU :: struct {
    vendor_id: u16,
    device_id: u16,
}

Caps_Limits :: struct {
    max_draw_calls             : u32, // maximum number of draw calls.            
    max_blits                  : u32, // maximum number of blit calls.            
    max_texture_size           : u32, // maximum texture size.                    
    max_texture_layers         : u32, // maximum texture layers.                  
    max_views                  : u32, // maximum number of views.                 
    max_frame_buffers          : u32, // maximum number of frame buffer handles.  
    max_fb_attachments         : u32, // maximum number of frame buffer attachments. 
    max_programs               : u32, // maximum number of program handles.       
    max_shaders                : u32, // maximum number of shader handles.        
    max_textures               : u32, // maximum number of texture handles.       
    max_texture_samplers       : u32, // maximum number of texture samplers.      
    max_compute_bindings       : u32, // maximum number of compute bindings.      
    max_vertex_layouts         : u32, // maximum number of vertex format layouts. 
    max_vertex_streams         : u32, // maximum number of vertex streams.        
    max_index_buffers          : u32, // maximum number of index buffer handles.  
    max_vertex_buffers         : u32, // maximum number of vertex buffer handles. 
    max_dynamic_index_buffers  : u32, // maximum number of dynamic index buffer handles. 
    max_dynamic_vertex_buffers : u32, // maximum number of dynamic vertex buffer handles. 
    max_uniforms               : u32, // maximum number of uniform handles.       
    max_occlusion_queries      : u32, // maximum number of occlusion query handles. 
    max_encoders               : u32, // maximum number of encoder threads.       
    min_resource_cb_size       : u32, // minimum resource command buffer size.    
    transient_vb_size          : u32, // maximum transient vertex buffer size.    
    transient_ib_size          : u32, // maximum transient index buffer size.     
}

Caps :: struct {
    renderer_type: Renderer_Type,
    supported: u64,
    vendor_id: u16,
    device_id: u16,
    homogenous_depth: bool,
    origin_bottom_left: bool,
    num_gpus: u8,
    gpu: [4]Caps_GPU,
    limits: Caps_Limits,

    // TODO: is this legal?
    formats: [Texture_Format.Count]u16,
}

Internal_Data :: struct {
    caps: Caps,
    ctx: rawptr,
}

Platform_Data :: struct {
    ndt: rawptr,
    nwh: rawptr,
    ctx: rawptr,
    back_buffer: rawptr,
    back_buffer_ds: rawptr,
    type: Native_Window_Handle_Type,
}

Resolution :: struct {
    format: Texture_Format,
    width: u32,
    height: u32,
    reset: u32,
    num_back_buffers: u8,
    max_frame_latency: u8,
    debug_text_scale: u8,
}

Init_Limits :: struct {
    max_encoders: u16,
    min_resource_cb_size: u32,
    transient_vb_size: u32,
    transient_ib_size: u32,
}

Allocator_Interface :: struct {
    using vtbl: ^Allocator_Vtbl,
}

Allocator_Vtbl :: struct {
    realloc: proc "c" (this: ^Allocator_Interface, ptr: rawptr, size: uint, align: uint, file: cstring, line: u32) -> rawptr
}

Callback_Interface :: struct {
    using vtbl: ^Callback_Vtbl,
}

Callback_Vtbl :: struct {
    fatal: proc "c" (this: ^Callback_Interface, filepath: cstring, line: u16, code: Fatal, str: cstring),
    trace_vargs: proc "c" (this: ^Callback_Interface, filepath: cstring, line: u16, format: cstring, arg_list: Arg_List),
    profiler_begin: proc "c" (this: ^Callback_Interface, name: cstring, abgr: u32, filepath: cstring, line: u16),
    profiler_begin_literal: proc "c" (this: ^Callback_Interface, name: cstring, abgr: u32, filepath: cstring, line: u16),
    profiler_end: proc "c" (this: ^Callback_Interface),
    cache_read_size: proc "c" (this: ^Callback_Interface, id: u64) -> u32,
    cache_read: proc "c" (this: ^Callback_Interface, id: u64, data: rawptr, size: u32) -> bool, 
    cache_write: proc "c" (this: ^Callback_Interface, id: u64, data: rawptr, size: u32), 
    screen_shot: proc "c" (this: ^Callback_Interface, filepath: cstring, width, height, pitch: u32, data: rawptr, size: u32, yflip: bool),
    capture_begin: proc "c" (this: ^Callback_Interface, width, height, pitch: u32, format: Texture_Format, yflip: bool),
    capture_end: proc "c" (this: ^Callback_Interface), 
    capture_frame: proc "c" (this: ^Callback_Interface, data: rawptr, size: u32),
}

Init :: struct {
    /*
     * Select rendering backend. When set to RendererType::Count
     * a default rendering backend will be selected appropriate to the platform.
    */
    type: Renderer_Type,

    /*
     * Vendor PCI ID. If set to `BGFX_PCI_ID_NONE`, discrete and integrated
     * GPUs will be prioritised.
     *   - `BGFX_PCI_ID_NONE` - Autoselect adapter.
     *   - `BGFX_PCI_ID_SOFTWARE_RASTERIZER` - Software rasterizer.
     *   - `BGFX_PCI_ID_AMD` - AMD adapter.
     *   - `BGFX_PCI_ID_APPLE` - Apple adapter.
     *   - `BGFX_PCI_ID_INTEL` - Intel adapter.
     *   - `BGFX_PCI_ID_NVIDIA` - NVIDIA adapter.
     *   - `BGFX_PCI_ID_MICROSOFT` - Microsoft adapter.
     */
    vendor_id: u16,

    device_id: u16,
    capabilities: u64,
    debug: bool,
    profile: bool,
    platform_data: Platform_Data,
    resolution: Resolution,
    limits: Init_Limits,

    // TODO: implement callbacks
    callback: ^Callback_Interface,
    allocator: ^Allocator_Interface,
}

release_fn :: distinct proc "c" (ptr: rawptr, user_data: rawptr)

/*
 * Memory must be obtained by calling `bgfx::alloc`, `bgfx::copy`, or `bgfx::makeRef`.
 * @attention It is illegal to create this structure on stack and pass it to any bgfx API.
 *
*/
Memory :: struct {
    data: ^u8,
    size: u32,
}

Transient_Index_Buffer :: struct {
    data: ^u8,
    size: u32,
    start_index: u32,
    handle: Index_Buffer_Handle,
    is_index_16: bool,
}

Transient_Vertex_Buffer :: struct {
    data: ^u8,
    size: u32,
    start_vertex: u32,
    stride: u16,
    handle: Vertex_Buffer_Handle,
    layout_handle: Vertex_Layout_Handle,
}

Instance_Data_Buffer :: struct {
    data: ^u8,
    size: u32,
    offset: u32,
    num: u32,
    stride: u16,
    handle: Vertex_Buffer_Handle,
}

Texture_Info :: struct {
    format: Texture_Format,
    storage_size: u32,
    width, height, depth, num_layers: u16,
    num_mips, bits_per_pixel: u8,
    cube_map: bool,
}

Uniform_Info :: struct {
    name: [256]u8,
    type: Uniform_Type,
    num: u16,
}

Attachment :: struct {
    access: Access,
    handle: Texture_Handle,
    mip, layer, num_layers: u16,
    resolve: u8,
}

Transform :: struct {
    data: ^f32, // pointer to first 4x4 matrix
    num: u16,   // num of matricies
}

View_Stats :: struct {
    name: [256]u8,
    view: View_Id,
    cpu_time_begin: i64,
    cpu_time_end: i64,
    gpu_time_begin: i64,
    gpu_time_end: i64,
    gpu_frame_num: u32,
}

Encoder_Stats :: struct {
    cpu_time_begin: i64,
    cpu_time_end: i64,
}

/**
 * Renderer statistics data.
 * @remarks All time values are high-resolution timestamps, while
 * time frequencies define timestamps-per-second for that hardware.
 *
 */
Stats :: struct {
    cpu_time_frame:       i64,    // CPU time between two `bgfx::frame` calls
    cpu_time_begin:       i64,    // Render thread CPU submit begin time
    cpu_time_end:         i64,    // Render thread CPU submit end time
    cpu_timer_freq:       i64,    // CPU timer frequency. Timestamps-per-second
    gpu_time_begin:       i64,    // GPU frame begin time
    gpu_time_end:         i64,    // GPU frame end time
    gpu_timer_freq:       i64,    // GPU timer frequency
    wait_render:          i64,    // Time spent waiting for render backend thread
    wait_submit:          i64,    // Time spent waiting for submit thread
    num_draw:             u32,    // Number of draw calls submitted
    num_compute:          u32,    // Number of compute calls submitted
    num_blit:             u32,    // Number of blit calls submitted
    max_gpu_latency:      u32,    // GPU driver latency
    gpu_frame_num:        u32,    // Frame which generated gpu_time_begin/end
    num_dynamic_index_buffers:  u16,    // Number of used dynamic index buffers
    num_dynamic_vertex_buffers: u16,    // Number of used dynamic vertex buffers
    num_frame_buffers:    u16,    // Number of used frame buffers
    num_index_buffers:    u16,    // Number of used index buffers
    num_occlusion_queries: u16,   // Number of used occlusion queries
    num_programs:         u16,    // Number of used programs
    num_shaders:          u16,    // Number of used shaders
    num_textures:         u16,    // Number of used textures
    num_uniforms:         u16,    // Number of used uniforms
    num_vertex_buffers:   u16,    // Number of used vertex buffers
    num_vertex_layouts:   u16,    // Number of used vertex layouts
    texture_memory_used:  i64,    // Estimate of texture memory used
    rt_memory_used:       i64,    // Estimate of render target memory used
    transient_vb_used:    i32,    // Amount of transient vertex buffer used
    transient_ib_used:    i32,    // Amount of transient index buffer used
    num_prims:           [Topology.Count]u32, // Number of primitives rendered
    gpu_memory_max:       i64,    // Maximum available GPU memory
    gpu_memory_used:      i64,    // Amount of GPU memory used
    width:               u16,     // Backbuffer width in pixels
    height:              u16,     // Backbuffer height in pixels
    text_width:          u16,     // Debug text width in characters
    text_height:         u16,     // Debug text height in characters
    num_views:           u16,     // Number of view stats
    view_stats:          ^View_Stats,  // Array of View stats
    num_encoders:        u8,      // Number of encoders used during frame
    encoder_stats:       ^Encoder_Stats, // Array of encoder stats
}

Vertex_Layout :: struct {
    hash: u32,
    stride: u16,
    offset: [Attrib.Count]u16,
    attributes: [Attrib.Count]u16,
}

Function_Id :: enum {
    ATTACHMENT_INIT,
    VERTEX_LAYOUT_BEGIN,
    VERTEX_LAYOUT_ADD,
    VERTEX_LAYOUT_DECODE,
    VERTEX_LAYOUT_HAS,
    VERTEX_LAYOUT_SKIP,
    VERTEX_LAYOUT_END,
    VERTEX_LAYOUT_GET_OFFSET,
    VERTEX_LAYOUT_GET_STRIDE,
    VERTEX_LAYOUT_GET_SIZE,
    VERTEX_PACK,
    VERTEX_UNPACK,
    VERTEX_CONVERT,
    WELD_VERTICES,
    TOPOLOGY_CONVERT,
    TOPOLOGY_SORT_TRI_LIST,
    GET_SUPPORTED_RENDERERS,
    GET_RENDERER_NAME,
    INIT_CTOR,
    INIT,
    SHUTDOWN,
    RESET,
    FRAME,
    GET_RENDERER_TYPE,
    GET_CAPS,
    GET_STATS,
    ALLOC,
    COPY,
    MAKE_REF,
    MAKE_REF_RELEASE,
    SET_DEBUG,
    DBG_TEXT_CLEAR,
    DBG_TEXT_PRINTF,
    DBG_TEXT_VPRINTF,
    DBG_TEXT_IMAGE,
    CREATE_INDEX_BUFFER,
    SET_INDEX_BUFFER_NAME,
    DESTROY_INDEX_BUFFER,
    CREATE_VERTEX_LAYOUT,
    DESTROY_VERTEX_LAYOUT,
    CREATE_VERTEX_BUFFER,
    SET_VERTEX_BUFFER_NAME,
    DESTROY_VERTEX_BUFFER,
    CREATE_DYNAMIC_INDEX_BUFFER,
    CREATE_DYNAMIC_INDEX_BUFFER_MEM,
    UPDATE_DYNAMIC_INDEX_BUFFER,
    DESTROY_DYNAMIC_INDEX_BUFFER,
    CREATE_DYNAMIC_VERTEX_BUFFER,
    CREATE_DYNAMIC_VERTEX_BUFFER_MEM,
    UPDATE_DYNAMIC_VERTEX_BUFFER,
    DESTROY_DYNAMIC_VERTEX_BUFFER,
    GET_AVAIL_TRANSIENT_INDEX_BUFFER,
    GET_AVAIL_TRANSIENT_VERTEX_BUFFER,
    GET_AVAIL_INSTANCE_DATA_BUFFER,
    ALLOC_TRANSIENT_INDEX_BUFFER,
    ALLOC_TRANSIENT_VERTEX_BUFFER,
    ALLOC_TRANSIENT_BUFFERS,
    ALLOC_INSTANCE_DATA_BUFFER,
    CREATE_INDIRECT_BUFFER,
    DESTROY_INDIRECT_BUFFER,
    CREATE_SHADER,
    GET_SHADER_UNIFORMS,
    SET_SHADER_NAME,
    DESTROY_SHADER,
    CREATE_PROGRAM,
    CREATE_COMPUTE_PROGRAM,
    DESTROY_PROGRAM,
    IS_TEXTURE_VALID,
    IS_FRAME_BUFFER_VALID,
    CALC_TEXTURE_SIZE,
    CREATE_TEXTURE,
    CREATE_TEXTURE_2D,
    CREATE_TEXTURE_2D_SCALED,
    CREATE_TEXTURE_3D,
    CREATE_TEXTURE_CUBE,
    UPDATE_TEXTURE_2D,
    UPDATE_TEXTURE_3D,
    UPDATE_TEXTURE_CUBE,
    READ_TEXTURE,
    SET_TEXTURE_NAME,
    GET_DIRECT_ACCESS_PTR,
    DESTROY_TEXTURE,
    CREATE_FRAME_BUFFER,
    CREATE_FRAME_BUFFER_SCALED,
    CREATE_FRAME_BUFFER_FROM_HANDLES,
    CREATE_FRAME_BUFFER_FROM_ATTACHMENT,
    CREATE_FRAME_BUFFER_FROM_NWH,
    SET_FRAME_BUFFER_NAME,
    GET_TEXTURE,
    DESTROY_FRAME_BUFFER,
    CREATE_UNIFORM,
    GET_UNIFORM_INFO,
    DESTROY_UNIFORM,
    CREATE_OCCLUSION_QUERY,
    GET_RESULT,
    DESTROY_OCCLUSION_QUERY,
    SET_PALETTE_COLOR,
    SET_PALETTE_COLOR_RGBA32F,
    SET_PALETTE_COLOR_RGBA8,
    SET_VIEW_NAME,
    SET_VIEW_RECT,
    SET_VIEW_RECT_RATIO,
    SET_VIEW_SCISSOR,
    SET_VIEW_CLEAR,
    SET_VIEW_CLEAR_MRT,
    SET_VIEW_MODE,
    SET_VIEW_FRAME_BUFFER,
    SET_VIEW_TRANSFORM,
    SET_VIEW_ORDER,
    RESET_VIEW,
    ENCODER_BEGIN,
    ENCODER_END,
    ENCODER_SET_MARKER,
    ENCODER_SET_STATE,
    ENCODER_SET_CONDITION,
    ENCODER_SET_STENCIL,
    ENCODER_SET_SCISSOR,
    ENCODER_SET_SCISSOR_CACHED,
    ENCODER_SET_TRANSFORM,
    ENCODER_SET_TRANSFORM_CACHED,
    ENCODER_ALLOC_TRANSFORM,
    ENCODER_SET_UNIFORM,
    ENCODER_SET_INDEX_BUFFER,
    ENCODER_SET_DYNAMIC_INDEX_BUFFER,
    ENCODER_SET_TRANSIENT_INDEX_BUFFER,
    ENCODER_SET_VERTEX_BUFFER,
    ENCODER_SET_VERTEX_BUFFER_WITH_LAYOUT,
    ENCODER_SET_DYNAMIC_VERTEX_BUFFER,
    ENCODER_SET_DYNAMIC_VERTEX_BUFFER_WITH_LAYOUT,
    ENCODER_SET_TRANSIENT_VERTEX_BUFFER,
    ENCODER_SET_TRANSIENT_VERTEX_BUFFER_WITH_LAYOUT,
    ENCODER_SET_VERTEX_COUNT,
    ENCODER_SET_INSTANCE_DATA_BUFFER,
    ENCODER_SET_INSTANCE_DATA_FROM_VERTEX_BUFFER,
    ENCODER_SET_INSTANCE_DATA_FROM_DYNAMIC_VERTEX_BUFFER,
    ENCODER_SET_INSTANCE_COUNT,
    ENCODER_SET_TEXTURE,
    ENCODER_TOUCH,
    ENCODER_SUBMIT,
    ENCODER_SUBMIT_OCCLUSION_QUERY,
    ENCODER_SUBMIT_INDIRECT,
    ENCODER_SUBMIT_INDIRECT_COUNT,
    ENCODER_SET_COMPUTE_INDEX_BUFFER,
    ENCODER_SET_COMPUTE_VERTEX_BUFFER,
    ENCODER_SET_COMPUTE_DYNAMIC_INDEX_BUFFER,
    ENCODER_SET_COMPUTE_DYNAMIC_VERTEX_BUFFER,
    ENCODER_SET_COMPUTE_INDIRECT_BUFFER,
    ENCODER_SET_IMAGE,
    ENCODER_DISPATCH,
    ENCODER_DISPATCH_INDIRECT,
    ENCODER_DISCARD,
    ENCODER_BLIT,
    REQUEST_SCREEN_SHOT,
    RENDER_FRAME,
    SET_PLATFORM_DATA,
    GET_INTERNAL_DATA,
    OVERRIDE_INTERNAL_TEXTURE_PTR,
    OVERRIDE_INTERNAL_TEXTURE,
    SET_MARKER,
    SET_STATE,
    SET_CONDITION,
    SET_STENCIL,
    SET_SCISSOR,
    SET_SCISSOR_CACHED,
    SET_TRANSFORM,
    SET_TRANSFORM_CACHED,
    ALLOC_TRANSFORM,
    SET_UNIFORM,
    SET_INDEX_BUFFER,
    SET_DYNAMIC_INDEX_BUFFER,
    SET_TRANSIENT_INDEX_BUFFER,
    SET_VERTEX_BUFFER,
    SET_VERTEX_BUFFER_WITH_LAYOUT,
    SET_DYNAMIC_VERTEX_BUFFER,
    SET_DYNAMIC_VERTEX_BUFFER_WITH_LAYOUT,
    SET_TRANSIENT_VERTEX_BUFFER,
    SET_TRANSIENT_VERTEX_BUFFER_WITH_LAYOUT,
    SET_VERTEX_COUNT,
    SET_INSTANCE_DATA_BUFFER,
    SET_INSTANCE_DATA_FROM_VERTEX_BUFFER,
    SET_INSTANCE_DATA_FROM_DYNAMIC_VERTEX_BUFFER,
    SET_INSTANCE_COUNT,
    SET_TEXTURE,
    TOUCH,
    SUBMIT,
    SUBMIT_OCCLUSION_QUERY,
    SUBMIT_INDIRECT,
    SUBMIT_INDIRECT_COUNT,
    SET_COMPUTE_INDEX_BUFFER,
    SET_COMPUTE_VERTEX_BUFFER,
    SET_COMPUTE_DYNAMIC_INDEX_BUFFER,
    SET_COMPUTE_DYNAMIC_VERTEX_BUFFER,
    SET_COMPUTE_INDIRECT_BUFFER,
    SET_IMAGE,
    DISPATCH,
    DISPATCH_INDIRECT,
    DISCARD,
    BLIT,
    COUNT,
}

// TODO: implement. this is not 100% needed, but may be nice to have.
/*
Interface_Vtbl :: struct {}
*/
Interface_Vtbl :: distinct rawptr

@(link_prefix="bgfx_", default_calling_convention = "c")
foreign lib {
    attachment_init :: proc(attachment: ^Attachment, handle: Texture_Handle, access: Access, layer: u16, num_layers: u16, mip: u16, resolve: u8) ---

    vertex_layout_begin:: proc(layout: ^Vertex_Layout, renderer_type: Renderer_Type) -> ^Vertex_Layout ---
    vertex_layout_add:: proc(layout: ^Vertex_Layout, attrib: Attrib, type: Attrib_Type, normalized: bool, as_int: bool) -> ^Vertex_Layout ---
    vertex_layout_decode:: proc(layout: ^Vertex_Layout, attrib: Attrib, num: u8, type: Attrib_Type, normalized: bool, as_int: bool) ---
    vertex_layout_has:: proc(layout: ^Vertex_Layout, attrib: Attrib) -> bool ---
    vertex_layout_skip:: proc(layout: ^Vertex_Layout, num: u8) -> ^Vertex_Layout ---
    vertex_layout_end:: proc(layout: ^Vertex_Layout) ---
    vertex_layout_get_offset:: proc(layout: ^Vertex_Layout, attrib: Attrib) -> u16 ---
    vertex_layout_get_stride:: proc(layout: ^Vertex_Layout) -> u16 ---
    vertex_layout_get_size:: proc(layout: ^Vertex_Layout, num: u32) -> u32 ---
    vertex_pack :: proc(input: [4]f32, input_normalized: bool, attr: Attrib, layout: ^Vertex_Layout, data: rawptr, index: u32) ---
    vertex_unpack :: proc(input: [4]f32, attr: Attrib, layout: ^Vertex_Layout, data: rawptr, index: u32) ---
    vertex_convert:: proc(dst_layout: ^Vertex_Layout, dst_data: rawptr, src_layout: ^Vertex_Layout, src_data: rawptr, num: u32) ---
    weld_vertices:: proc(output: rawptr, layout: ^Vertex_Layout, data: rawptr, num: u32, index_32: bool, epsilon: f32) -> u32 ---

    topology_convert :: proc(conversion: Topology_Convert, dst: rawptr, dst_size: u32, indices: rawptr, num_indices: u32, index_32: bool) -> u32 ---
    topology_sort_tri_list :: proc(sort: Topology_Sort, dst: rawptr, dst_size: u32, dir: [3]f32, pos: [3]f32, vertices: rawptr, stride: u32, indices: rawptr, num_indices: u32, index_32: bool) ---

    // TODO: type was originally called enum, but enum is a keyword. Need to find the best name for this param
    get_supported_renderers :: proc(max: u8, type: ^Renderer_Type) -> u8 ---
    get_renderer_name :: proc(type: Renderer_Type) -> cstring ---

    init_ctor :: proc(init: ^Init) ---
    init :: proc(init: ^Init) -> bool ---
    shutdown :: proc() ---
    reset :: proc(width, height, flags: u32, format: Texture_Format) ---
    frame :: proc(capture: bool) -> u32 ---

    get_renderer_type :: proc() -> Renderer_Type ---
    get_caps :: proc() -> ^Caps ---
    get_stats :: proc() -> ^Stats ---
    alloc :: proc(size: u32) -> ^Memory ---
    copy :: proc(data: rawptr, size: u32) -> ^Memory ---

    make_ref :: proc(data: rawptr, size: u32) -> ^Memory ---
    make_ref_release :: proc(data: rawptr, size: u32, release_fn: release_fn, user_data: rawptr) -> ^Memory ---

    set_debug :: proc(debug: u32) ---
    dbg_text_clear :: proc(attr: u8, small: bool) ---
    // TODO: variadic support
    // BGFX_C_API void bgfx_dbg_text_printf(uint16_t _x, uint16_t _y, uint8_t _attr, const char* _format, ... );
    dbg_text_printf :: proc(x, y: u16, attr: u8, format: cstring, ) ---
    dbg_text_vprintf :: proc(x, y: u16, attr: u8, format: cstring, arg_list: Arg_List) ---
    dbg_text_image:: proc(x, y, width, height: u16, data: rawptr, pitch: u16) ---

    create_index_buffer :: proc(mem: ^Memory, flags: u16) -> Index_Buffer_Handle ---
    set_index_buffer_name :: proc(handle: Index_Buffer_Handle, name: cstring, len: i32) ---
    destroy_index_buffer :: proc(handle: Index_Buffer_Handle) ---

    create_vertex_layout :: proc(layout: ^Vertex_Layout) -> Vertex_Layout_Handle ---
    destroy_vertex_layout :: proc(layout_handle: Vertex_Layout_Handle) ---

    create_vertex_buffer :: proc(mem: ^Memory, layout: ^Vertex_Layout, flags: u16) -> Vertex_Buffer_Handle ---
    set_vertex_buffer_name :: proc(handle: Vertex_Buffer_Handle, name: cstring, len: i32) ---
    destroy_vertex_buffer:: proc(handle: Vertex_Buffer_Handle) ---

    create_dynamic_index_buffer :: proc(num: u32, flags: u16) -> Dynamic_Index_Buffer_Handle ---
    create_dynamic_index_buffer_mem :: proc(mem: ^Memory, flags: u16) -> Dynamic_Index_Buffer_Handle ---
    update_dynamic_index_buffer :: proc(handle: Dynamic_Index_Buffer_Handle, start_index: u32, mem: ^Memory) ---
    destroy_dynamic_index_buffer :: proc(handle: Dynamic_Index_Buffer_Handle) ---

    create_dynamic_vertex_buffer :: proc(num: u32, layout: ^Vertex_Layout, flags: u16) -> Dynamic_Vertex_Buffer_Handle ---
    create_dynamic_vertex_buffer_mem :: proc(mem: ^Memory, layout: ^Vertex_Layout, flags: u16) -> Dynamic_Vertex_Buffer_Handle ---
    update_dynamic_vertex_buffer :: proc(handle: Dynamic_Vertex_Buffer_Handle, start_vertex: u32, mem: ^Memory) ---
    destroy_dynamic_vertex_buffer :: proc(handle: Dynamic_Vertex_Buffer_Handle) ---

    get_avail_transient_index_buffer :: proc(num: u32, index_32: bool) -> u32 ---
    get_avail_instance_data_buffer :: proc(num: u32, stride: bool) -> u32 ---

    alloc_transient_index_buffer :: proc(tib: ^Transient_Index_Buffer, num: u32, index_32: bool) ---
    alloc_transient_vertex_buffer :: proc(tvb: ^Transient_Vertex_Buffer, num: u32, layout: ^Vertex_Layout) ---
    alloc_transient_buffers :: proc(tvb: ^Transient_Vertex_Buffer, layout: ^Vertex_Layout, num_vertices: u32, tib: ^Transient_Index_Buffer, num_indices: u32, index_32: bool) -> bool ---
    alloc_instance_data_buffer :: proc(idb: ^Instance_Data_Buffer, num: u32, stride: u16) ---

    create_indirect_buffer :: proc(num: u32) -> Indirect_Buffer_Handle ---
    destroy_indirect_buffer :: proc(handle: Indirect_Buffer_Handle) ---

    create_shader :: proc(mem: ^Memory) -> Shader_Handle ---
    get_shader_uniforms :: proc(handle: Shader_Handle, uniforms: ^Uniform_Handle, max: u16) -> u16 ---
    set_shader_name :: proc(handle: Shader_Handle, name: cstring, len: i32) ---
    destroy_shader :: proc(handle: Shader_Handle) ---

    create_program :: proc(vsh: Shader_Handle, fsh: Shader_Handle, destroy_shaders: bool) -> Program_Handle --- 
    create_compute_program :: proc(csh: Shader_Handle, destroy_shaders: bool) -> Program_Handle --- 
    destroy_program :: proc(handle: Program_Handle) --- 

    is_texture_valid :: proc(depth: u16, cube_map: bool, num_layers: u16, format: Texture_Format, flags: u64) -> bool ---
    is_frame_buffer_size_valid :: proc(num: u8, attachment: ^Attachment) -> bool ---
    calc_texture_size :: proc(info: ^Texture_Info, width, height, depth: u16, cube_map: bool, has_mips: bool, num_layers: u16, format: Texture_Format) ---

    create_texture :: proc(mem: ^Memory, flags: u64, skip: u8, info: ^Texture_Info) -> Texture_Handle ---
    create_texture_2d :: proc(width, height: u16, has_mips: bool, num_layers: u16, format: Texture_Format, flags: u64, mem: ^Memory) -> Texture_Handle ---
    create_texture_2d_scaled :: proc(ratio: Backbuffer_Ratio, has_mips: bool, num_layers: u16, format: Texture_Format, flags: u64) -> Texture_Handle ---
    create_texture_3d :: proc(width, height, depth: u16, has_mips: bool, format: Texture_Format, flags: u64, mem: ^Memory) -> Texture_Handle ---
    create_texture_cube :: proc(size: u16, has_mips: bool, num_layers: u16, format: Texture_Format, flags: u64, mem: ^Memory) -> Texture_Handle ---

    update_texture_2d :: proc(handle: Texture_Handle, layer: u16, mip: u8, x, y, w, h: u16, mem: ^Memory, pitch: u16) ---
    update_texture_3d :: proc(handle: Texture_Handle, mip: u8, x, y, z, w, h, depth: u16, mem: ^Memory) ---
    update_texture_cube:: proc(handle: Texture_Handle, layer: u16, side: u8, mip: u8, x, y, w, h: u16, mem: ^Memory, pitch: u16) ---

    read_texture :: proc(handle: Texture_Handle, data: rawptr, mip: u8) -> u32 ---
    set_texture_name :: proc(handle: Texture_Handle, name: cstring, len: i32) ---
    get_direct_access_ptr :: proc(handle: Texture_Handle) -> rawptr ---

    destroy_texture :: proc(handle: Texture_Handle) ---

    create_frame_buffer :: proc(w, h: u16, format: Texture_Format, texture_flags: u64) -> Frame_Buffer_Handle ---
    create_frame_buffer_scaled :: proc(ratio: Backbuffer_Ratio, format: Texture_Format, texture_flags: u64) -> Frame_Buffer_Handle ---
    // TODO: should these handles be an array of pointers?
    create_frame_buffer_from_handles :: proc(num: u8, handles: ^Texture_Handle, destroy_texture: bool) -> Frame_Buffer_Handle ---
    create_frame_buffer_from_attachment:: proc(num: u8, attachment: ^Attachment, destroy_texture: bool) -> Frame_Buffer_Handle ---
    create_frame_buffer_from_nwh :: proc(nwh: rawptr, w, h: u16, format: Texture_Format, depth_format: Texture_Format) -> Frame_Buffer_Handle ---
    set_frame_buffer_name :: proc(handle: Frame_Buffer_Handle, name: cstring, len: i32) ---
    get_texture :: proc(handle: Frame_Buffer_Handle, attachment: u8) -> Texture_Handle ---
    destroy_frame_buffer :: proc(handle: Frame_Buffer_Handle) ---

    create_uniform :: proc(name: cstring, type: Uniform_Type, num: u16) -> Uniform_Handle ---
    get_uniform_info :: proc(handle: Uniform_Handle, info: ^Uniform_Info) --- 
    destroy_uniform :: proc(handle: Uniform_Handle) ---

    create_occlusion_query :: proc() -> Occlusion_Query_Handle ---
    get_result :: proc(handle: Occlusion_Query_Handle, result: ^i32) -> Occlusion_Query_Result ---
    destroy_occlusion_query :: proc(handle: Occlusion_Query_Result) ---

    // TODO: procedure group
    set_palette_color :: proc(index: u8, rgba: [4]f32) ---
    set_palette_color_rgba32f :: proc(index: u8, r, g, b, a: f32) ---
    set_palette_color_rgba8 :: proc(index: u8, rgba: u32) ---

    set_view_name :: proc(id: View_Id, name: cstring, len: i32) ---
    set_view_rect :: proc(id: View_Id, x, y, w, h: u16) ---
    set_view_rect_ratio :: proc(id: View_Id, x, y: u16, ratio: Backbuffer_Ratio) ---
    set_view_scissor :: proc(id: View_Id, x, y, w, h: u16) ---
    set_view_clear :: proc(id: View_Id, flags: u16, rgba: u32, depth: f32, stencil: u8) ---
    set_view_clear_mrt :: proc(id: View_Id, flags: u16, depth: f32, stencil: u8, c0, c1, c2, c3, c4, c5, c6, c7: u8) ---
    set_view_mode :: proc(id: View_Id, mode: View_Mode) ---
    set_view_frame_buffer :: proc(id: View_Id, handle: Frame_Buffer_Handle) ---
    set_view_transform:: proc(id: View_Id, view: rawptr, proj: rawptr) ---
    set_view_order :: proc(id: View_Id, num: u16, order: ^View_Id) ---
    reset_view :: proc(id: View_Id) ---

    encoder_begin :: proc(for_thread: bool) -> ^Encoder ---
    encoder_end :: proc(encoder: ^Encoder) ---

    encoder_set_marker :: proc(encoder: ^Encoder, name: cstring, len: i32) ---
    encoder_set_state :: proc(encoder: ^Encoder, state: u64, rgba: u32) ---
    encoder_set_condition :: proc(encoder: ^Encoder, handle: Occlusion_Query_Handle, visible: bool) ---
    encoder_set_stencil :: proc(encoder: ^Encoder, fstencil: u32, bstencil: u32) ---
    encoder_set_scissor :: proc(encoder: ^Encoder, x, y, w, h: u16) -> u16 ---
    encoder_set_scissor_cached :: proc(encoder: ^Encoder, cache: u16) ---
    // TODO: mtx should be an array
    encoder_set_transform :: proc(encoder: ^Encoder, mtx: rawptr, num: u16) -> u32 ---
    encoder_set_transform_cache :: proc(encoder: ^Encoder, cache: u32, num: u16) ---
    encoder_alloc_transform :: proc(encoder: ^Encoder, transform: ^Transform, num: u16) -> u32 ---
    encoder_set_uniform :: proc(encoder: ^Encoder, handle: Uniform_Handle, value: rawptr, num: u16) ---
    encoder_set_index_buffer :: proc(encoder: ^Encoder, handle: Index_Buffer_Handle, first_index: u32, num_indices: u32) ---
    encoder_set_dynamic_index_buffer :: proc(encoder: ^Encoder, handle: Dynamic_Index_Buffer_Handle, first_index: u32, num_indices: u32) ---
    encoder_set_transient_index_buffer :: proc(encoder: ^Encoder, tib: ^Transient_Index_Buffer, first_index: u32, num_indices: u32) ---
    encoder_set_vertex_buffer :: proc(encoder: ^Encoder, stream: u8, handle: Vertex_Buffer_Handle, start_vertex: u32, num_vertices: u32) ---
    encoder_set_vertex_buffer_with_layout :: proc(encoder: ^Encoder, stream: u8, handle: Vertex_Buffer_Handle, start_vertex: u32, num_vertices: u32, layout_handle: Vertex_Layout_Handle) ---
    encoder_set_dynamic_vertex_buffer :: proc(encoder: ^Encoder, stream: u8, handle: Dynamic_Vertex_Buffer_Handle, start_vertex: u32, num_vertices: u32) ---
    encoder_set_dynamic_vertex_buffer_with_layout :: proc(encoder: ^Encoder, stream: u8, handle: Dynamic_Vertex_Buffer_Handle, start_vertex: u32, num_vertices: u32, layout_handle: Vertex_Layout_Handle) ---
    encoder_set_transient_vertex_buffer :: proc(encoder: ^Encoder, stream: u8, tvb: ^Transient_Vertex_Buffer, start_vertex: u32, num_indices: u32) ---
    encoder_set_transient_vertex_buffer_with_layout :: proc(encoder: ^Encoder, stream: u8, tvb: ^Transient_Vertex_Buffer, start_vertex: u32, num_vertices: u32, layout_handle: Vertex_Layout_Handle) ---
    encoder_set_vertex_count :: proc(encoder: ^Encoder, num_vertices: u32) ---
    encoder_set_instance_data_buffer :: proc(encoder: ^Encoder, idb: ^Instance_Data_Buffer, start: u32, num: u32) ---
    encoder_set_instance_data_from_vertex_buffer :: proc(encoder: ^Encoder, handle: Vertex_Buffer_Handle, start_vertex: u32, num: u32) ---
    encoder_set_instance_data_from_dynamic_vertex_buffer :: proc(encoder: ^Encoder, handle: Dynamic_Vertex_Buffer_Handle, start_vertex: u32, num: u32) ---
    encoder_set_instance_count :: proc(encoder: ^Encoder, num_instances: u32) ---
    encoder_set_texture :: proc(encoder: ^Encoder, state: u8, sampler: Uniform_Handle, handle: Texture_Handle, flags: u32) ---
    encoder_touch :: proc(encoder: ^Encoder, id: View_Id) ---
    encoder_submit :: proc(encoder: ^Encoder, id: View_Id, program: Program_Handle, depth: i32, flags: u8) ---
    encoder_submit_occlusion_query :: proc(encoder: ^Encoder, id: View_Id, program: Program_Handle, occlusion_query: Occlusion_Query_Handle, depth: i32, flags: u8) ---
    encoder_submit_indirect :: proc(encoder: ^Encoder, id: View_Id, program: Program_Handle, indirect_handle: Indirect_Buffer_Handle, start, num, depth: u32, flags: u8) ---
    encoder_submit_indirect_count :: proc(encoder: ^Encoder, id: View_Id, program: Program_Handle, indirect_handle: Indirect_Buffer_Handle, start: u32, num_handle: Index_Buffer_Handle, num_index, num_max, depth: u32, flags: u8) ---
    encoder_set_compute_index_buffer :: proc(encoder: ^Encoder, stage: u8, handle: Index_Buffer_Handle, access: Access) ---
    encoder_set_compute_vertex_buffer :: proc(encoder: ^Encoder, stage: u8, handle: Vertex_Buffer_Handle, access: Access) ---
    encoder_set_compute_dynamic_index_buffer :: proc(encoder: ^Encoder, stage: u8, handle: Dynamic_Index_Buffer_Handle, access: Access) ---
    encoder_set_compute_dynamic_vertex_buffer :: proc(encoder: ^Encoder, stage: u8, handle: Dynamic_Vertex_Buffer_Handle, access: Access) ---
    encoder_set_image :: proc(encoder: ^Encoder, stage: u8, handle: Texture_Handle, mip: u8, access: Access, format: Texture_Format) ---
    encoder_dispatch :: proc(encoder: ^Encoder, id: View_Id, program: Program_Handle, num_x, num_y, num_z: u32, flags: u8) ---
    encoder_dispatch_indirect :: proc(encoder: ^Encoder, id: View_Id, program: Program_Handle, indirect_handle: Indirect_Buffer_Handle, start, num: u32, flags: u8) ---
    encoder_discard :: proc(encoder: ^Encoder, flags: u8) ---
    encoder_blit:: proc(encoder: ^Encoder, id: View_Id, dst: Texture_Handle, dst_mip: u8, dst_x, dst_y, dst_z: u16, src: Texture_Handle, src_mip: u8, src_x, src_y, src_z: u16, w, h, depth: u16) ---

    request_screen_shot :: proc(handle: Frame_Buffer_Handle, filepath: cstring) ---

    render_frame :: proc(m_secs: i32) -> Render_Frame ---
    set_platform_data :: proc(data: ^Platform_Data) ---
    get_internal_data :: proc() -> ^Internal_Data ---

    override_internal_texture_ptr :: proc(handle: Texture_Handle, ptr: uintptr) -> uintptr --- 
    override_internal_texture :: proc(handle: Texture_Handle, w, h: u16, num_mips: u8, format: Texture_Format, flags: u64) -> uintptr --- 

    set_marker :: proc(name: cstring, len: i32) ---
    set_state :: proc(state: u64, rgba: u32) ---
    set_condition :: proc(handle: Occlusion_Query_Handle, visible: bool) ---
    set_stencil :: proc(fstencil, bstencil: u32) ---
    set_scissor :: proc(x, y, w, h: u16) -> u16 ---
    set_scissor_cached :: proc(cache: u16) ---
    set_transform :: proc(mtx: rawptr, num: u16) -> u32 ---
    set_transform_cached :: proc(cache: u32, num: u16) ---
    
    alloc_transform :: proc(transform: ^Transform, num: u16) -> u32 ---

    set_uniform :: proc(handle: Uniform_Handle, value: rawptr, num: u16) ---
    set_index_buffer :: proc(handle: Index_Buffer_Handle, first_index, num_indices: u32) ---
    set_dynamic_index_buffer :: proc(handle: Dynamic_Index_Buffer_Handle, first_index, num_indices: u32) ---
    set_transient_index_buffer :: proc(tib: ^Transient_Index_Buffer, first_index, num_indices: u32) ---
    set_vertex_buffer :: proc(stream: u8, handle: Vertex_Buffer_Handle, start_vertex, num_vertices: u32) ---
    set_vertex_buffer_with_layout :: proc(stream: u8, handle: Vertex_Buffer_Handle, start_vertex, num_vertices: u32, layout_handle: Vertex_Layout_Handle) ---
    set_dynamic_vertex_buffer :: proc(stream: u8, handle: Dynamic_Vertex_Buffer_Handle, start_vertex, num_vertices: u32) ---
    set_dynamic_vertex_buffer_with_layout :: proc(stream: u8, handle: Dynamic_Vertex_Buffer_Handle, start_vertex, num_vertices: u32, layout_handle: Vertex_Layout_Handle) ---
    set_transient_vertex_buffer :: proc(stream: u8, tvb: ^Transient_Vertex_Buffer, start_vertex, num_vertices: u32) ---
    set_transient_vertex_buffer_with_layout :: proc(stream: u8, tvb: ^Transient_Vertex_Buffer, start_vertex, num_vertices: u32, layout_handle: Vertex_Layout_Handle) ---
    set_vertex_count :: proc(num_vertices: u32) ---
    set_instance_data_buffer :: proc(idb: ^Instance_Data_Buffer, start, num: u32) ---
    set_instance_data_from_vertex_buffer :: proc(handle: Vertex_Buffer_Handle, start, num: u32) ---
    set_instance_data_from_dynamic_vertex_buffer :: proc(handle: Dynamic_Vertex_Buffer_Handle, start, num: u32) ---
    set_instance_count :: proc(num_instances: u32) ---
    set_texture :: proc(state: u8, sampler: Uniform_Handle, handle: Texture_Handle, flags: u32) ---
    touch :: proc(id: View_Id) ---
    submit :: proc(id: View_Id, program: Program_Handle, depth: u32, flags: u8) ---
    submit_occlusion_query :: proc(id: View_Id, program: Program_Handle, occlusion_query: Occlusion_Query_Handle, depth: u32, flags: u8) ---
    submit_indirect :: proc(id: View_Id, program: Program_Handle, indirect_handle: Indirect_Buffer_Handle, start, num, depth: u32, flags: u8) ---
    submit_indirect_count :: proc(id: View_Id, program: Program_Handle, indirect_handle: Indirect_Buffer_Handle, start: u32, num_handle: Index_Buffer_Handle, num_index, num_max, depth: u32, flags: u8) ---
    set_compute_index_buffer :: proc(stage: u8, handle: Index_Buffer_Handle, access: Access) ---
    set_compute_vertex_buffer :: proc(stage: u8, handle: Vertex_Buffer_Handle, access: Access) ---
    set_compute_dynamic_index_buffer :: proc(stage: u8, handle: Dynamic_Index_Buffer_Handle, access: Access) ---
    set_compute_dynamic_vertex_buffer :: proc(stage: u8, handle: Dynamic_Vertex_Buffer_Handle, access: Access) ---
    set_compute_indirect_buffer :: proc(stage: u8, handle: Indirect_Buffer_Handle, access: Access) ---

    set_image :: proc(stage: u8, handle: Texture_Handle, mip: u8, access: Access, format: Texture_Format) ---

    dispatch :: proc(id: View_Id, program: Program_Handle, num_x, num_y, num_z: u32, flags: u8) ---
    dispatch_indirect :: proc(id: View_Id, program: Program_Handle, indirect_handle: Indirect_Buffer_Handle, start, num: u32, flags: u8) ---
    discard :: proc(flags: u8) ---
    blit :: proc(id: View_Id, dst: Texture_Handle, dst_mip: u8, dst_x, dst_y, dst_z: u16, src: Texture_Handle, src_mip: u8, src_x, src_y, src_z: u16, w, h, depth: u16) ---

    get_interface :: proc(version: u32) -> ^Interface_Vtbl ---
}
