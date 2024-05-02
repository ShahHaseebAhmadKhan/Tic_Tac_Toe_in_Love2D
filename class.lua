-- Helper function to include values from one table into another deeply.
-- This function ensures that nested tables are copied deeply.
local function include_helper(to, from, seen)
    -- If the source table is nil, return the target table as is.
    if from == nil then
        return to
    -- If the source value is not a table, return it as is.
    elseif type(from) ~= 'table' then
        return from
    -- If the source table has been seen before, return the corresponding target table.
    elseif seen[from] then
        return seen[from]
    end

    -- Mark the source table as seen in the table tracking seen tables.
    seen[from] = to
    -- Copy each key-value pair from the source table to the target table recursively.
    for k,v in pairs(from) do
        -- Recursively copy the key, as it might also be a table.
        k = include_helper({}, k, seen)
        -- If the target table does not already have the key, copy the value.
        if to[k] == nil then
            to[k] = include_helper({}, v, seen)
        end
    end
    return to
end

-- Function to deeply copy values from one table into another.
-- Keys in the source table that are already defined in the target table are omitted.
local function include(class, other)
    return include_helper(class, other, {})
end

-- Function to create a deep copy of a table.
local function clone(other)
    return setmetatable(include({}, other), getmetatable(other))
end

-- Function to create a new class with optional mixins.
local function new(class)
    -- Extract mixins from the class or set an empty table if not provided.
    class = class or {}  -- class can be nil
    local inc = class.__includes or {}
    -- If __includes is a single value, wrap it in a table.
    if getmetatable(inc) then inc = {inc} end

    -- Include each mixin into the class.
    for _, other in ipairs(inc) do
        -- If the mixin is given as a string, fetch it from the global environment.
        if type(other) == "string" then
            other = _G[other]
        end
        -- Include the mixin into the class.
        include(class, other)
    end

    -- Set up the class implementation.
    class.__index = class
    class.init    = class.init    or class[1] or function() end
    class.include = class.include or include
    class.clone   = class.clone   or clone

    -- Constructor call to create instances of the class.
    return setmetatable(class, {__call = function(c, ...)
        local o = setmetatable({}, c)
        o:init(...)
        return o
    end})
end

-- The module returns a table with new, include, and clone functions.
-- It also allows invoking the new function directly.
return setmetatable({new = new, include = include, clone = clone},
    {__call = function(_,...) return new(...) end})
