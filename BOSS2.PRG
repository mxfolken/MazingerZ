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
// process splash_boss2                                                       //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process splash_boss2()

begin


  //Assign channel of playstation2 hardware, 16 channels available.
  //Sony CHIP 4335KSZ PS2 model 77001.
  id_CHANNEL_Opening    = 1;
  id_CHANNEL_Lazer      = 2;
  id_CHANNEL_Charge     = 3;
  id_CHANNEL_Xplot      = 4;

  //Load in RAM soundtrack
  id_SND_Opening = load_wav(DC_DIR + "MZBOSS.ADX");
  play_wav(id_SND_Opening ,SNDENV,id_CHANNEL_Opening);
  play_wav(id_SND_Lazer   ,1     ,id_CHANNEL_Lazer); 
  play_wav(id_SND_Charge  ,1     ,id_CHANNEL_Charge);  
  play_wav(id_SND_Xplot   ,1     ,id_CHANNEL_Xplot);   


timer[0]=0;
clear_Screen();
file = id_FPG_Boss2;
graph=2;
x=160;
y=100;
z=0;
size=100;

         loop

             if(timer[0] > 500)
                break;
             end         

         frame;
         end

         clear_Screen();
         boss2_main();
		 
end


////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process: boss2_main                                                        //      
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process boss2_main()
begin
  id_GRAPHICS_Boss1        = 3;  // Next to GR.13
  id_GRAPHICS_Boss1_Select = 0;    
  id_Game_Over             = 0;
  id_BOSS1_Death           = 0;


if (id_Language == 1) 
 write(id_FNT_Files,20,20,0,"HP:");
 write(id_FNT_Files,150,20,0,"RECORD:");
 write(id_FNT_Files,250,20,0,"FIRES:");
 write(id_FNT_Files,20,40,0,"ENEMY:"); 
else
 write(id_FNT_Files,20,20,0,"VT:");
 write(id_FNT_Files,150,20,0,"PUNTOS:");
 write(id_FNT_Files,250,20,0,"FUEGO:");
 write(id_FNT_Files,20,40,0,"ENEMY:");
end

 write_int(id_FNT_Files,225,20,0,&id_SUPER_RECORD_counter);
 write_int(id_FNT_Files,300,20,0,&id_Num_Fires);
 

  timer[5]=0;

  file = id_FPG_Boss2;
  clear_Screen();
  put_screen(id_FPG_Boss2,1);
  
  
  nave_vs_boss2(200,200);
  boss2();            
  hp_bar_vs_boss2();
  hp_bar_enemy2();      
  cohetes_nave_vs_boss2();
  

  loop
    
	 	  
      //---------if GAMEOVER or WINS----------------------------
		 if(id_GAME_OVER == 1)	
			signal(type Boss2,S_KILL);
			signal(type PowerBoss2,S_KILL);
			signal(type Power2Boss2,S_KILL);
			signal(type Power3Boss2,S_KILL);
			signal(type Power4Boss2,S_KILL);
			signal(type Nave_Vs_Boss2,S_KILL);
			signal(type Cohetes_Nave_Vs_Boss2,S_KILL);
            signal(type Hp_bar_Vs_Boss2,S_KILL);
            signal(type Hp_bar_Enemy2,S_KILL);
            signal(type Fire_Nv_Vs_Boss2,S_KILL);				
			break;	
		 end
		 
         if(id_BOSS1_Death == 1)
			signal(type Boss2,S_KILL);
			signal(type PowerBoss2,S_KILL);
			signal(type Power2Boss2,S_KILL);
			signal(type Power3Boss2,S_KILL);
			signal(type Power4Boss2,S_KILL);
			signal(type Nave_Vs_Boss2,S_KILL);
			signal(type Cohetes_Nave_Vs_Boss2,S_KILL);
            signal(type Hp_bar_Vs_Boss2,S_KILL);
            signal(type Hp_bar_Enemy2,S_KILL);
            signal(type Fire_Nv_Vs_Boss2,S_KILL);	            				
			break;	         
         end

  
    
      if(timer[5] > 1300)
           if(id_Num_Fires < 2)
              Missile_b2();
           end
           timer[5]=0;
      end

          
  frame;
  end

  if(id_BOSS1_Death == 1)
        //exit("You Win...",0);
		stop_wav(id_CHANNEL_Lazer);
		stop_wav(id_CHANNEL_Charge);
		stop_wav(id_CHANNEL_Xplot);
		stop_wav(id_CHANNEL_Opening);
		unload_wav(id_SND_Opening);
		clear_screen();
		delete_text(0);	
		starting_level();     
  end

  if(id_Game_Over == 1)
        //exit("You Lose...",0);
		stop_wav(id_CHANNEL_Lazer);
		stop_wav(id_CHANNEL_Charge);
		stop_wav(id_CHANNEL_Xplot);
		stop_wav(id_CHANNEL_Opening);
		unload_wav(id_SND_Opening);
		clear_screen();
		delete_text(0);		
		game_over();
     
  end



end




////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process: boss2                                                             //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process boss2()
private
  int m_PosX_Boss1;
  int m_PosY_Boss1;
  int m_PosX_Boss1_Right;
  int m_PosY_Boss1_Down;
begin

  file = id_FPG_Boss2;
  z=0;
  size=120;
  
  m_PosX_Boss1       = 10;
  m_PosY_Boss1       = 50;
  m_PosX_Boss1_Right = 1;
  m_PosY_Boss1_Down  = 1;
  id_GRAPHICS_Boss1  = 2;
  id_GRAPHICS_Boss1_Select = 0;
  
  
  timer[0]=0;
  
 loop
 
   	if(id_GAME_OVER == 1 || id_BOSS1_Death == 1)
		break;
	end

  
    //---------Animation IA enemy----------------------
 
      if (rand(1,50) < 10) 

         if(m_PosX_Boss1_Right == 1)
            if(m_PosX_Boss1 > 300)
               m_PosX_Boss1_Right =0;
            else      
               m_PosX_Boss1+=rand(3,5);
            end
         end

         if(m_PosX_Boss1_Right == 0) 
            if(m_PosX_Boss1 < 10)
               m_PosX_Boss1_Right =1;
            else
               m_PosX_Boss1-=3;
            end
         end 
          
      end
  
      if (rand(1,50) < 10) 

         if(m_PosY_Boss1_Down == 1)
            if(m_PosY_Boss1 > 200)
               m_PosY_Boss1_Down =0;
            else      
               m_PosY_Boss1+=3;
            end
         end

         if(m_PosY_Boss1_Down == 0) 
            if(m_PosY_Boss1 < 10)
               m_PosY_Boss1_Down =1;
            else
               m_PosY_Boss1-=3;
            end
         end 
          
      end
	    
        //-----Timer[0]-------- Timer code resembling VB 
        //Timer1 will be activated less than every 10 milliseconds. 1= second = 100
        
	if (timer[0] > 5)
        
           if (id_GRAPHICS_Boss1 == 2 and id_GRAPHICS_Boss1_Select == 0)
           		 id_GRAPHICS_Boss1 = 3;
           		 id_GRAPHICS_Boss1_Select = 1;
           end
           
           if (id_GRAPHICS_Boss1 == 3 and id_GRAPHICS_Boss1_Select == 0)
           		 id_GRAPHICS_Boss1 = 4;
           		 id_GRAPHICS_Boss1_Select = 1;
           end
           
           if (id_GRAPHICS_Boss1 == 4 and id_GRAPHICS_Boss1_Select == 0)
           		 id_GRAPHICS_Boss1 = 5;                                    
           		 id_GRAPHICS_Boss1_Select = 1;
           end
           
           if (id_GRAPHICS_Boss1 == 5 and id_GRAPHICS_Boss1_Select == 0)
           		 id_GRAPHICS_Boss1 = 6;                                    
           		 id_GRAPHICS_Boss1_Select = 1;
           end


           if (id_GRAPHICS_Boss1 == 6 and id_GRAPHICS_Boss1_Select == 0)
           		 id_GRAPHICS_Boss1 = 7;                                    
           		 id_GRAPHICS_Boss1_Select = 1;
           end


           if (id_GRAPHICS_Boss1 == 7 and id_GRAPHICS_Boss1_Select == 0)
           		 id_GRAPHICS_Boss1 = 8;                                    
           		 id_GRAPHICS_Boss1_Select = 1;
           end


           if (id_GRAPHICS_Boss1 == 8 and id_GRAPHICS_Boss1_Select == 0)
           		 id_GRAPHICS_Boss1 = 9;                                    
           		 id_GRAPHICS_Boss1_Select = 1;
           end


           if (id_GRAPHICS_Boss1 == 9 and id_GRAPHICS_Boss1_Select == 0)
           		 id_GRAPHICS_Boss1 = 10;                                    
           		 id_GRAPHICS_Boss1_Select = 1;
           end


           if (id_GRAPHICS_Boss1 == 10 and id_GRAPHICS_Boss1_Select == 0)
           		 id_GRAPHICS_Boss1 = 11;                                    
           		 id_GRAPHICS_Boss1_Select = 1;
           end

           if (id_GRAPHICS_Boss1 == 11 and id_GRAPHICS_Boss1_Select == 0)
           		 id_GRAPHICS_Boss1 = 12;                                    
           		 id_GRAPHICS_Boss1_Select = 1;
           end

           if (id_GRAPHICS_Boss1 == 12 and id_GRAPHICS_Boss1_Select == 0)
           		 id_GRAPHICS_Boss1 = 13;                                    
           		 id_GRAPHICS_Boss1_Select = 1;
           end
		   
           if (id_GRAPHICS_Boss1 == 13 and id_GRAPHICS_Boss1_Select == 0)
           		 id_GRAPHICS_Boss1 = 3;                                    
           		 id_GRAPHICS_Boss1_Select = 1;
           end


           //Reset Selection and Timer
           id_GRAPHICS_Boss1_Select = 0;
           timer[0]=0;

        end
        //----Timer[0]---------end Code              
		  
  
  if(rand(1,200) < 10)
     powerboss2(x,y);
  end

  if(rand(1,200) < 10)
     power2boss2(x,y);
  end

  if(rand(1,200) < 10)
     power3boss2(x,y);
  end

  if(rand(1,200) < 10)
     power4boss2(x,y);
  end


        //---------------------------------collisions------------------------------------
        if(collision(TYPE nave_vs_boss2))
          if(id_HP_Counter > 10)
             id_HP_Counter-=id_boss_CLLN_majinga;  //10 Increase Amount to Increase Difficulty Boss
             from graph=14 TO 18;   
                  z=0;
                  size=200;     
                  frame;              
             end
             if (id_GAME_OVER < 1)
							if(NOT is_playing_wav(id_CHANNEL_Xplot))
								play_wav(id_SND_Xplot,1,id_CHANNEL_Xplot);			
							end
							setdualshock(0,200);						
             end                          
          else
             //Your Lose... GameOver
               id_Game_Over=1;
          end
        end

        if(collision(TYPE fire_nv_vs_boss2))
          if(id_Healty_Boss1 > 100)
			if(NOT is_playing_wav(id_CHANNEL_Xplot))
				play_wav(id_SND_Xplot,1,id_CHANNEL_Xplot);			
			end
			setdualshock(0,140);
            id_Healty_Boss1-=id_boss_CLLN_fire;  //9 (bp1)  Decrease Amount to Enlarge Difficulty with Boss			 
            from graph=14 TO 18;   
                  z=0;
                  size=200;     
                  frame;              
            end			 
          else
             //Your Wins... Next Level
               id_BOSS1_Death=1;
          end
        
		end
		
  graph=id_GRAPHICS_Boss1;
  size=120;
  x=m_PosX_Boss1;
  y=m_PosY_Boss1;
  frame;


end		

end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process powerboss2                                                         //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process powerboss2(pw_X_Axis,pw_Y_Axis)

begin

  file = id_FPG_Boss2;
  graph=18;
  x=pw_X_Axis;
  y=pw_Y_Axis+20;
  z=0;
  size=rand(30,60);

  repeat
        y+=3;
        frame;                       
  until(y > 200)
  

    
end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process Power2Boss2                                                        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process power2boss2(pw2_X_Axis,pw2_Y_Axis)

begin

  file = id_FPG_Boss2;
  graph=18;
  x=pw2_X_Axis;
  y=pw2_Y_Axis+20;
  z=0;
  size=rand(30,60);

  repeat
        x+=3;
        frame;          
  until(x > 300)
  
  //frame;
end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process power3boss2                                                        // 
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process power3boss2(pw3_X_Axis,pw3_Y_Axis)

begin

  file = id_FPG_Boss2;
  graph=18;
  x=pw3_X_Axis;
  y=pw3_Y_Axis+20;
  z=0;
  size=rand(30,60);

  repeat
        x-=3;
        frame;  
  until(x < 10)
  
end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process power4boss2                                                        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process power4boss2(pw4_X_Axis,pw4_Y_Axis)

begin

  file = id_FPG_Boss2;
  graph=18;
  x=pw4_X_Axis;
  y=pw4_Y_Axis+20;
  z=0;
  size=rand(30,60);

  repeat
        y-=3;
        frame;  
  until(y < 10)
  
end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process nave_vs_boss2                                                      //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process nave_vs_boss2(Vs1_X,Vs1_Y)
private
  int m_Pressed1;   //Button (X)
  int m_Free1;
  int m_Pressed2;   //Button (O)
  int m_Free2;
begin

  file = id_FPG_Mazinger;
  graph=2;
  x=Vs1_X;
  y=Vs1_Y;
  z=0;
    
loop

  	if(id_GAME_OVER == 1 || id_BOSS1_Death == 1)
		break;
	end
  
  
    //------controller ship----------------------------------
      
  	if(JOY_PS2_UP(0) && y > 48)
		y-=5;			
	end

	if(JOY_PS2_DOWN(0) && y < 172)
		y+=5;			
	end

	if(JOY_PS2_LEFT(0) && x > 19)			
		x-=5;			
	end

	if(JOY_PS2_RIGHT(0) && x < 302)
		x+=5;
	end

  
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

  
      //-----Fire ship ----------------------------------------------
  
        if(id_Game_Over < 1)
		switch (id_Firing)

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
				   				   
                      Fire_Nv_Vs_Boss2(x,y);                 
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
				   
                        Fire_Nv_Vs_Boss2(x,y);                 
                   end
                                 
                 end
						
			end
  
       end
       end
      //-------------------------------------------------------------

  
		id_Nave_X = x;
		id_Nave_Y = y;

		//---------------------COLLISIONS--------------------------------------//
  
    if(collision(TYPE missile_b2))
		if(NOT is_playing_wav(id_CHANNEL_Charge))
			play_wav(id_SND_Charge,1,id_CHANNEL_Charge);
		end		
       id_Num_Fires=10;
	   signal(TYPE Missile_b2,S_KILL);
    end

    //---------------------------------collisions------------------------------------
        if( collision(type powerboss2) OR collision(type power2boss2) OR collision(type power3boss2) OR collision(type power4boss2) )
          if(id_HP_Counter > 10)
             id_HP_Counter-=id_majinga_CLLN_fireboss;  //18Increase Amount to Increase Difficulty Boss
             from graph=5 to 9;   
                  z=0;
                  size=50;     
                  frame;              
             end
             if (id_GAME_OVER < 1)
							if(NOT is_playing_wav(id_CHANNEL_Xplot))
								play_wav(id_SND_Xplot,1,id_CHANNEL_Xplot);			
							end
							setdualshock(0,200);
							graph=2;
							size=100; 
             end                          
          else
             //Your Lose... GameOver
               id_Game_Over=1;
          end
        end
	
	
	
		
  frame;
end  
  
  
end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process: cohetes_nave_vs_boss2                                             //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process cohetes_nave_vs_boss2()
begin

	file = id_FPG_Mazinger;  
	x=id_Nave_X+3;
	y=id_Nave_Y+10;
	z=0;
	size=rand(10,70);

loop

	if(id_GAME_OVER == 1 || id_BOSS1_Death == 1)
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
// process: hp_bar_vs_boss2                                                   //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process hp_bar_vs_boss2();

begin

    file = id_FPG_Mazinger;
	graph=3;
	x=52;
	y=25;
	z=0;
	
loop	

  	if(id_GAME_OVER == 1 || id_BOSS1_Death == 1)
		break;
	end

	size_x=id_HP_counter;
	frame;
end


end


////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process: hp_bar_enemy2                                                     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process hp_bar_enemy2()

begin

    file = id_FPG_Mazinger;
	graph=4;
	x=107;
	y=50;
	z=0;
	
loop	

  	if(id_GAME_OVER == 1 || id_BOSS1_Death == 1)
		break;
	end

	size_x=(id_Healty_Boss1)/4;
	frame;
end


end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process: fire_nv_vs_boss2                                                  //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process fire_nv_vs_boss2(px,py);
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
// process missile_b2                                                         //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process missile_b2()

begin

	file = id_FPG_Mazinger;
	graph=1;
	x=320;
	y=rand(60,180);
	z=0;
	size=60;

	repeat
		x-=5;
		frame;
	until(x < 0)

end





