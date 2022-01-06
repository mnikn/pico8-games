pico-8 cartridge // http://www.pico-8.com
version 34
__lua__
--main

function _init()
	sprs={
		player=1,
		dan=2,
		cestle=41,
		bed=49,
		house=54,
		smith=55,
		tarvern=56,
                tarvernkeepper=6,
		house2=57,
                fan=4,
                smithman=5,
                wuyan=52,
		stree=59
	}
	p={
		pos=vec2(0,0),
		money=0,
                has_map=false,
                has_wuyan=false,
                items={},
		dialog={},
                tarvern_i=1,
		dialog_o=nil,
		dialog_oc=nil,
		day=6,
		switchcnt=0,
		flag={
			hastalk=false,
			know_plan=false
		}
	}
	flg={
		wall=0
	}
	sound={
		stuck=0
	}
	grid={
		dan={
			sprite=sprs.dan,
			pos=vec2(7,3),
			show=true
		},
		cestle={
			sprite=sprs.cestle,
			pos=vec2(7,16),
			show=true
		},
		house={
			sprite=sprs.house,
			pos=vec2(9,27),
			show=true
		},
		smith={
			sprite=sprs.smith,
			pos=vec2(12,19),
			show=false
		},
		smithman={
			sprite=sprs.smithman,
			pos=vec2(55,6),
			show=true
		},
		stree={
			sprite=sprs.stree,
			pos=vec2(13,30),
			show=false
		},
                wuyan={
                   sprite=sprs.wuyan,
                   pos=vec2(8,43),
                   show=true
                },
		tarvern={
			sprite=sprs.tarvern,
			pos=vec2(2,28),
			show=false
		},
		tarvernkeepper={
			sprite=sprs.tarvernkeepper,
			pos=vec2(24,21),
			show=true
		},
		house2={
			sprite=sprs.house2,
			pos=vec2(6,23),
			show=false
		},
		bed={
			sprite=sprs.bed,
			pos=vec2(23,2),
			show=true			
		},
                fan={
                   sprite=sprs.fan,
                   pos=vec2(39,6),
                   show=true
                }
	}
	camera_pos=vec2(0,0)
	start_game()
	timer=0
	bltimer=0
        bltimer_text=''
	
	dialogues={
		dan_1={{
			p='yan prince dan',
			c='jing ke! i am calling you because i have a difficulttask, which only you can do it.'
		},{
			p='jing ke',
			c='is it related to yan?'
		},{
			p='yan prince dan',
			c='...that\'s right, we have received intelligence,qin is ready to launch a war against yan.'
		},{
			p='yan prince dan',
			c='with our army, even if we ask other countries for help, we cannot defeat qin.'
		},{
			p='yan prince dan',
			c='if a war is launched, yan will only end in subjugation.'
		},{
			p='yan prince dan',
			c='therefore, we want to assassinate the king of qin yingzheng.'
		},{
			p='yan prince dan',
			c='once king qin dies, there will be civil strife in qin for a time without a king.'
		},{
			p='yan prince dan',
			c='at this time, we can defeat qin with other weak countries.'
		},{
			p='yan prince dan',
			c='i want to entrust this task to you, but the person who performs this task may die.'
		},{
			p='yan prince dan',
			c='would you like to accept this task?'
		},{
			p='jing ke',
			c='king qin\'s greed is endless, leading to the destruction of countless countries.'
		},{
			p='jing ke',
			c='if king qin can be prevented, my life can be sacrificed.'
		},{
			p='yan prince dan',
			c='wonderful! i will give you some money and arrange a residence.'
		},{
			p='yan prince dan',
			c='tomorrow we will discuss the plan to assassinate king qin. today you can go to your residence for rest.'
		}},
		dan_2={{
			p='yan prince dan',
			c='please go to your residence for rest, we will discuss the plan tomorrow.'
		}},
		dan_3={{
			p='yan prince dan',
			c='here you are, let\'s continue the topic of assassinating king qin.'
		},{
			p='yan prince dan',
			c='king qin is very vigilant, and it is impossible to approach him without a valid reason.'
		},{
			p='yan prince dan',
			c='fan yuqi, the general of the qin state, participated in the rebellion and defected to our yan state.'
		},{
			p='yan prince dan',
			c='if you use him as bait, you will definitely get a chance to get close to king qin.'
		},{
			p='yan prince dan',
			c='you can discuss with fan yuqi. fan yuqi hates king qin, he will agree our plan.'
		},{
			p='yan prince dan',
			c='also, you also need to find a weapon that can assassinate king qin.'
		},{
			p='yan prince dan',
			c='king qin\'s city is not allowed to bring weapons, so you need to find a weapon with good concealment.'
		},{
			p='yan prince dan',
			c='you can go to the blacksmith\'s shop.'
		},{
			p='yan prince dan',
			c='and if some can come with you assassinate king qin will be better.'
		},{
			p='yan prince dan',
			c='rumor spread there is a man named qin wuyang on the street with extraordinary courage.'
		},{
			p='yan prince dan',
			c='maybe he can be your helper.'
		},{
			p='yan prince dan',
			c='but i don\'t know where this person is, you can go to the tavern to find out.'
		},{
			p='yan prince dan',
			c='just prepare for the assassination of king qin, if you have any needs, you can talk to me.'
		}},
		dan_4={{
			p='yan prince dan',
			c='just prepare for the assassination of king qin, if you have any needs, you can talk to me.'
		}},
		dan_5={{
			p='jing ke',
			c='i heard you have a map of yan.'
		},{
			p='yan prince dan',
			c='...right, what do you want to do?'
		},{
			p='jign ke',
			c='king qin is suspicious by nature and cannot gain his trust with our plan.'
		},{
			p='jing ke',
			c='if i can offer a map of yan and hide dagger in the map, then the success rate of assassinating king qin will be greatly improved.'
		},{
			p='yan prince dan',
			c='however, if the map of yan is presented, it will be easier for qin to attack yan. i cannot take this risk.'
		},{
			p='jing ke',
			c='if the assassination of king qin fails, then the kingdom of yan will eventually perish.'
		},{
			p='yan prince dan',
			c='...well i believe you, i will give you the map, please kill king qin.'
		},{
			p='jing ke',
			c='thanks, i will definitely complete the task!'
		}},
  fan_1={{
                      p='jing ke',
                      c='general fan yuqi,i need your help.'
                }, {
                      p='fan yuqi',
                      c='my friend, just say what you want me to do.'
                }, {
                      p='jing ke',
                      c='king qin intends to attack the yan recently. if we confront it head-on, we will definitely fail.'
                   }, {
                      p='jing ke',
                      c='so we want to assassinate king qin and create chaos in qin, that qin cannot escape to attack yan.'
                      }, {
                      p='jing ke',
                      c='the problem is that due to king qin is suspicious, we needs to find a good reason to approach him.'
                         }, {
                      p='jing ke',
                      c='you have a grudge with king qin, if you are used as bait, then king qin will be interested.'
                            }, {
                      p='fan yuqi',
                      c='if i can get revenge, i will sacrifice myself.'
                               }, {
                      p='fan yuqi',
                      c='so what\'s your plan?'
                                  }, {
                      p='',
                      c='what you want to do?',
                      o={'expose location', 'commit suicide'}
                }},
                fan_2={{
                      p='jing ke',
                      c='i will tell king qin about your position, i believe this will convince king qin.'
                       }, {
                      p='fan yuqi',
                      c='king qin is very cunning, i\'m not sure if he will believe it.'
                          }, {
                      p='fan yuqi',
                      c='but i don\'t have a better solution, so i will do it.'
                             }, {
                      p='jing ke',
                      c='thanks! i will fulfill my mission.'
                }},
                fan_3={{
                      p='jing ke',
                      c='king qin is very cunning, he will not believe anyone except for offering your head.'
                       }, {
                      p='fan yuqi',
                      c='as i said, if i can get revenge, my own life is insignificant.'
                          }, {
                      p='fan yuqi',
                      c='give my head to king qin! jing ke, please kill king qin!'
                             }, {
                      p='jing ke',
                      c='i will not forget your sacrifice, and i will fulfill my mission without disgrace!'
                }},
  smith={{
  	p='jing ke',
  	c='are there any daggers for sale here?'
  },{
  	p='smith',
  	c='we have a poisoned dagger here, as long as it cuts through the body, it will undoubtedly die.'
  },{
  	p='smith',
  	c='but the price is very high.'
  },{
  	p='',
  	c='buy?',
  	o={'buy(700)','cancel'}
  }},
  tarvern_buy={{
  	p='',
  	c='',
  	o={'buy information(100)','cancle'}
  }},
  tarvern_1={{
  	p='tavernkeeper',
  	c='i heard that general fan yuqi hates king qin very much, and he can accept any means for revenge.'
  }},
  tarvern_2={{
  	p='tavernkeeper',
  	c='it is rumored that there is a map of  yan on the prince dan.'
  },{
  	p='tavernkeeper',
  	c='if someone get this map, attacking yan will be pretty easy.'
  }},
  tarvern_3={{
  	p='tavernkeeper',
  	c='i heard that qin wuyang is now on the street and wants to fight with strong man.'
  }},
  wuyan_1={{
  	p='jing ke',
  	c='excuse me, are you qin wuyang?'
  },{
  	p='qing wuyang',
  	c='exactly! see you are pretty strong, do you want to fight with me?'
  },{
  	p='jing ke',
  	c='no, i want to invite you to assassinate king qin together'
  },{
  	p='qing wuyang',
  	c='the assassination of king qin is not trivial, if you can defeat me, i will join you.'
  },{
  	p='jing ke',
  	c='well, let\'s have a fight!'
  },{
  	p='',
  	c='qin wuyang try to hit your face with a right fist!',
  	o={'dodge','head on'}
  }},
  wuyan_2={{
  	p='',
  	c='you avoid qin wuyang\'s right fist, but trip to the ground by qin wuyang\'s feet'
  },{
  	p='qing wuyang',
  	c='your are not strong enough! i won\'t join with people who are not strong.'
  }},
  wuayn_3={{
  	p='',
  	c='regardless of the pain, you hit your fist while knocking qin wuyang to the ground with one punch.'
  },{
  	p='qing wuyang',
  	c='i have never met someone who can confront me head-on, i am willing to join you.'
  }},
  wan_1={{
  	p='jing ke',
  	c='king qin your grace! i has something to offer to you today.'
  },{
  	p='king qin',
  	c='oh?what\'s that?'
  }},
  wan_2={{
  	p='qing ke',
  	c='i heard that you wants to attack yan. i know prince dan very well, so i can get information from him.'
  },{
  	p='king qin',
  	c='hehe, then why didn\'t you bring anything here?'
  },{
  	p='king qin',
  	c='somebody come here! this person is a spy, kill him!'
  }},
  wan_3={{
  	p='qing ke',
  	c='i heard that fan yuqi has a grudge against you, i can ask him out and let you catch fan yuqi.'
  },{
 		p='king qin',
 		c='haha, fan yuqi doesn\'t make friends with the villain.'
  },{
  	p='king qin',
  	c='if you can make an appointment with fan yuqi, then you are lying to me.'
  },{
  	p='king qin',
  	c='somebody come here! this person is a spy, kill him!'
  }},
  wan_4={{
  	p='jing ke',
  	c='i heard that fan yuqi has a grudge against you, i have fan yuqi\'s head here.'
  },{
  	p='king qin',
  	c='oh? this is true. is there anything else besides this?'
  }},
  wan_5={{
  	p='jing ke',
  	c='i heard that you wantto attack yan, and i have a map of yan here.'
  },{
  	p='king qin',
  	c='what! ? get it quickly!'
  },{
  	p='',
  	c='jing ke slowly unfolded the map, and king qin\'s eyes gradually became greedy as the map unfolded.'
  }},
  wan_6={{
  	p='',
  	c='when the map was rolled out to the end, the dagger was exposed.'
  },{
  	p='',
  	c='king qin was shocked. jing ke grabbed king qin\'s hand and wanted to stab him.'
  },{
  	p='',
  	c='unexpectedly, king qin broke free, and then jing ke was killed by the soldiers.'
  }},
  wan_7={{
  	p='',
  	c='when the map was rolled out to the end, the dagger was exposed.'
  },{
  	p='',
  	c='king qin was taken aback. qin wuyang caught king qin\'s hand. jing ke took the dagger and stab qin king.'
  },{
  	p='',
  	c='but the wound was too shallow and king qin broke free.'
  },{
  	p='',
  	c='then jing ke and qin wuyang were killed by the soldiers.'
  }},
  wan_8={{
  	p='',
  	c='when the map was rolled out to the end, the dagger was exposed.'
  },{
  	p='',
  	c='king qin was shocked. qin wuyang caught king qin\'s hand. jing ke took the dagger and stab qin king.'
  },{
  	p='',
  	c='the poison on the dagger penetrated into king qin\'s body, and king qin finally died of poison.'
  }},
		sleep={{
			p='',
			c='slepp now?(pass today)',
			o={'sleep','cancel'}
		}}
	}
end

function _update()
   if (#p.dialog>0 or btn(❎) or bltimer > 0)
   then
      return
   end
   move_player()
   camera_pos=update_camera(p.pos)
end

function _draw()
	cls()
	bltimer=max(bltimer-1,0)
	
	if (p.switchcnt==5)
	then
		p.switchcnt=0
		bltimer=40
		bltimer_text='next day'
		p.day-=1
		p.pos=vec2(23,3)
	end
	
	if (bltimer>0)
	then
		print(bltimer_text,camera_pos.x+48,camera_pos.y+52,7)
		return
	end
	
	draw_map()
	draw_player()
	for i,v in pairs(grid) do
		draw_obj(v)
	end
	
	if (#p.dialog>0)
	then
		show_dialogue()
		if (btnp(❎))
		then
			local last=p.dialog[1]
			del(p.dialog,p.dialog[1])
			timer=10
			if (last.c==dialogues.dan_1[#dialogues.dan_1].c)
			then
                           p.money=1000
                           p.flag.hastalk=true
			elseif (last.c==dialogues.dan_3[#dialogues.dan_3].c)
			then
                           p.flag.know_plan=true
                           grid.house2.show=true
                           grid.tarvern.show=true
                           grid.smith.show=true
			elseif (p.dialog_oc=='sleep')
			then
                           p.day-=1
                           bltimer=40
                           bltimer_text='next day'
                           return
			elseif (last.c==dialogues.dan_5[#dialogues.dan_5].c)
			then
                           add(p.items, 'map of yan')
                           p.has_map=true
                           p.pos=vec2(6,24)
                           return
			elseif (p.dialog_oc=='expose location')
			then
                           p.dialog=clone(dialogues.fan_2)
                           p.dialog_oc=nil
                           return
			elseif (p.dialog_oc=='commit suicide')
			then
                           p.dialog=clone(dialogues.fan_3)
                           p.dialog_oc=nil
                           return
			elseif (last.c==dialogues.fan_2[#dialogues.fan_2].c)
			then
                           grid.fan.show=false
                           grid.house2.show=false
                           bltimer=40
                           bltimer_text='then fan yuqi went to the hiding place.'
                           p.pos=vec2(6,24)
                           return
			elseif (last.c==dialogues.fan_3[#dialogues.fan_3].c)
			then
                           grid.fan.show=false
                           grid.house2.show=false
                           bltimer=40
                           bltimer_text='then fan yuqi commit suicide, jing ke get his head.'
                           add(p.items, 'fan yuqi\'s head')
                           p.pos=vec2(6,24)
                           return
			elseif (p.dialog_oc=='buy(700)')
			then
                           if(p.money<700)
                           then
                              p.dialog={{
                                    p='smith',
                                    c='you don\'t have enough money!'
                              }}
                              return
                           end
                           bltimer=40
                           p.money-=700
                           bltimer_text='you get a dagger.'
                           add(p.items, 'dagger')
                           grid.smith.show=false
                           p.pos=vec2(grid.smith.pos.x,grid.smith.pos.y+1)
                           return
                        elseif (p.dialog_oc=='buy information(100)')
                        then
                           if(p.money<100)
                           then
                              p.dialog={{
                                    p='tavernkeeper',
                                    c='you don\'t have enough money!'
                              }}
                              return
                           end
                           if(p.tarvern_i>3)
                           then
                              p.dialog={{
                                    p='tavernkeeper',
                                    c='I have no information.'
                              }}
                              return
                           end
                           p.dialog=clone(dialogues['tarvern_'..p.tarvern_i])
                           p.tarvern_i+=1
                           p.money-=100
                        elseif (p.dialog_oc=='dodge')
                        then
                           p.dialog=clone(dialogues.wuyan_1)
                        elseif (p.dialog_oc=='head on')
                        then
                           p.dialog=clone(dialogues.wuyan_2)
                           p.has_wuyan=true
                        end
		end
		return
	end
	timer=max(timer-1,0)
	
	if (btn(❎) and timer==0)
	then
		show_inventory()
	end
end

function start_game()
	p.pos=vec2(7,10)
end

function move_player()
   local pos=vec2(p.pos.x,p.pos.y)
   
   if (btnp(⬅️)) pos.x-=1
   if (btnp(➡️)) pos.x+=1
   if (btnp(⬆️)) pos.y-=1
   if (btnp(⬇️)) pos.y+=1
	
   pos=vec2(max(0,pos.x),max(0,pos.y))
   
			--dan   
   if (vec2_eq(pos,vec2(7,16)) and p.flag.hastalk)
   then
      if (btnp(⬆️))
      then
      	if (p.flag.know_plan) p.switchcnt+=1
       pos=vec2(7,15)
      end
      if (btnp(⬇️))
      then
      	if (p.flag.know_plan) p.switchcnt+=1
       pos=vec2(7,17)
      end
   end
   --house1	
  	if (vec2_eq(pos,vec2(9,27)))
   then
   	if (p.flag.know_plan) p.switchcnt+=1
   	pos=vec2(18,8)
   end
   if (vec2_eq(pos,vec2(16,8)))
   then
      if (p.flag.know_plan) p.switchcnt+=1
      pos=vec2(9,28)
      end

   
   if (vec2_eq(pos,grid.house2.pos) and grid.house2.show)
   then
      if (p.flag.know_plan) p.switchcnt+=1
      pos=vec2(39,13)
      end
   if (vec2_eq(pos,vec2(39,14)))
   then
      if (p.flag.know_plan) p.switchcnt+=1
      pos=vec2(6,24)
      end

   if (vec2_eq(pos,grid.smith.pos) and grid.smith.show)
   then
      p.switchcnt+=1
      pos=vec2(55,13)
      end
   if (vec2_eq(pos,vec2(55,14)))
   then
      p.switchcnt+=1
      pos=vec2(grid.smith.pos.x,grid.smith.pos.y+1)
   end

   if (vec2_eq(pos,grid.tarvern.pos) and grid.tarvern.show)
   then
      p.switchcnt+=1
      pos=vec2(24,30)
      end
   if (vec2_eq(pos,vec2(24,31)))
   then
      p.switchcnt+=1
      pos=vec2(grid.tarvern.pos.x,grid.tarvern.pos.y+1)
   end
   
   local has_action=interact(pos)
   if (has_action) return
   
   if (can_move(pos))
   then
      p.pos=pos
   end
end

function can_move(pos)
	local tile=mget(pos.x,pos.y)
	local notwall=not fget(tile,flg.wall)
	for i,v in pairs(grid) do
		if (vec2_eq(v.pos,pos) and v.show) return false
	end
	return notwall
end

function interact(pos)
	local has_action=false
	for i,v in pairs(grid) do
		if (vec2_eq(v.pos,pos)) then
			has_action=true
			if (i=='dan')
			then
				if (not p.flag.hastalk)
				then
					p.dialog=clone(dialogues.dan_1)
				elseif (p.day==6)
				then
					p.dialog=clone(dialogues.dan_2)
					return true
				end
				
				if (p.flag.hastalk and not p.flag.know_plan)
				then
					p.dialog=clone(dialogues.dan_3)
				end
                                if (p.tarvern_i>3 and not p.has_map)
                                then
                                   p.dialog=clone(dialogues.dan_5)
                                end
				if (p.flag.know_plan)
				then
					p.dialog=clone(dialogues.dan_4)
				end

                                
			end
			
			if (i=='bed')
			then
                           p.dialog=clone(dialogues.sleep)
			end

                        if (i=='fan')
                        then
                           p.dialog=clone(dialogues.fan_1)
                        end

                        if (i=='smithman')
                        then
                           p.dialog=clone(dialogues.smith)
                        end

                        if (i=='tarvernkeepper')
                        then
                           p.dialog=clone(dialogues.tarvern_buy)
                        end

                        if (i=='wuyan')
                        then
                           p.dialog=clone(dialogues.wuyan_1)
                        end
		end
	end
	return has_action
end

function show_inventory()
	local spos=vec2(40,8)
	local size=vec2(48,64)
	local pos=vec2(camera_pos.x+spos.x,camera_pos.y+spos.y)
	rectfill(pos.x,pos.y,pos.x+size.x,pos.y+size.y,0)
	print('day:'..p.day,pos.x+4,pos.y+4,7)
	print('money:'..p.money,pos.x+4,pos.y+12,7)
        for i,v in ipairs(p.items) do
           print(v,pos.x+4,pos.y+15+i*8,9)
        end
end

function show_dialogue()
	local spos=vec2(8,76)
	local size=vec2(112,48)
	local pos=vec2(camera_pos.x+spos.x,camera_pos.y+spos.y)
	rectfill(pos.x,pos.y,pos.x+size.x,pos.y+size.y,0)
	print(p.dialog[1].p,pos.x+4,pos.y+4,7)
	
	local content=p.dialog[1].c
	local lines={''}
	local wcount=0
	for i=1,#content do
 	local c=sub(content,i,i)
 	lines[#lines]..=c
 	wcount+=1
 	if (wcount>=26)
 	then
 		wcount=0
 		lines[#lines]..='\n'
 		lines[#lines+1]=''
 	end
	end
	for i,v in ipairs(lines) do
		print(v,pos.x+4,pos.y+8+i*8,9)
	end
	
	rect(pos.x,pos.y,pos.x+size.x,pos.y+size.y,7)
	
	if (p.dialog[1].o!=nil)
	then
		if (p.dialog_o==nil)
		then
			p.dialog_o=1
		end
		if (btnp(⬆️))
		then
			p.dialog_o=max(1,p.dialog_o-1)
		elseif (btnp(⬇️))
		then
			p.dialog_o=max(#p.dialog[1].o,p.dialog_o+1)
		end
		p.dialog_oc=p.dialog[1].o[p.dialog_o]
		
		for i,v in ipairs(p.dialog[1].o) do
			local col=7
			if (i==p.dialog_o)
			then
				col=9
			end
			print(v,pos.x+12,pos.y+16+i*8,col)
		end
	else
		p.dialog_o=nil
		p.dialog_oc=nil
	end
end
-->8
--map

function draw_player()
	draw_sprite(sprs.player,p.pos)
end

function draw_map()
	map(0,0,0,0,128,64)
end

function update_camera(pos)
	local pos={
		x=max(0,flr(pos.x/16)*16*8),
		y=max(0,flr(pos.y/16)*16*8)
	}
	camera(pos.x,pos.y)
	return pos
end
-->8
--utils

function vec2(x,y)
	return {x=x,y=y}
end

function vec2_eq(pos1,pos2)
	return pos1.x==pos2.x and pos1.y==pos2.y
end

function draw_sprite(tile,pos)
	spr(tile,pos.x*8,pos.y*8)
end

function clone(obj)
	if type(obj) ~= 'table' then return obj end
 local res = {}
 for k,v in pairs(obj) do res[clone(k)] = clone(v) end
 return res
end

function draw_obj(item)
	if (item.show) then
		draw_sprite(item.sprite,item.pos)
	else
		draw_sprite(-1,item.pos)
	end
end

function log(val)
	if (type(val)=='table') then
		local str=''
		for k,v in pairs(val) do
			str=str..','..k..'='..v
		end
		printh(str)
		return
	end
	printh(val)
end

function play_animted_tile(pos,arr)
	local tile=mget(pos.x,pos.y)
	if (tile==-1) return
	local nexti=-1
	for i,v in ipairs(arr) do
		if (v==tile)
		then
			nexti=i+1<=#arr and i+1 or 1
		end
	end
	if (nexti!=-1)
	then
		mset(pos.x,pos.y,arr[nexti])
	end
end
__gfx__
00000000000110000002200000000000001111000004400000099000705555555555555599999999444444444999999949999999666666669999999455555555
0000000000155100002222000000000000011000004ff40000999900705555555555555599999999999999994999999999999999666666669999999955555555
00700700001ff100002ff20000000000000ff000004ff400000ff000705555555555555599999999999999994999999999999999666666669999999955555555
0007700000144100022992200000000000dddd000055550000666600705555555555555599999999999999994999999999999999666666669999999955555555
000770000044440000a99a00000000000dddddd00f5555f00f6666f0705555555555555599999999999999994999999999999999666666669999999955555555
007007000f4444f000a99a00000000000fddddf00055550000666600705555555555555599999999999999994999999999999999666666669999999955555555
000000000022220000a99a000000000000d55d000011110000333300705555555555555599999999999999994999999999999999666666669999999955555555
00000000002002000a9999a0000000000dd55dd00010010000300300705555555555555599999999999999994999999999999999666666669999999455555555
55555555551111555557755775577555728888888888888888888827777777777777777700000000999999999999999499999994499999994999999900000000
44444444418888144466674774766644728888888888888888888827700000000000000000000000999999999999999499999999999999999999999900000000
44444444418888144466674664766644728888888888888888888827705555555555555500000000999999999999999499999999999999999999999900000000
44444444128888214445547667455444728888888888888888888827705555555555555500000000999999999999999499999999999999999999999900000000
44444444192222914477776666777744728888888888888888888827705555555555555500000000999999999999999499999999999999999999999900000000
44444444149999414476664664666744728888888888888888888827705555555555555500000000999999999999999499999999999999999999999900000000
44444444014444104476664554666744728888888888888888888827705555555555555500000000999999999999999499999999999999999999999900000000
44444444401111044455554554555544728888888888888888888827705555555555555500000000444444449999999499999999499999994444444400000000
00000000000000000000000000000000728888888888888888888827705555555555555500000000444444444999999499999999499999949999999400000000
00000000000000000000000000000000728888888888888888888827705555555555555501111110999999994999999499999999999999999999999900000000
00000000000000000000000000000000728888888888888888888827705555555555555501777710999999994999999499999999999999999999999900000000
00000000000000000000000000000000728888888888888888888827705555555555555501666610999999994999999499999999999999999999999900000000
00000000000000000000000000000000728888888888888888888827705555555555555511111111999999994999999499999999999999999999999900000000
00000000000000000000000000000000728888888888888888888827705555555555555517777771999999994999999499999999999999999999999900000000
00000000000000000000000000000000722222222222222222222227700000000000000016111161999999994999999499999999999999999999999900000000
00000000000000000000000000000000777777777777777777777777777777777777777716111161444444444999999449999999999999994444444400000000
54444444000000000000000066666666000333000000000000000000000007700044440000000000000000000000000099999999999999994444444400000000
544444445555555500000000666666660033330000000000004444000011155004aaaa4000444400000000000022220099999999999999999999999900000000
54444444575777750000000066666666033ff3300000000004aaaa4001eee5504999999404eeee400000000002eeee2099999999999999999999999900000000
5444444457566665000000006666666600388330000000004a9999a41e222551444444444e2222e40000000002e11e2099999999999999999999999900000000
5444444456566665000000006666666600888800000000004a9999a41111111142222224422222240000000002e11e2099999999999999999999999900000000
544444445656666500000000666666660f8888f00000000044444444144444414f7667f4444444440000000002eeee2099999999999999999999999900000000
5444444455555555000000006666666600aaaa0000000000041111401f1111f14f1111f404111140000000000022220099999999999999999999999900000000
5444444400000000000000006666666600a00a0000000000041111401f1111f14f1111f404111140000000000000000099999994499999944999999400000000
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
30303030303030303030303030303030303030303030303030303030303030303000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
30303030303030303030303030303030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
30303030303030303030303030303030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
30303030303030010101303030303030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
30303030303030010101303030303030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
30303030303030010101303030303030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
30303030303030010101303030303030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
30303030303030010101303030303030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
30303030303030010101303030303030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
30303030303030010101303030303030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
30303030303030010101303030303030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
30303030303030010101303030303030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
30303030303030010101303030303030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
30303030303030010101303030303030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
30303030303030010101303030303030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
30303030303030303030303030303030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
30303030303030303030303030303030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddmmddddmdddddmmdmmdddddmdmmmdddddmdddddddmmdmmddddddmmmddddddddmdmdmdddddmddmmdmdddddddmdddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd

__gff__
0000000000000000000000000001000100010101000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
1010101010101010101010101010101032323232323232323232323232323232030303030303030303030303030303030303030303030303030303030303030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101010101010101010101010101032303030303030303030303030303032030303030303030303030303030303030303030303030303030303030303030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101010101011101010101010101032303030303030303030303030303032030333333333333333333333333303030303333333333333333333333333030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101010101010101010101010101032303030303030303030303030303032030333333333333333333333333303030303333333333333333333333333030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010131010101010101010101012101032303030303030303030303030303032030333333333333333333333333303030303333333333333333333333333030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010131010101010101010101012101032303030303030303030303030303032030333333333333333333333333303030303333333333333333333333333030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010131010101010101010101012101032303030303030303030303030303032030333333333333333333333333303030303333333333333333333333333000300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010131010101010101010101012101032171830303030303030303030303032030333333333333333333333333303030303333333333333333333333333030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010131010101010101010101012101032070830303030303030303030303032030333333333333333333333333303030303333333333333333333333333030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010131010101010101010101012101032272830303030303030303030303032030333333333333333333333333303030303333333333333333333333333030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101010101010101010101010101032303030303030303030303030303032030333333333333333333333333303030303333333333333333333333333030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101010101010101010101010101032303030303030303030303030303032030333333333333333333333333303030303333333333333333333333333030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101010101010101010101010101032303030303030303030303030303032030333333333141516333333333303030303333333331415163333333333030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101010101010101010101010101032303030303030303030303030303032030333333333242526333333333303030303333333332425263333333333030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101010101415161010101010101032303030303030303030303030303032030303030303030303030303030303030303030303030303030303030303030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101010102425261010101010101032323232323232323232323232323232030303030303030303030303030303030303030303030303030303030303030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d03030303030303030303030303030303030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0b091b0d0d0d0d0d0d0d03033333333333333333333333333303030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0b091b0d0d0d0d0d0d0d03033333333333333333333333333303030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0b091b0d0d0d0d0d0d0d03033333333333333333333333333303030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a0a0a0a0a0a0c091c0a0a0a0a0a0a0a03033333333333333333333333333303030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0909090909090909090909090909090903033333333333333333333333333303030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1a1a3d1a1a1a1a1a1a1a1a1a1a1a1a1a00033333333333333333333333333303030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d2b0d0d0d0d0d0d0d0d0d0d0d0d0d00033333333333333333333333333303030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a0a2d0a0a0a0a0a0a0a0a0a0a0a0a0a03033333333333333333333333333300030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1a1a1a1a1a1a2c3c1a1a1a2c3c1a1a1a03033333333333333333333333333303030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0b1b0d0d0d0b1b0d0d0d03033333333333333333333333333303030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0b1b0d0d0d0b1b0d0d0d03033333333333333333333333333303030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0b0e2a2a2a1e2e3e2a2a03033333333333333333333333333303030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2a2a2a2a2a2a1d1b0d0d0d0d0d2b0d0d03033333333333141516333333333303030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0b1b0d0d0d0d0d2b0d0d03033333333333242526333333333303030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0b1b0d0d0d0d0d2b0d0d03030303030303030303030303030303030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000b05000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
