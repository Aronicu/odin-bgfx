package hello_world

import "core:fmt"
import str "core:strings"

import sdl "vendor:sdl3"

import bg "../../"

running := true

when ODIN_OS == .Windows {
    init_platform_data :: proc(window: ^sdl.Window, plat_data: ^bg.Platform_Data) {
	    props := sdl.GetWindowProperties(window)
        hwnd := sdl.GetPointerProperty(props, sdl.PROP_WINDOW_WIN32_HWND_POINTER,nil) 
        plat_data.nwh = rawptr(hwnd)
    }
} else when ODIN_OS == .Linux {
    // NOTE(elaeja): even on sway it wants to use x11 for some reason...
    init_platform_data :: proc(window: ^sdl.Window, plat_data: ^bg.Platform_Data) {
        props := sdl.GetWindowProperties(window)
        assert(props != 0)
        
        x11_display := rawptr(sdl.GetPointerProperty(props, sdl.PROP_WINDOW_X11_DISPLAY_POINTER, nil))
        x11_window := rawptr(uintptr(sdl.GetNumberProperty(props, sdl.PROP_WINDOW_X11_WINDOW_NUMBER, 0)))
        
        if x11_display == nil || x11_window == nil {
            wl_display := sdl.GetPointerProperty(props, sdl.PROP_WINDOW_WAYLAND_DISPLAY_POINTER,nil)
            wl_window := sdl.GetPointerProperty(props, sdl.PROP_WINDOW_WAYLAND_EGL_WINDOW_POINTER, nil)
         
            assert(wl_display != nil) 
            assert(wl_window != nil)
        
            plat_data.ndt = rawptr(wl_display)
            plat_data.nwh = rawptr(wl_window)
            plat_data.type = .Wayland
        } else {
            plat_data.ndt = x11_display
            plat_data.nwh = x11_window
        }
    }
}

poll_events :: proc() {
    event: sdl.Event
    for sdl.PollEvent(&event) {
        #partial switch event.type {
            case .QUIT:
            running = false
            case .KEY_DOWN:
            if event.key.key == sdl.K_ESCAPE {
                running = false 
            }
        }
    }
}

main :: proc() {
    ok := sdl.Init({.VIDEO, .EVENTS})
    assert(ok, str.clone_from_cstring(sdl.GetError()))
    defer sdl.Quit()
    
    window := sdl.CreateWindow("Hello from BGFX!", 800, 600, {.RESIZABLE})
    assert(window != nil, str.clone_from_cstring(sdl.GetError()))
    defer sdl.DestroyWindow(window)

    fmt.println("initializing bgfx ctor")
    init: bg.Init
    bg.init_ctor(&init)

    init.type = .Vulkan
    
    fmt.println("initializing platform data")
    init_platform_data(window, &init.platform_data)
    fmt.printf("Platform type: %v\n", init.platform_data.type)
    fmt.printf("ndt: %p\n", init.platform_data.ndt)
    fmt.printf("nwh: %p\n", init.platform_data.nwh)
    
    fmt.println("initializing resolution")
    w, h: i32 
	sdl.GetWindowSize(window, &w, &h) 
    init.resolution = {
        width = u32(w),
        height = u32(h),
        reset = bg.RESET_VSYNC,
        format = .RGBA8,
    }

    fmt.println("initializing bgfx")
    if !bg.init(&init) { panic("bgfx failed to init!") }
    defer bg.shutdown()

    fmt.println("calling reset")
    pw, ph: i32 
    sdl.GetWindowSizeInPixels(window, &pw, &ph)
    bg.reset(u32(pw), u32(ph), bg.RESET_VSYNC, .RGBA8)

    fmt.println("setting debug")
    bg.set_debug(bg.DEBUG_TEXT)
    main_view_id: bg.View_Id = 0

    fmt.println("setting view clear")
    bg.set_view_clear(main_view_id, bg.CLEAR_COLOR | bg.CLEAR_DEPTH, 0xCCA0A0FF, 1.0, 0)

    fmt.println("starting main loop") 
    fmt.printfln("using, %s, as the renderer backend", bg.get_renderer_name(bg.get_renderer_type())) 

    for running {
        poll_events()
        bg.set_view_rect(main_view_id, 0, 0, u16(pw), u16(ph))
        encoder := bg.encoder_begin(false);
        // sanity check
        assert(encoder != nil, "bgfx encoder is nil!")
        bg.encoder_touch(encoder, main_view_id);
		bg.encoder_end(encoder);

		bg.dbg_text_clear(0, false);
		bg.dbg_text_printf(42, 18, 0x0f, "Hello from BGFX!");
        
        // Advance to next frame. Rendering thread will be kicked to
		// process submitted rendering primitives.
        bg.frame(false)
    }
}
