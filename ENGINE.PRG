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
// process:engine2d                                                           //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process engine2d()
private
   int m_CHANNEL_track;
   int m_SND_track;     
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
	  
	//Load in RAM soundtrack
	m_SND_track = load_wav(DC_DIR + txt_soundtrack);
	play_wav(m_SND_track  ,SNDENV, m_CHANNEL_track);
 	
	  
	define_region(1,0,0,320,240);	
	switch(id_LEVEL_counter)		
		case  2: start_scroll(0, id_FPG_WAD, 2,0,1,2);  end
		case  3: start_scroll(0, id_FPG_WAD, 3,0,1,2);  end
		case  4: start_scroll(0, id_FPG_WAD, 4,0,1,2);  end
		case  5: start_scroll(0, id_FPG_WAD, 5,0,1,2);  end
		case  6: start_scroll(0, id_FPG_WAD, 6,0,1,2);  end
		case  7: start_scroll(0, id_FPG_WAD, 7,0,1,2);  end
		case  8: start_scroll(0, id_FPG_WAD, 8,0,1,2);  end
		case  9: start_scroll(0, id_FPG_WAD, 9,0,1,2);  end
		case 10: start_scroll(0, id_FPG_WAD,10,0,1,2);  end
	end		
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

	hp_bar();
	pw_bar();
	pilot();
	fx_ship();
	message();
	mazinger();
	
	timer[0]=0;
   
   
   	loop

		 if(id_GAME_OVER == 1)	
			signal(TYPE mazinger,S_KILL);
			signal(TYPE hp_bar,S_KILL);
			signal(TYPE pw_bar,S_KILL);
			signal(TYPE fx_ship,S_KILL);
			signal(TYPE fire_ship,S_KILL);
			signal(TYPE enemy,S_KILL);	
            signal(TYPE pilot,S_KILL);				
			break;	
		 end

		 if(id_RECORD_counter > id_level_winner)            //100 (bp1) value for move to next level ===>
			signal(TYPE mazinger,S_KILL);
			signal(TYPE hp_bar,S_KILL);
			signal(TYPE pw_bar,S_KILL);
			signal(TYPE fx_ship,S_KILL);
			signal(TYPE fire_ship,S_KILL);
			signal(TYPE enemy,S_KILL);	
            signal(TYPE pilot,S_KILL);				
			id_Next_LEVEL=1;
			break;	
		 end

		
		if(id_GAME_OVER == 0 && id_Next_LEVEL == 0 && id_Pause == 0)
			
			if(timer[0] > 1300)
			   if(id_Num_Fires < 2)
				  missile();
			   end
			   timer[0]=0;
			end


			//A random number between 0 and id_LEVEL_Dificulty is less than 30, then create
			//an "enemy" type process at the top of the screen
			
			if( rand(0,id_LEVEL_Dificulty) < 10 )
				enemy(rand(0,320),rand(-4,4),rand(6,12));
			end
			
			if( rand(0,id_LEVEL_Dificulty) < 10 )
				enemyHorizontal(350,rand(20,220));
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
		game_over();
	end


	if(id_Next_LEVEL == 1)
		stop_wav(id_CHANNEL_Lazer);
		stop_wav(id_CHANNEL_Charge);
		stop_wav(id_CHANNEL_Xplot);
		stop_wav(m_CHANNEL_track);
		unload_wav(m_SND_track);
		clear_screen();
		delete_text(0);
		starting_level();
	end



end  

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:mazinger                                                           //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process mazinger()

private
   
   int m_Pressed1;   //Button (X)
   int m_Free1;
   int m_Pressed2;   //Button (O)
   int m_Free2;

begin
 
	file = id_FPG_Mazinger;
	graph=2;
	x=50;
	y=50;
	z=0;


loop	
	
	if(id_GAME_OVER == 1 || id_Next_LEVEL == 1)
		break;
	end
	
	
    if(id_Pause==0)
	
          //--------------------DETECTION BUTTON PRESSED AND FREE (X) ----->      
          if(JOY_PS2_CROSS(0))       //PS2_BUTTON = (X)
             m_Pressed1=1;    
             m_Free1=0;         
          end
          
          if(NOT JOY_PS2_CROSS(0))   //PS2_BUTTON = (X)
             m_Free1=1;
          end      

          //--------------------DETECTION BUTTON PRESSED AND FREE (O) ----->      
          if(JOY_PS2_CIRCLE(0))       //PS2_BUTTON = (O)
             m_Pressed2=1;    
             m_Free2=0;         
          end
          
          if(NOT JOY_PS2_CIRCLE(0))   //PS2_BUTTON = (O)
             m_Free2=1;
          end      

         //---Pause-------------------------------------------

         if(JOY_PS2_START(0))        //PS2_START
            id_Pause=1;
            pause();
         end

         if(JOY_PS2_SELECT(0))        //PS2_SELECT
			if(id_VMU_Use == 1)
				id_Pause=1;
				saveg();
			end
         end
		 
		 
		//------------------------------------------------------->	
		switch(id_Firing)

			case 1:
                 if(m_Pressed1 + m_Free1 == 2)     //Event System Button (X)
                   //Clear Buffer for event Button (X)     
                   m_Pressed1=0;
                   m_Free1=0;
                   
                   if(id_Num_Fires > 0)
                      id_Num_Fires-=1;
                   end
                   
                   if(id_Num_Fires > 0)
					    if(NOT is_playing_wav(id_CHANNEL_Lazer))													
							play_wav(id_SND_Lazer,1,id_CHANNEL_Lazer);					  										  
						end				   
						fire_ship(x,y);                   
                   end
                   
                 end
			end

			case 2:
                 if(m_Pressed2 + m_Free2 == 2)     //Event System Button (O)
                   //Clear Buffer for event Button (O)
                   m_Pressed2=0;
                   m_Free2=0;
                   
                   if(id_Num_Fires > 0)
                      id_Num_Fires-=1;
                   end
                   
                   if(id_Num_Fires > 0) 
                        if(NOT is_playing_wav(id_CHANNEL_Lazer))													
							play_wav(id_SND_Lazer,1,id_CHANNEL_Lazer);					  										  
						end				   				   
						fire_ship(x,y);                   
                   end
                   
                 end
			end



		end
		
		//----------------------PS2 CONTROLLERS-----------------------------------//

		 if(JOY_PS2_UP(0) && y > 40)			
			y-=5;
		 end

		 if(JOY_PS2_DOWN(0) && y < 180)
			y+=5;
		 end

		 if(JOY_PS2_LEFT(0) && x > 35)
			x-=5;
		 end

		 if(JOY_PS2_RIGHT(0) && x < 280) 
			x+=5;
		 end

		if(y < 180)
				y+=1;
		end
 
		id_Nave_X = x;
		id_Nave_Y = y;

		//---------------------COLLISIONS--------------------------------------//
		
    
		if(collision(TYPE missile))
				if(NOT is_playing_wav(id_CHANNEL_Charge))
					play_wav(id_SND_Charge,1,id_CHANNEL_Charge);
				end
				id_Num_Fires=10;
				signal(TYPE missile,S_KILL);
		end
    
    
		if (collision(TYPE enemy))
			if (id_HP_counter > 10)	

				from graph=5 to 9;         
					frame;             
				end

				if(id_GAME_OVER < 1)
					if(NOT is_playing_wav(id_CHANNEL_Xplot))
						play_wav(id_SND_Xplot,1,id_CHANNEL_Xplot);			
					end
					setdualshock(0,160);
				end

				graph=2;
				id_HP_counter-=2;
			else
				id_GAME_OVER=1;
			end
		end



		if (collision(TYPE enemyHorizontal))
			if (id_HP_counter > 10)	

				from graph=5 to 9;         
					frame;             
				end

				if(id_GAME_OVER < 1)
					if(NOT is_playing_wav(id_CHANNEL_Xplot))
						play_wav(id_SND_Xplot,1,id_CHANNEL_Xplot);			
					end
					setdualshock(0,160);
				end

				graph=2;
				id_HP_counter-=2;
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
// process:fx_ship                                                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process fx_ship()

begin

	file = id_FPG_Mazinger;  
	x=id_Nave_X+3;
	y=id_Nave_Y+10;
	z=0;
	size=rand(10,70);

loop

	if(id_GAME_OVER == 1 || id_Next_LEVEL == 1)
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
// process:fire_ship                                                          //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process fire_ship(px,py)
private
	int y1;
begin

	file = id_FPG_Mazinger;  
	graph=12;
	y1 = py-5;
	x=px;
	y=py;
	z=0;
	size_x = 70;

    repeat
        y = y-5;    // Moves to the right 5 points
        frame;      // Display the following image		
    until(y < y1 - 120)  // Repeat until it comes out on the right side

end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:hp_bar                                                             //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process hp_bar()

begin

	file = id_FPG_Mazinger;  
	graph=3;
	x=55;
	y=225;
	z=0;


	loop

		if(id_GAME_OVER == 1 || id_Next_LEVEL == 1)
			break;
		end
		
		size_x=id_HP_counter;
		frame;
	end

end


////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process: pw_bar                                                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process pw_bar()

begin

	file = id_FPG_Mazinger;
	graph=4;
	x=115;
	y=225;
	z=0;

loop

	if(id_GAME_OVER == 1 || id_Next_LEVEL == 1)
		break;
	end
	
	frame;
end	

end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:enemy                                                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////


process enemy(x,inc_x,inc_y)
begin
    
	file = id_FPG_Mazinger; 

/*	
	switch(id_LEVEL_counter)
		case  2: graph=24;  end
		case  3: graph=25;  end
		case  4: graph=26;  end
		case  5: graph=27;  end
		case  6: graph=28;  end
		case  7: graph=29;  end
		case  8: graph=30;  end
		case  9: graph=31;  end
		case 10: graph=32;  end
	end		
*/
    graph=rand(24,33);	
    y=-20;                                  // Position the graph at the top of the screen
	z=0;
    size=rand(100,150);                      // It is chosen at random its size (between 50% and 100%)
	

    repeat
		
	      x+=inc_x;         // Adds the increment x to its x-coordinate
	      y+=inc_y;         // Same with coordinate
		  

              if( collision(TYPE fire_ship) )
        		  id_RECORD_counter+=5;
        		  id_SUPER_RECORD_counter+=5;

	        	  from graph=5 to 9;        // Shows an explosion in enemy position
        	        	frame;              // (the graphics of the explosion are from 5 to 9)
   		          end

			     if (id_GAME_OVER < 1)
				 
					if(NOT is_playing_wav(id_CHANNEL_Xplot))
						play_wav(id_SND_Xplot,1,id_CHANNEL_Xplot);
					end
				 					
			     end
				 
				 break;

              end
		frame; 

    until (y>220);     // repeat until you exit the screen or collide with a shot

    if (id_GAME_OVER < 1)
		if(NOT is_playing_wav(id_CHANNEL_Xplot))
			play_wav(id_SND_Xplot,1,id_CHANNEL_Xplot);
		end
    end

    from graph=5 to 9;        
       frame;              
    end


end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:enemyHorizontal                                                    //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process enemyHorizontal(px,py)
begin

	file = id_FPG_Mazinger;  
	graph=11;
	x=px;
	y=py;
	z=0;
	size = rand(40,80);
	
    repeat
	
		if(id_GAME_OVER == 1 || id_Next_LEVEL == 1)
			break;
		end
	
              if( collision(TYPE fire_ship) )
        		  id_RECORD_counter+=5;
        		  id_SUPER_RECORD_counter+=5;

	        	  from graph=5 to 9;        // Shows an explosion in enemy position
        	        	frame;              // (the graphics of the explosion are from 5 to 9)
   		          end

			     if (id_GAME_OVER < 1)
				 
					if(NOT is_playing_wav(id_CHANNEL_Xplot))
						play_wav(id_SND_Xplot,1,id_CHANNEL_Xplot);
					end
				 					
			     end
				 
				 break;

              end
	
	
	
	
        x = x-5;         // Moves to the right 5 points
        frame;           // Display the following image		
    until(x < 0)         // Repeat until it comes out on the right side

end



////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:pilot                                                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process pilot()
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

		if(id_GAME_OVER == 1 || id_Next_LEVEL == 1)
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
// process:missile                                                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process missile()

begin

	file = id_FPG_Mazinger;
	graph=1;
	x=320;
	y=rand(60,180);
	z=0;
	size=100;

	repeat
		x-=5;
		frame;
	until(x < 0)

end


////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:message                                                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process message()
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

		if(id_GAME_OVER == 1 || id_Next_LEVEL == 1)
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



////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:PAUSE                                                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process pause()

private

       int N_Level_pause1;
       int N_Episode_pause1;
       int N_Record_pause1;
       int N_password_pause1;

       int S_Level_pause1;
       int S_Episode_pause1;
       int S_Record_pause1;
       int S_password_pause1;

begin

		file = id_FPG_Mazinger;
		Graph=13;
		x=167;
		y=135;
		z=0;

		N_Level_pause1   = write_int(0,200,130,0,&id_Level_Counter);
		N_Record_pause1  = write_int(0,200,150,0,&id_Super_Record_Counter);


		if(id_Language == 1)
			S_Level_pause1   = write(0,100,130,0,"LEVEL:");			
			S_Record_pause1  = write(0,100,150,0,"SCORE:");			
		else
			S_Level_pause1   = write(0,100,130,0,"NIVEL:");			
			S_Record_pause1  = write(0,100,150,0,"PUNTOS:");			
		end
				
		if(id_VMU_Use == 0)
			switch(id_LEVEL_counter)		
				case  2: write(0,100,160,0,"PASSWORD: [2] [2] [6]"); end
				case  3: write(0,100,160,0,"PASSWORD: [6] [2] [4]"); end
				case  4: write(0,100,160,0,"PASSWORD: [4] [7] [9]"); end
				case  5: write(0,100,160,0,"PASSWORD: [3] [3] [8]"); end
				case  6: write(0,100,160,0,"PASSWORD: [8] [6] [5]"); end
				case  7: write(0,100,160,0,"PASSWORD: [6] [9] [7]"); end
				case  8: write(0,100,160,0,"PASSWORD: [3] [6] [1]"); end
				case  9: write(0,100,160,0,"PASSWORD: [8] [5] [1]"); end
				case 10: write(0,100,160,0,"PASSWORD: [9] [3] [7]"); end	
			end
		end

		loop
        
			if(JOY_PS2_CROSS(0))      //PS2_BUTtoN = (X)
				break;
			end

			if(JOY_PS2_CIRCLE(0))    //PS2_BUTtoN = (O)
				break;
			end

			if(JOY_PS2_TRIANGLE(0))  //PS2_BUTtoN = (/\)
				break;
			end
    
			if(JOY_PS2_SQUARE(0))    //PS2_BUTtoN = ([])
				break;
			end
    
			frame;
		end


    //clear window pause and infogame refresh--------------------------
    delete_text(0);
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
	//------------------------------------------------------------------

    
    id_Pause=0;    
    
end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:SAVEG                                                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process saveg()
begin

	file = id_FPG_Mazinger;
    graph=45;
	x=160;
	y=120;
	z=0;
	size=100;
		
	MEMORYCARD.m_level    = id_LEVEL_counter;
    MEMORYCARD.m_score    = id_SUPER_RECORD_Counter;
	MEMORYCARD.m_language = id_Language;
		
	echo("BGDR ===> INTENT SAVE IN MEMORYCARD... 8 CHARS MAX ===>");
	if(IOSYS_CALL_MC_SAVE("MAZINGER",MEMORYCARD,sizeof(MEMORYCARD),PS2_MEMORY_CARD1))
		
				if(id_Language == 1)
					write(0,120, 90,0,"LEVEL:");			
					write(0,120,110,0,"RECORD:");					
				else
					write(0,120, 90,0,"NIVEL:");			
					write(0,120,110,0,"PUNTOS:");			
				end
				
				write_int(0,250, 90,0,&id_LEVEL_counter);
				write_int(0,250,110,0,&id_SUPER_RECORD_Counter);
				
	else
				if(id_Language == 1)
					write(0,120, 90,0,"MEMORYCARD");			
					write(0,120,110,0,"ERROR ON SAVED");			
				else
					write(0,120, 90,0,"MEMORYCARD");			
					write(0,120,110,0,"ERROR AL GUARDAR");			
				end
				
	end
		
	
	timer[0]=0;	
	loop
	
		if(timer[0] > 700)
			break;
		end
		
		frame;
	end

	    //clear window pause and infogame refresh--------------------------
    delete_text(0);
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
	//------------------------------------------------------------------

    
    id_Pause=0;    

	
end


