module("luakit", package.seeall)

function is_class(_tbl)
    return _tbl and type(_tbl) == "table" and _tbl.cname_ ~= ""
end

function class(_classname, _super, _module)
    local evn = _module or _G
    local gtbl = evn[_classname]
    if gtbl and (not is_class(gtbl) or gtbl.cname_ ~= _classname) then
        return nil
    end

    local cls = gtbl or {}

    local super_type = type(_super)
    if super_type == "table" then
        --do nothing
    elseif super_type == "string" then
        _super = evn[_super]
    else
        _super = nil
    end

    if _super then
        setmetatable(cls, {__index = _super})
        cls.super_ = _super
    end
    cls.ctor = function(self, ...)
        if cls.super_ and cls.super_.ctor and type(cls.super_.ctor) == "function" then
            cls.super_.ctor(self, ...)
        end
    end
    cls.cname_ = _classname
    cls.__index = cls
    cls.new = function(...)
        local inst = {}
        setmetatable(inst, cls)
        inst:ctor(...)
        return inst
    end
    evn[_classname] = cls
    return cls
end

