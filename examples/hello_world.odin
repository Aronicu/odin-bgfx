package hello_world

import "base:runtime"

import "core:fmt"

import "vendor:glfw"

import bgfx "shared:odin-bgfx"

fatal_cb :: proc "c" (this: ^bgfx.Callback_Interface, filepath: cstring, line: u16, code: bgfx.Fatal, str: cstring) {
    context = runtime.default_context()
    fmt.printf("[FATAL] filepath: %s, line: %d, code: %d, str: %s\n", filepath, line, code, str)
}

trace_vargs_cb :: proc "c" (this: ^bgfx.Callback_Interface, filepath: cstring, line: u16, format: cstring, arg_list: bgfx.Arg_List) {
    context = runtime.default_context()
    fmt.printf("[TRACE] filepath: %s, line: %d, format: %s, arg_list: %v\n", filepath, line, format, arg_list)
}

glfw_key_cb :: proc "c" (
    window: glfw.WindowHandle,
    key, scancode, action, mods: i32
) {
    if key == glfw.KEY_ESCAPE && action == glfw.PRESS {
        glfw.SetWindowShouldClose(window, glfw.TRUE)
    }
}

glfw_err_cb :: proc "c" (code: i32, desc: cstring) {
    context = runtime.default_context()
    fmt.println(desc, code)
}

main :: proc() {
    glfw.SetErrorCallback(glfw_err_cb);

    if !glfw.Init() { panic("glfw init failed") }
    defer glfw.Terminate()

    glfw.WindowHint(glfw.CLIENT_API, glfw.NO_API)
    //glfw.WindowHint(glfw.CLIENT_API, glfw.OPENGL_API)
    //glfw.WindowHint(glfw.CONTEXT_VERSION_MAJOR, 3)
    //glfw.WindowHint(glfw.CONTEXT_VERSION_MINOR, 3)
    //glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE)
    window := glfw.CreateWindow(800, 600, "Hello from bgfx!", nil, nil)
    if window == nil { panic("glfw failed to create window") }
    defer glfw.DestroyWindow(window)

    glfw.SetKeyCallback(window, glfw_key_cb)

    fmt.println("calling init ctor")
    init: bgfx.Init
    bgfx.init_ctor(&init)
    fmt.println("called init ctor")

    init.type = .Vulkan

    fmt.println("getting wayland display and window")
    wd := glfw.GetWaylandDisplay()
    ww := glfw.GetWaylandWindow(window)
    fmt.printfln("Wayland display: %p\n", wd)
    fmt.printfln("Wayland window: %p\n", ww)
    if wd == nil || ww == nil {
        fmt.println("Wayland handles are null - might be running under XWayland")
    }
    fmt.println("got wayland display and window")

    /*
    x11d := glfw.GetX11Display()
    x11w := uintptr(glfw.GetX11Window(window))
    fmt.printf("X11 display: %p\n", x11d)
    fmt.printf("X11 window: %d\n", x11w)
    */
    fmt.println("setting up platform data")
    init.platform_data = {
        nwh = rawptr(ww),
        ndt = rawptr(wd),
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
    fw, fh := glfw.GetFramebufferSize(window)
    bgfx.reset(u32(fw), u32(fh), bgfx.RESET_VSYNC, .RGBA8)
    fmt.println("initialized bgfx")

	bgfx.set_debug(bgfx.DEBUG_TEXT);
    
    fmt.println("setting up view")
    main_view_id: bgfx.View_Id = 0
    bgfx.set_view_clear(main_view_id, bgfx.CLEAR_COLOR | bgfx.CLEAR_DEPTH, 0x303030FF, 1.0, 0)
    fmt.println("set up view")

    fmt.println("starting main loop")
    for !glfw.WindowShouldClose(window) {
        glfw.PollEvents()

        bgfx.set_view_rect(main_view_id, 0, 0, u16(w), u16(h))
        
        encoder := bgfx.encoder_begin(false);
        assert(encoder != nil, "bgfx encoder is nil!")
        bgfx.encoder_touch(encoder, main_view_id);
		bgfx.encoder_end(encoder);

		bgfx.dbg_text_clear(0, false);
		bgfx.dbg_text_printf(40, 13, 0x0f, "Hello from BGFX!");

        bgfx.frame(false)
    }
}
