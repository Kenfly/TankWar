cc.FileUtils:getInstance():addSearchPath("../src")
cc.FileUtils:getInstance():addSearchPath("../res")

-- CC_USE_DEPRECATED_API = true
local old_require = require
function require_ex(_mname)
    package.loaded[_mname] =nil
    return old_require(_mname)
end
--require = require_ex

if not g_init_path then
     package.path = package.path..";".."object/?.lua"
    g_init_path = true
end

-- you should add your lua file here
require("cocos.init")
require("luakit.init")
require("config")
require("object_t")

-- cclog
cclog = function(...)
    print(string.format(...))
    local file = io.open("log.txt", "w+")
    file:write(string.format(...))
    file:close()
end

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("----------------------------------------")
end


local function initGLView()
    local director = cc.Director:getInstance()
    local glView = director:getOpenGLView()
    if nil == glView then
        glView = cc.GLViewImpl:create("TankWar")
        director:setOpenGLView(glView)
    end

    director:setOpenGLView(glView)

    glView:setDesignResolutionSize(global_config.designe_width, global_config.designe_height, cc.ResolutionPolicy.NO_BORDER)
    glView:setFrameSize(global_config.window_width, global_config.window_height)

    --turn on display FPS
    director:setDisplayStats(true)

    --set FPS. the default value is 1.0/60 if you don't call this
    director:setAnimationInterval(1.0 / 60)
end

g_frame = 0
local function mainloop()
    g_frame = g_frame + 1

    -- add your update here
end

local function main()
    cclog("#####################start:" .. os.date() .. "\n")

    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    initGLView()
    ---------------

    -- run
    local sceneGame = cc.Scene:create()
    cc.Director:getInstance():runWithScene(sceneGame)

    cc.Director:getInstance():getScheduler():scheduleScriptFunc(mainloop, 0, false)

    local obj1 = object_t.new(1)
    obj1.position.x = 400
    obj1.position.y = 400
    obj1:add_bounding(kit.rect(-100, -100, 200, 200))
    sceneGame:addChild(obj1.display_root)
    obj1:draw()

    local obj2 = object_t.new(2)
    obj2.position.x = 400
    obj2.position.y = 400
    obj2:add_bounding(kit.rect(-200, -200, 400, 400))
    sceneGame:addChild(obj2.display_root)
    obj2:draw()

    print("hit test:::", obj1:hit_test(obj2))
end

xpcall(main, __G__TRACKBACK__)

