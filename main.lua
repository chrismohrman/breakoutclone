-- main.lua
love.update = function(dt)
  if state.game_over or state.paused or state.stage_cleared then
    return
  end

  -- Switch to true if we have bricks left
  local have_bricks = false

  local index = 1
  while index <= #entities do
    local entity = entities[index]
    if entity.type == 'brick' then have_bricks = true end
    if entity.update then entity:update(dt) end
    -- When an entity has no health (brick has been hit enough times
    -- then we remove it from the list of entities. Don't increment
    -- the index number if doing that though because we have shrunk
    -- the table and made all the items shift down by 1 in the index.
    if entity.health and entity.health < 1 then
      table.remove(entities, index)
      entity.fixture:destroy()
    else
      index = index + 1
    end
  end

  -- Flag the stage cleared if there are no more bricks
  state.stage_cleared = not have_bricks
  world:update(dt)
end