pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
--_init()


function _init()

 ts=0
 
 ship_weapons={
  { --basic projectile
   color=10,
   dmg=8,
   eng=8,
   len=3,
   spd=4,
   rate=6,
  },  
  { --double dmg projectile
   color=9,
   dmg=16,
   eng=16,
   len=3,
   spd=4,
   rate=6
  },
  { --laser blue
   color=12,
   dmg=64,
   eng=64,
   len=96,
   spd=2,
   rate=60,
  }
 }
 
 ship_bases={
  { --base 1 - basic - default
   sprite=0, 
   width=5,
   shields=1024,
   health=1024,
   upgraded=false,
   weapons={
    {w_type=ship_weapons[1], x=7, y=-1, last_shot_ts=0},
    {w_type=nil, x=4, y=2, last_shot_ts=0},
    {w_type=nil, x=11,y=2, last_shot_ts=0}, 
   },
  },
  { --base 2 - laser - default
   sprite=1, 
   width=5,
   shields=1024,
   health=1024,
   upgraded=false,
   weapons={
    {w_type=ship_weapons[1], x=7, y=-1, last_shot_ts=0},
    {w_type=ship_weapons[3], x=1, y=-1, last_shot_ts=0},
    {w_type=ship_weapons[3],x=14, y=-1, last_shot_ts=0}, 
   },
  },
 }
 
 ship_engines={
  --engine 1 - basic
  {
   sprite=16,
   width=6,
   battery_cap=1024,
  },
  {
   sprite=17,
   width=8,
   battery_cap=1024,
  },
  {
   sprite=18,
   width=8,
   battery_cap=1024,
  },
  {
   sprite=19,
   width=8,
   battery_cap=1024,
  },
 }
 
 ship={
  x=127/2,
  y=110,
  shots={},
  base=ship_bases[1],
  engine=ship_engines[1],
 }
 enemys={} 
end



-->8
--_update()

function _update60()
 ts+=1
 update_shots(ship)
 if btn(5) then
  shoot(ship)
 end
 if btn(0) and btn(2) then
  ship.x-=1
  ship.y-=1
 elseif btn(1) and btn(2) then
  ship.x+=1
  ship.y-=1
 elseif btn(1) and btn(3) then
  ship.x+=1
  ship.y+=1
 elseif btn(0) and btn(3) then
  ship.x-=1
  ship.y+=1
 elseif btn(0) then -- links
  ship.x-=1 
 elseif btn(1) then --rechts 
  ship.x+=1
 elseif btn(2) then --oben
  ship.y-=1
 elseif btn(3) then --links
  ship.y+=1
 end
 ship.x=mid(0,ship.x, 127-16)
 ship.y=mid(0,ship.y, 127-16)
end


function shoot()
 for weapon in all(ship.base.weapons) do
  if weapon.w_type != nil then
   if (weapon.last_shot_ts+weapon.w_type.rate<ts) then
    weapon.last_shot_ts=ts
   	add(
   	 ship.shots,
   	 { 
   	  x=ship.x+weapon.x, --x offset
   	  y=ship.y+weapon.y, --y offset
   	  c=weapon.w_type.color,
   	  dmg=weapon.w_type.dmg,
   	  len=weapon.w_type.len,
   	  spd=weapon.w_type.spd,
   	 }
   	)
   end
  end
 end  
end


function update_shots(sh)
 for i=#sh.shots,1,-1 do
  sh.shots[i].y-=sh.shots[i].spd
  if (sh.shots[i].y<0) then
   del(sh.shots, sh.shots[i])
  end
 end
end
-->8
--draw()

function _draw()
 cls()
 map(0,0,0,0,16,16,0)
 draw_ship(ship)
 draw_shots(ship.shots)
end1


function draw_ships()
 for s in all(ships) do
  draw_ship(s)
 end
end


function draw_shots(s)
 for i=#s,1,-1 do
  local _shot=s[i]
  local _x = _shot.x
  local _y = _shot.y
  local _color = _shot.c
  local _len = _shot.len
  line(_x,_y,_x,_y-_len,_color)
 end
end

function draw_ship(s)
 spr(s.base.sprite, --left half
     s.x,
     s.y)
 spr(s.base.sprite, --right half
     s.x+8,
     s.y,
     1,
     1,
     true,
     false)
 if (ts%12) > 6 then
  spr(s.engine.sprite, --left half
      s.x,
      s.y+8)
  spr(s.engine.sprite, --right half
      s.x+8,
      s.y+8,
      1,
      1,
      true,
      false)
 else
  spr(s.engine.sprite+16, --left half
      s.x,
      s.y+8)
  spr(s.engine.sprite+16, --right half
      s.x+8,
      s.y+8,
      1,
      1,
      true,
      false)
 end
end
__gfx__
00000005505000060000000700000006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000005c5c5000610000007100000061000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000500655c500066080800670bbb0066000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000590665c50006605850066b555b066000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000595665c5005660585056605b50566000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000565555c566555056565550b6b6555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000565cc5c5ccccc056565cc056565cc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00055509555666090555550905555509000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00555506555555665555509a05550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0056660b5566666d0000009a95955555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00555bb005ddddd60000009aa9599999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000500005666660000009a9a955555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000009000566650000009a09a99999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000009a0000565900000009009aaaaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000009a0000059a0000000000099999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000009000000090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00555506555555665555509a05550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0056660b5566666d0000009a95955555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00555bb005ddddd60000009aa9599999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000500005666660000009a9a955555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000009000566650000009a09a99999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000009a000056590000009a09aaaaaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000009000005900000009a009aaaaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000900099999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066660000077000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066665600ccccc30
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006566565603c33330
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006666656633c33333
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006666666633ccc33c
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006566666603cc3cc0
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000065666600cccccc0
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066660000077000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000070700000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700070000007000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007070707000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007007070070000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700000700000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007070000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700
__label__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000005050000660000505000000000005500000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000005c500061160005c500000000005cc50000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000005c500066660005c5000005050065560050500000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000005c500066660005c5000005950066660059500000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000005c500566665005c5000005950566665059500000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000005c566555555665c5000005656555555656500000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000005c5cccccccccc5c50000056565cccc5656500000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000005556660990666555000005555509905555500000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000005555556666555555000055555506605555550000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000005566666dd666665500005666660bb06666650000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000005ddddd66ddddd50000055555bb00bb555550000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000056666666666500000000000500005000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000005666556665000000000000009900000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000056599565000000000000009aa90000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000059aa950000000000000009aa90000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000990000000000000000009900000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

__map__
0007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000eedcdcee0000df00000000ee000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dcdcdccedcdcdcdcdcdcdc0000cf000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
efdcdcdcdceedcdcdcdceedcef00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00eedcdcdcdceedcdcdcdcdcdc00ee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00dceedcdcdcdceedceedceeee00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00efdcdcdcdcefdcdcdcefefdcefdcdc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00eedcdcdcdcdcefdcdcdcdcdcefdcdc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000efef00efdc0000eeef000000dcdc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000ef000000ef00ef0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00ef00eeef0000ee00000000ff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000ef000000ef0000ef00ff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000ff00000000ef000000ef00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00ee00ef00000000000000000000ef0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
