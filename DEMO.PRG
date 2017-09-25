////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//    This program is free software: you can redistribute it and/or modify    //
//    it under the terms of the GNU General Public License as published by    //
//    the Free Software Foundation, either version 3 of the License, or       //
//    (at your option) any later version.                                     //
//                                                                            //
//    This program is distributed in the hope that it will be useful,         //
//    but WITHOUT ANY WARRANTY; without even the implied warranty of          //
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           //
//    GNU General Public License for more details.                            //
//                                                                            //
//    You should have received a copy of the GNU General Public License       //
//    along with this program.  If not, see <http://www.gnu.org/licenses/>.   //
//	                                                                          //
//	  Nova32 Development Software                                             //
//	  (c) Rolando Fernandez Benavidez 2005.                                   //
//	  GNU General Public License                                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
//                          M A Z I N G E R   Z                               //
//                          SONY PlayStation 2                                //
// By Rolando Fernandez Benavidez                                             //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
//  LOGS:                                                                     //
//  --------------------------------------------------------------------------//
//  DATE {mm/dd/yyyy}     TIME        SUMMARY                      PROGRAMMER //
//  --------------------------------------------------------------------------//
//  12/11/2005            06:09 pm    Create, Fenix                RFB        //
//  01/24/2009            11:07 pm    Update core, Fenix           RFB        //
//  08/02/2017            04:38 pm    Update Graphics, Fenix       RFB        //
//  08/15/2017            09:44 am    BennuGD                      RFB        //
//  09/20/2017            10:06 am    PlayStation 2                RFB        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:demo2d                                                             //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process demo2d()
private
   int m_CHANNEL_track;
   int m_SND_track;
   int m_RND_wad; 
begin

	//Choice graphics resources
	clear_screen();
	file = id_FPG_WAD;
		
	//Assign channel of playstation2 hardware, 16 channels available.
	//Sony CHIP 4335KSZ PS2 model 77001.
	m_CHANNEL_track       = 1;
	id_CHANNEL_Lazer      = 2;
	id_CHANNEL_Charge     = 3;
	id_CHANNEL_Xplot      = 4;
	

	id_Next_LEVEL     = 0;
	id_GAME_OVER      = 0;
	id_Pause          = 0;
	id_Record_Counter = 0;
	id_Num_Fires      = 10;
	//System core parameters of level
	id_LEVEL_Dificulty = 200;
	id_HP_counter      = 150;	
	id_LEVEL_counter   = 1;
	id_level_winner    = 100; //100
	
	  
	//Load in RAM soundtrack
	
	m_RND_wad = rand(1,7);
	
	switch(m_RND_wad)
		
		case 1:
		txt_soundtrack = "LEVEL02.ADX";
		end
		
		case 2:
		txt_soundtrack = "LEVEL03.ADX";
		end
		
		case 3:
		txt_soundtrack = "LEVEL05.ADX";
		end
		
		case 4:
		txt_soundtrack = "LEVEL06.ADX";
		end
		
		case 5:
		txt_soundtrack = "LEVEL08.ADX";
		end
		
		case 6:
		txt_soundtrack = "LEVEL10.ADX";
		end
		
		case 7:
		txt_soundtrack = "LMZ0000.ADX";
		end
		
	end
	
		
	m_SND_track = load_wav(DC_DIR + txt_soundtrack);
	play_wav(m_SND_track  ,SNDENV, m_CHANNEL_track);
 	
	m_RND_wad = rand(2,10);
	
	define_region(1,0,0,320,240);
	start_scroll(0, id_FPG_WAD,m_RND_wad,0,1,2);	
	scroll.camera=id;
	ctype=c_scroll;


 	if (id_Language == 1) 
	 write(id_FNT_Files,20 ,220,0,"HP:");
	 write(id_FNT_Files,80 ,220,0,"PW:");
	 write(id_FNT_Files,150,220,0,"RECORD:");
	 write(id_FNT_Files,250,220,0,"LEVEL:");
	 write(id_FNT_Files,20 ,210,0,"FIRES:");
	else
	 write(id_FNT_Files,20 ,220,0,"VT:");
	 write(id_FNT_Files,80 ,220,0,"DS:");
	 write(id_FNT_Files,150,220,0,"PUNTOS:");
	 write(id_FNT_Files,250,220,0,"NIVEL:");
	 write(id_FNT_Files,20 ,210,0,"FUEGO:");
	end


	write_int(id_FNT_Files,225,220,0,&id_SUPER_RECORD_counter);
	write_int(id_FNT_Files,300,220,0,&id_LEVEL_counter);
	write_int(0,70,210,0,&id_Num_Fires); 

	demo_hp_bar();
	demo_pw_bar();
	demo_pilot();
	demo_fx_ship();
	demo_message();
	demo_mazinger();
	
	timer[0]=0;
   
   
   	loop

		 if(id_GAME_OVER == 1)	
			signal(TYPE demo_mazinger,S_KILL);
			signal(TYPE demo_hp_bar,S_KILL);
			signal(TYPE demo_pw_bar,S_KILL);
			signal(TYPE demo_fx_ship,S_KILL);			
			signal(TYPE demo_enemy,S_KILL);	
            signal(TYPE demo_pilot,S_KILL);				
			break;	
		 end

		
		if(id_GAME_OVER == 0)
						
			if( rand(0,id_LEVEL_Dificulty) < 10 )
				demo_enemy(rand(0,320),rand(-4,4),rand(6,12));
			end
						
			y-=1;
		
		end 

		frame;
	end


	stop_scroll(0);


	if(id_GAME_OVER == 1)
		stop_wav(id_CHANNEL_Lazer);
		stop_wav(id_CHANNEL_Charge);
		stop_wav(id_CHANNEL_Xplot);
		stop_wav(m_CHANNEL_track);
		unload_wav(m_SND_track);		
		clear_screen();
		delete_text(0);	        
		main_menu();
	end

end  

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:demo_mazinger                                                      //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process demo_mazinger()

private
   
   int m_Pressed1;   //Button (X)
   int m_Free1;
   int m_Pressed2;   //Button (O)
   int m_Free2;
   int m_automan; 
begin
 
	file = id_FPG_Mazinger;
	graph=2;
	x=140;
	y=90;
	z=0;

    timer[6]=0;
	
loop	
	
	if(id_GAME_OVER == 1)
		break;
	end
	
	
    if(id_Pause==0)
	
        if(JOY_PS2_CROSS(0))       
             id_GAME_OVER = 1;              
        end

        if(JOY_PS2_CIRCLE(0))      
             id_GAME_OVER = 1;  
        end
          
        if(JOY_PS2_SQUARE(0))     
            id_GAME_OVER = 1;
        end

        if(JOY_PS2_TRIANGLE(0))     
			id_GAME_OVER = 1;
        end
		 
        if(JOY_PS2_UP(0))     
			id_GAME_OVER = 1;
        end

        if(JOY_PS2_DOWN(0))     
			id_GAME_OVER = 1;
        end

        if(JOY_PS2_LEFT(0))     
			id_GAME_OVER = 1;
        end

        if(JOY_PS2_RIGHT(0))     
			id_GAME_OVER = 1;
        end
		
		
		//----------------------PS2 AUTO CONTROLLERS-----------------------------------//

		if(timer[6] > 20)
		
		    m_automan = rand(1,4);
		
			switch(m_automan)
			
				case 1:
					if(y > 40)			
					y-=5;
					end
				end
				
				case 2:
					if(y < 180)
					y+=5;
					end
				end
				
				case 3:
					if(x > 35)
					x-=5;
					end
				end

				case 4:
					if(x < 280) 
					x+=5;
					end
				end
				
			end			 
			
			timer[6]=0;
			
		end

		
 
		id_Nave_X = x;
		id_Nave_Y = y;

		//---------------------COLLISIONS--------------------------------------//
		    
		if (collision(TYPE demo_enemy))
			if (id_HP_counter > 10)	

				from graph=5 to 9;         
					frame;             
				end

				if(id_GAME_OVER < 1)
					if(NOT is_playing_wav(id_CHANNEL_Xplot))
						play_wav(id_SND_Xplot,1,id_CHANNEL_Xplot);			
					end					
				end

				graph=2;
				id_HP_counter-=5;
			else
				id_GAME_OVER=1;
			end
		end
		
	end


	frame;
	
end


end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:demo_fx_ship                                                       //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process demo_fx_ship()

begin

	file = id_FPG_Mazinger;  
	x=id_Nave_X+3;
	y=id_Nave_Y+10;
	z=0;
	size=rand(10,70);

loop

	if(id_GAME_OVER == 1)
		break;
	end

	x=id_Nave_X-10;
	y=id_Nave_Y;
		
   	from graph=5 to 9;         // Show an explosion
  	     frame;              // (the graphics of the explosion are from 5 to 9)
   	end

	
end	
	
end


////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:demo_hp_bar                                                        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process demo_hp_bar()

begin

	file = id_FPG_Mazinger;  
	graph=3;
	x=55;
	y=225;
	z=0;


	loop

		if(id_GAME_OVER == 1)
			break;
		end
		
		size_x=id_HP_counter;
		frame;
	end

end


////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process: demo_pw_bar                                                       //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process demo_pw_bar()

begin

	file = id_FPG_Mazinger;
	graph=4;
	x=115;
	y=225;
	z=0;

loop

	if(id_GAME_OVER == 1)
		break;
	end
	
	frame;
end	

end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:demo_enemy                                                         //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////


process demo_enemy(x,inc_x,inc_y)
begin
    
	file = id_FPG_Mazinger; 

    graph=rand(24,33);	
    y=-20;                                  // Position the graph at the top of the screen
	z=0;
    size=rand(100,150);                      // It is chosen at random its size (between 50% and 100%)
	

    repeat
		
	    x+=inc_x;         
	    y+=inc_y;         
		frame; 

    until (y>220);     

end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:demo_pilot                                                         //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process demo_pilot()
private
	int m_show_pilot;
	int m_show_pilot_selected;
	
begin

	file = id_FPG_Mazinger;  
	graph=14;
	x=285;
	y=190;
	z=0;

	timer[4]=0;
	m_show_pilot_selected = 0;
	
	loop

		if(id_GAME_OVER == 1)
			break;
		end
				
				
		if(timer[4] > 500)
		
			m_show_pilot = rand(1,100);
			
			if(m_show_pilot < 30 && m_show_pilot_selected == 0)
				graph=15;
				m_show_pilot_selected = 1;
			end
			
			if((m_show_pilot >= 30 && m_show_pilot <= 50) && m_show_pilot_selected == 0)
				graph=16;
				m_show_pilot_selected = 1;
			end
			
			if((m_show_pilot > 50 && m_show_pilot <= 80) && m_show_pilot_selected == 0)
				graph=17;
				m_show_pilot_selected = 1;
			end
			
			if((m_show_pilot > 80 && m_show_pilot <= 100) && m_show_pilot_selected == 0)
				graph=14;
				m_show_pilot_selected = 1;
			end
			
			m_show_pilot_selected = 0;	
			timer[4]=0;
		end
							
		frame;
	end

end


////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:demo_message                                                       //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process demo_message()
private
	int m_show_pilot;
	int m_show_pilot_selected;
	
begin

	file = id_FPG_Mazinger;  
	graph=18;
	x=265;
	y=190;
	z=1;

	timer[5]=0;
	m_show_pilot_selected = 0;
	
	loop

		if(id_GAME_OVER == 1)
			break;
		end
				
				
		if(timer[5] > 500)
		
			m_show_pilot = rand(1,100);
			
			if(m_show_pilot < 30 && m_show_pilot_selected == 0)
				graph=19;
				m_show_pilot_selected = 1;
			end
			
			if((m_show_pilot >= 30 && m_show_pilot <= 50) && m_show_pilot_selected == 0)
				graph=20;
				m_show_pilot_selected = 1;
			end
			
			if((m_show_pilot > 50 && m_show_pilot <= 80) && m_show_pilot_selected == 0)
				graph=21;
				m_show_pilot_selected = 1;
			end
			
			if((m_show_pilot > 80 && m_show_pilot <= 100) && m_show_pilot_selected == 0)
				graph=18;
				m_show_pilot_selected = 1;
			end
			
			m_show_pilot_selected = 0;	
			timer[5]=0;
		end
							
		frame;
	end

end




