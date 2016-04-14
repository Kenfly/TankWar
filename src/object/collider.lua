class("collider_t")
-- 只作四边形检测就够了

function collider_t:ctor()
    self.quards = {}
end

function collider_t:add_quard(_quard)
    table.insert(self.quards, _quard)
end

function collider_t:is_contain(_colllider)
end

