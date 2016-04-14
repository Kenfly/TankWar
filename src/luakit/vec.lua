module("luakit", package.seeall)


function vec2(_x, _y)
    if nil == _y then
        return {x = _x.x, y = _x.y}
    else
        return {x = _x, y = _y}
    end
end

function vec2_add(_vec2_1, _vec2_2)
    return vec2(_vec2_1.x + _vec2_2.x, _vec2_1.y + _vec2_2.y)
end

function vec2_add_vec2(_vec2_1, _vec2_2)
    _vec2_1.x = _vec2_1.x + _vec2_2.x
    _vec2_1.y = _vec2_1.y + _vec2_2.y
end

function size(_width, _height)
    if nil == _height then
        return {width = _width.width, height = _width.height}
    else
        return {width = _width, height = _height}
    end
end

function rect(_origin_x, _origin_y, _width, _height)
    if nil == _origin_y then
        return {origin = vec2(_origin_x.origin), size = size(_origin_x.size)}
    elseif nil == _width then
        return {origin = vec2(_origin_x), size = size(_origin_y)}
    else
        return {origin = vec2(_origin_x, _origin_y), size = size(_width, _height)}
    end
end

function rect_add_vec2(_rect, _vec2)
    vec2_add_vec2(_rect.origin, _vec2)
end

function rect_intersects(_rect1, _rect2)
    return not (
        _rect1.origin.x > _rect2.origin.x + _rect2.size.width or
        _rect1.origin.x + _rect1.size.width < _rect2.origin.x or
        _rect1.origin.y > _rect2.origin.y + _rect2.size.height or
        _rect1.origin.y + _rect2.size.height < _rect2.origin.y
    )
end

function vec2_add(_v1, _v2)
    return {x = _v1.x + _v2.x, y = _v1.y + _v2.y}
end

