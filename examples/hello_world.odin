package hello_world

// Tested only on Linux with Wayland and Windows, if you have any issues, let me know

import "base:runtime"

import "core:fmt"

import "vendor:glfw"

import bgfx "../"

frame_size: [2]i32 = {0, 0}

glfw_key_cb :: proc "c" (
    window: glfw.WindowHandle,
    key, scancode, action, mods: i32
) {
    context = runtime.default_context()
    
    if key == glfw.KEY_ESCAPE && action == glfw.PRESS {
        glfw.SetWindowShouldClose(window, glfw.TRUE)
    }
}

glfw_err_cb :: proc "c" (code: i32, desc: cstring) {
    context = runtime.default_context()
    fmt.printfln("[GLFW ERROR] %d, %s", code, desc)
}

glfw_fb_size_cb :: proc "c" (window: glfw.WindowHandle, width, height: i32) {
    frame_size = {
        width, 
        height
    }
}

get_platform_handles :: proc(window: glfw.WindowHandle) -> (rawptr, rawptr) {
    when ODIN_OS == .Windows {
        //NOTE(elaeja): We do not need to provide the display for windows 
        hwnd := rawptr(glfw.GetWin32Window(window))
        return hwnd, nil
    } else when ODIN_OS == .Linux {
        // try X11 first
        x11d := rawptr(glfw.GetX11Display())
        x11w := rawptr(uintptr(glfw.GetX11Window(window)))
        if x11d != nil && x11w != nil {
            return x11w, x11d
        } else {
            fmt.println("Could not get X11, trying Wayland")
            wayd := glfw.GetWaylandDisplay()
            wayw := glfw.GetWaylandWindow(window)
            if wayd == nil || wayw == nil {
                fmt.panicf("could not get x11 or wayland display or window handle, display: %p, window: %p", wayd, wayw)
            }
            return wayw, wayd, 
        }
    } else when ODIN_OS == .Darwin {
        // TODO: implement
    }
}

main :: proc() {
    glfw.SetErrorCallback(glfw_err_cb);

    if !glfw.Init() { panic("glfw init failed") }
    defer glfw.Terminate()

    glfw.WindowHint(glfw.CLIENT_API, glfw.NO_API)
    
    // TODO(elaeja): add check for supported renderers
    
    // NOTE(elaeja): this would be needed for OpenGL
    //glfw.WindowHint(glfw.CLIENT_API, glfw.OPENGL_API)
    //glfw.WindowHint(glfw.CONTEXT_VERSION_MAJOR, 3)
    //glfw.WindowHint(glfw.CONTEXT_VERSION_MINOR, 3)
    //glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE)

    window := glfw.CreateWindow(800, 600, "Hello from bgfx!", nil, nil)
    if window == nil { panic("glfw failed to create window") }
    defer glfw.DestroyWindow(window)

    glfw.SetKeyCallback(window, glfw_key_cb)
    //SetWindowSizeCallback         :: proc(window: WindowHandle, cbfun: WindowSizeProc)         -> WindowSizeProc -
	glfw.SetFramebufferSizeCallback(window, glfw_fb_size_cb)
    fmt.println("calling init ctor")
    init: bgfx.Init
    bgfx.init_ctor(&init)
    fmt.println("called init ctor")

    // Explicitly setting the renderer type
    init.type = .Vulkan
    
    fmt.println("getting display and window handles")
    w_handle, d_handle := get_platform_handles(window)
    fmt.printfln("%p, %p", w_handle, d_handle)
    fmt.println("got display and window handles")

    fmt.println("setting up platform data")
    init.platform_data = {
        nwh = w_handle,
        ndt = d_handle,
        type = .Wayland,
    }
    fmt.println(init.platform_data)
    fmt.println("set up platform data")

    fmt.println("setting up resolution data")
    w,h := glfw.GetWindowSize(window)
    init.resolution = {
        width = u32(w),
        height = u32(h),
        reset = bgfx.RESET_VSYNC,
        format = .RGBA8,
    }
    fmt.println(init.resolution)
    fmt.println("set up resolution data")
   
    fmt.println("initializing bgfx")
    if !bgfx.init(&init) { panic("bgfx failed to init!") }
    defer bgfx.shutdown()
    frame_size.x, frame_size.y = glfw.GetFramebufferSize(window)
    bgfx.reset(u32(frame_size.x), u32(frame_size.y), bgfx.RESET_VSYNC, .RGBA8)
    fmt.println("initialized bgfx")

	bgfx.set_debug(bgfx.DEBUG_TEXT);
    
    fmt.println("setting up view")
    main_view_id: bgfx.View_Id = 0
    bgfx.set_view_clear(main_view_id, bgfx.CLEAR_COLOR | bgfx.CLEAR_DEPTH, 0x501010FF, 1.0, 0)
    fmt.println("set up view")

    fmt.println("starting main loop")
    for !glfw.WindowShouldClose(window) {
        glfw.PollEvents()

        bgfx.set_view_rect(main_view_id, 0, 0, u16(frame_size.x), u16(frame_size.y))
        
        // This dummy draw call is here to make sure that view 0 is cleared
		// if no other draw calls are submitted to view 0.
        encoder := bgfx.encoder_begin(false);
        // sanity check
        assert(encoder != nil, "bgfx encoder is nil!")
        bgfx.encoder_touch(encoder, main_view_id);
		bgfx.encoder_end(encoder);

		bgfx.dbg_text_clear(0, false);
		bgfx.dbg_text_printf(42, 18, 0x0f, "Hello from BGFX!");
        
        // Advance to next frame. Rendering thread will be kicked to
		// process submitted rendering primitives.
        bgfx.frame(false)
    }
}
