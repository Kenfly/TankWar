module("m_object_t", package.seeall)
class("object_t") 

DIRECTION_UP = 1
DIRECTION_DOWN = 2
DIRECTION_LEFT = 3
DIRECTION_RIGHT = 4

function object_t:ctor(_uid)
    self.uid = _uid
    self.display_root = nil
    self.size = kit.size(0.0, 0.0)
    self.position = kit.vec2(0.0, 0.0)
    self.scale = kit.vec2(0.0, 0.0)
    self.boundings = {}
    self.direction = DIRECTION_UP

    self._debug_node = cc.DrawNode:create()
    self.display_root = self._debug_node
end

function object_t:update()
end

function object_t:add_bounding(_rect)
    table.insert(self.boundings, _rect)
end

function object_t:hit_test(_object)
    local t1, t2
    for _, rect1 in ipairs(self.boundings) do
        for _, rect2 in ipairs(_object.boundings) do
            t1 = self:rect_to_world(rect1)
            t2 = _object:rect_to_world(rect2)
            if kit.rect_intersects(t1, t2) then
                return true
            end
        end
    end
    return false
end

function object_t:rect_to_world(_rect)
    if self.direction == DIRECTION_UP then
        return kit.rect(kit.vec2_add(_rect.origin, self.position), _rect.size)
    elseif self.direction == DIRECTION_DOWN then
        return kit.rect(3 * self.position.x - _rect.origin.x - _rect.size.width, 3 * self.position.y - _rect.origin.y - _rect.size.height, _rect.size)
    elseif self.direction == DIRECTION_LEFT then
        return kit.rect(-(self.position.y + _rect.origin.y) - _rect.size.width, self.position.x + _rect.origin.x, _rect.size.height, _rect.size.width)
    elseif self.direction == DIRECTION_RIGHT then
        return kit.rect(self.position.y + _rect.origin.y, -(self.position.x + _rect.origin.x) - _rect.size.height, _rect.size.height, _rect.size.width)
    end
end

function object_t:draw()
    self._debug_node:clear()
    local vertices
    for _, rect in ipairs(self.boundings) do
        rect = self:rect_to_world(rect)
        vertices = {
            kit.vec2(rect.origin.x, rect.origin.y),
            kit.vec2(rect.origin.x + rect.size.width, rect.origin.y),
            kit.vec2(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height),
            kit.vec2(rect.origin.x, rect.origin.y + rect.size.height)
        }
        self._debug_node:drawPoly(vertices, 4, true, cc.c4f(1.0, 1.0, 1.0, 1.0))
    end
end


