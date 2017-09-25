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

program PS2_MAZINGERZ;

import "mod_draw";
import "mod_joy";
import "mod_key";
import "mod_map";
import "mod_math";
import "mod_proc";
import "mod_grproc";
import "mod_rand";
import "mod_screen";
import "mod_scroll";
import "mod_sound";
import "mod_text";
import "mod_video";
import "mod_file";
import "mod_time";
import "mod_string";
import "mod_mouse";
import "mod_say";
import "mod_sort";
import "mod_wm";
import "mod_mem";
import "mod_blendop";
import "mod_timers";
import "mod_effects";
import "mod_path";
import "mod_m7";
import "mod_dir";
import "mod_sys";
import "mod_flic";




global

    //HARDWARE CORE VALUES
	#define DREAMCAST_HARDWARE     5
	#define PLAYSTATION2_HARDWARE  777	
    #define SMALLENGINE_DS         1
    #define BIGENGINE_DS           2
	#define NOTHING                0
	#define SNDENV                -1
	#define PS2_MEMORY_CARD1       0
	#define PS2_MEMORY_CARD2       1
	
	//DEBUGGER VALUES
	//#define PS2_KERNEL_DBG
	
	//PLAYSTATION2 CONTROL MAPPER
	#define JOY_PS2_CROSS(A)     JOY_GETBUTTON(A,1)
	#define JOY_PS2_CIRCLE(A)    JOY_GETBUTTON(A,2)
	#define JOY_PS2_SQUARE(A)    JOY_GETBUTTON(A,0)
	#define JOY_PS2_TRIANGLE(A)  JOY_GETBUTTON(A,3)
	#define JOY_PS2_SELECT(A)    JOY_GETBUTTON(A,4)
	#define JOY_PS2_START(A)     JOY_GETBUTTON(A,5)
	#define JOY_PS2_L1(A)        JOY_GETBUTTON(A,6)
	#define JOY_PS2_L2(A)        JOY_GETBUTTON(A,8)
	#define JOY_PS2_L3(A)        JOY_GETBUTTON(A,10)
	#define JOY_PS2_R1(A)        JOY_GETBUTTON(A,7)
	#define JOY_PS2_R2(A)        JOY_GETBUTTON(A,9)
	#define JOY_PS2_R3(A)        JOY_GETBUTTON(A,11)
	#define JOY_PS2_RIGHT(A)     (JOY_GETAXIS(A,0) >= 10000)
	#define JOY_PS2_LEFT(A)      (JOY_GETAXIS(A,0) <= -10000)
	#define JOY_PS2_UP(A)        (JOY_GETAXIS(A,1) <= -10000)
	#define JOY_PS2_DOWN(A)      (JOY_GETAXIS(A,1) >= 10000)	
	
	
	
	//system core variables		
	int id_FPG_splash;		
	int id_FPG_history;
	int id_FPG_starting;
	int id_FPG_password;
    	
	//Mazinger Z
	int id_FPG_Mazinger;
	int id_MOV_Intro;		
	int id_FPG_Boss1;
	int id_FPG_Boss2;
	int id_FPG_Boss3;
	int id_FPG_WAD;
		
	string txt_soundtrack="";
	int    id_level_winner;
	
	int id_FNT_Files;
	int id_FNT_Files2;
    int id_VMU_Use;
	int id_Axis_Y_Main;
	int id_Pause;

	int id_graphICS_Sonic;
	int id_graphICS_Sonic_Select;
	int id_graphICS_Sonic_end;

	int id_Selection_main_menu;
	int id_Selection_OK;

	int id_Nave_X;
	int id_Nave_Y;

	int id_HP_counter;
	int id_PW_counter;
	int id_RECORD_counter;
	int id_Num_Fires;	
	int id_SUPER_RECORD_Counter;
	
	int id_LEVEL_counter;
	int id_LEVEL_Dificulty;
	int id_LEVEL_STATUS;
	int id_GAME_OVER;
	
	int id_Next_LEVEL;

	int id_SND_Opening;		
	int id_SND_Lazer;
    int id_SND_Charge;
	int id_SND_Xplot;
    	
    int id_CHANNEL_Lazer;
    int id_CHANNEL_Charge;
    int id_CHANNEL_Xplot;  
	int id_CHANNEL_Opening; 

	int id_Language;
	int id_Firing;
	int id_tmp_X;
	int id_tmp_Y;
	int id_Laser;

    int id_graphICS_Boss1;
    int id_graphICS_Boss1_Select;
    int id_Healty_Boss1;
    int id_BOSS1_Death;
	
	int id_loading_wait;
	int id_loading_wait_mem;
	
	int id_boss_CLLN_majinga;   
	int id_boss_CLLN_fire;      
	int id_majinga_CLLN_fireboss;    	
	
	//DirectCommon_Directory in Sony PlayStation2 hardware(DC_DIR)
	string DC_DIR;	
	
	
    struct MEMORYCARD
		int m_score;
		int m_level;
		int m_language;
	end

	
	/*-------- HEAD FILES ----------------------- */

	include "splash.prg";
	include "gabout.prg";
	include "setup.prg";
	include "starting.prg";
	include "mzfinal.prg";
	include "password.prg";
	include "training.prg";
	include "engine.prg"
	include "boss1.prg";
	include "boss2.prg";
	include "boss3.prg";
	include "movies.prg";
	include "demo.prg";


begin

	//System initialize BGDI for PlayStation 2	
	echo("Mazinger Z the game");
	echo("This game is GNU/GPL v3.0 license");
	echo("(c)Rolando Fernandez Benavidez");
	echo("Nova32 Development Software 2017.");
	
	echo("System initialize BGDI for PlayStation 2");
	set_mode(320,240,32, MODE_DOUBLEBUFFER | MODE_HARDWARE | DOUBLE_BUFFER | HW_SURFACE );	
	set_fps(40, 0);	
    full_screen = false;
	
	//System initialize BGDI for Windows 7 testing
	//set_fps(40, 0);	
	//set_mode(320,240,32,MODE_2XSCALE | MODE_FULLSCREEN);	
    //full_screen = true;

	
	
	

	echo("PlayStation hardware scanning...");
	if(OS_ID ==  PLAYSTATION2_HARDWARE)
		if(file_exists("mass:\\GMLOAD.SYS") )
			DC_DIR = "mass:\\";    //USB DRIVE (FAT32)
		else 
			DC_DIR = "cdrom0:\\";  //DVD-R (8X BURN, DAO)
		end  	  	
	else
	   DC_DIR = "";
	end;	

	
	/*
	 ***********************************************************
	 * NOW LOADING SCREEN ON | PS2...                            *
	 * ========================================================*
	 * You need to draw the image to a few seconds to achieve  * 
	 * deployment on NTSC/PAL based systems.  timer[0]         *
	 ***********************************************************
	*/
	clear_screen();	
	id_loading_wait = load_png(DC_DIR + "GMLOAD.SYS");
	put_screen(0,id_loading_wait);
    frame;
	
	timer[0]=0;
	loop
		if(timer[0] > 10) break; end
		frame;
    end
		
	drawing_color(rgb(255,0,0)); draw_box(10,220,15,230); frame;
		    
	//Load Graphics	
	echo("Load main graphics resources from DVD-R unit");
	
    id_FPG_splash    = load_fpg(DC_DIR + "PSXBOOT.DXD");  draw_box(10,220, 30,230); frame;	
	id_FPG_history   = load_fpg(DC_DIR + "SUN64.DXD");    draw_box(10,220, 60,230); frame;
	id_FPG_starting  = load_fpg(DC_DIR + "LOADER.DXD");	  draw_box(10,220,100,230); frame;
	id_FPG_password  = load_fpg(DC_DIR + "PSW.DXD");      draw_box(10,220,150,230); frame;
	
	
	/*
                             C A U T I O N:	
	*******************************************************************
    * These files were canceled because they exceed the amount of     *
	* files that can read the operating system of the PlayStation2,   *
	* the maximum number of files on a PS2 DVD-R are 43 files,        *
	* regardless of size, ie not more than 4.7 GB.	                  *
	*******************************************************************
	*/
		

	echo("Load levels graphics resources from DVD-R unit");
		
	id_MOV_Intro     = load_fpg(DC_DIR + "INTRO.MOV");     draw_box(10,220,170,230); frame;	
	id_FPG_Mazinger  = load_fpg(DC_DIR + "GMAZING.DXD");   draw_box(10,220,200,230); frame;	
	id_FPG_WAD       = load_fpg(DC_DIR + "KABUTO.WAD");    draw_box(10,220,230,230); frame;	
	id_FPG_Boss1     = load_fpg(DC_DIR + "BOSS01.DXD");    draw_box(10,220,250,230); frame;	
	id_FPG_Boss2     = load_fpg(DC_DIR + "BOSS02.DXD");    draw_box(10,220,270,230); frame;	
	id_FPG_Boss3     = load_fpg(DC_DIR + "BOSS03.DXD");    draw_box(10,220,280,230); frame;	
			
	//LOAD SOUNDS ADX FORMAT: 11,000HZ 8-bits mono, PCM native struct
	echo("Load main FX sounds resources from DVD-R unit");
    id_SND_Xplot   = load_wav(DC_DIR + "XPLOT.ADX");      draw_box(10,220,290,230); frame;
    id_SND_Lazer   = load_wav(DC_DIR + "ACTION.ADX");     draw_box(10,220,300,230); frame;
    id_SND_Charge  = load_wav(DC_DIR + "NEWM.ADX");       draw_box(10,220,310,230); frame;
	
			
	id_Language = 1; // English  2= Spanish
	id_Firing   = 1; // 1=AB  2=BA
	id_VMU_Use  = 1; // 0={Use password system}, 1={Use sony memorycard slot 0}
	id_SUPER_RECORD_Counter = 0; //Gamer record

	echo("Initialize core for MAZINGER Z...");
	delete_draw(0);
	
	verifygpu();	
	
		
	/*----------->>> DEBUG-------------*/
	//setup_s();
	//demo2d();
	//tn_save();
	//About_s();
	//game_over();
	//main_menu();		
	//video_intro();	
	//id_LEVEL_STATUS = 1;
	//starting_level();
	//final_history();
	//splash_boss3();	
	/*-----------DEBUG <<<-------------*/


/*	
	//Breakpoint----------------------------------------------------->
	write(id_FNT_Files,20,150,0,"PS2 debugging break-point:");
	id_SND_track04_CANAL = play_wav(id_SND_track04,-1);
	loop
		frame;
	end	
	//<---------------------------------------------------------------
*/


end



////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//	main_menu                                                                 //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process main_menu();

private

   int m_Pressed1;   //DOWN-L2
   int m_Free1;
   int m_Button_DOWN_SELECT;
   
   int m_Pressed2;  //UP-L1
   int m_Free2;
   int m_Button_UP_SELECT;
   
   int m_Pressed3; //START
   int m_Free3;
   int m_run_demo;

begin

    file = id_FPG_Mazinger;

	id_LEVEL_STATUS = 1;
	
	m_Pressed1      = 0; // DOWN-L2
	m_Free1         = 0; 
	m_Button_DOWN_SELECT =0;
	
	m_Pressed2      = 0; // UP-L1
	m_Free2         = 0; 
	m_Button_UP_SELECT =0;

	m_Pressed3      = 0; // START
	m_Free3         = 0; 


	id_Selection_main_menu=1;
	id_Selection_OK=1;

	id_Axis_Y_Main = 94;
	

	id_HP_counter      = 150;
	id_PW_counter      = 150;
	id_RECORD_counter  = 0;
	id_SUPER_RECORD_Counter=0;
	id_LEVEL_counter   = 1;
	id_LEVEL_Dificulty = 500;

	id_GAME_OVER = 0;

	id_Laser = 0;
		
    //Assign channels and Load Sounds and background music
	id_CHANNEL_Opening = 1;
	id_SND_Opening     = load_wav(DC_DIR + "MZMAIN.ADX");	
	play_wav(id_SND_Opening,SNDENV,id_CHANNEL_Opening);
	
	
	clear_screen();
  
  
    if (id_Language == 1)
        write(0,30,90,0,"Start Game");
        write(0,30,110,0,"Password");
        write(0,30,130,0,"Options");
        write(0,30,150,0,"About");
    else
        write(0,30,90,0,"Nuevo Juego");
        write(0,30,110,0,"Clave");
        write(0,30,130,0,"Opciones");
        write(0,30,150,0,"Creditos");
    end
  
    put_screen(id_FPG_Mazinger,42);
    define_region(1, 0, 210, 320,240);
    start_scroll(0, id_FPG_Mazinger,43,0, 1, 1);
    scroll.camera=id;
    ctype=c_scroll;


	timer[4]=0;
	
loop

	if(timer[4] > 2000)
	
		m_run_demo = rand(1,3);
		
		if(m_run_demo == 2)
			id_Selection_OK = 5;
			break;
		else
			timer[4]=0;
		end
		
	end

    x+=1;
        
	command_dx();

	switch(id_Selection_OK)
		
		case 1:
		      id_Axis_Y_Main=94;
              end
        	    
		case 2:
              id_Axis_Y_Main=114;
              end
        	    
		case 3:
              id_Axis_Y_Main=134;
              end
        	    
		case 4:
              id_Axis_Y_Main=154;
              end
    end
        


          //--------------------DETECTION BUTTON PRESSED AND FREE [DOWN-L2] ----->      
          if(JOY_PS2_L2(0))
             m_Pressed1=1;    
             m_Free1=0;         
          end
          
          if(NOT JOY_PS2_L2(0))
             m_Free1=1;
          end      

          //--------------------DETECTION BUTTON PRESSED AND FREE [UP-L1] ----->      
          if(JOY_PS2_L1(0))
             m_Pressed2=1;    
             m_Free2=0;         
          end
          
          if(NOT JOY_PS2_L1(0))
             m_Free2=1;
          end

          //--------------------DETECTION BUTTON PRESSED AND FREE [START] ----->      
          if(JOY_PS2_START(0) || key(_SPACE))
             m_Pressed3=1;    
             m_Free3=0;         
          end
          
          if(NOT JOY_PS2_START(0))
             m_Free3=1;
          end
          //---------------------------------------------------------->



          if(m_Pressed1 + m_Free1 == 2)     //Event System Button DOWN
             //Clear Buffer for event Button DOWN         
             m_Pressed1=0;
             m_Free1=0;


             if(id_Selection_main_menu < 4)
                id_Selection_main_menu+=1;
             end
             
             
             if(id_Selection_main_menu == 1 && m_Button_DOWN_SELECT == 0)
                id_Selection_OK = 1;
                m_Button_DOWN_SELECT = 1;                
             end
             
             if(id_Selection_main_menu == 2 && m_Button_DOWN_SELECT == 0)
                id_Selection_OK = 2;
                m_Button_DOWN_SELECT = 1;
             end

             if(id_Selection_main_menu == 3 && m_Button_DOWN_SELECT == 0)
                id_Selection_OK = 3;
                m_Button_DOWN_SELECT = 1;
             end

             if(id_Selection_main_menu == 4 && m_Button_DOWN_SELECT == 0)
                id_Selection_OK = 4;
                m_Button_DOWN_SELECT = 1;
             end
             
             m_Button_DOWN_SELECT =0;
             
          end


          if(m_Pressed2 + m_Free2 == 2) //Event System Button UP
             //Clear Buffer for event Button UP      
             m_Pressed2=0;
             m_Free2=0;
             
             if(id_Selection_main_menu > 1)
                id_Selection_main_menu-=1;
             end
             
             
             if(id_Selection_main_menu == 1 && m_Button_DOWN_SELECT == 0)
                id_Selection_OK = 1;
                m_Button_DOWN_SELECT = 1;                
             end
             
             if(id_Selection_main_menu == 2 && m_Button_DOWN_SELECT == 0)
                id_Selection_OK = 2;
                m_Button_DOWN_SELECT = 1;
             end

             if(id_Selection_main_menu == 3 && m_Button_DOWN_SELECT == 0)
                id_Selection_OK = 3;
                m_Button_DOWN_SELECT = 1;
             end

             if(id_Selection_main_menu == 4 && m_Button_DOWN_SELECT == 0)
                id_Selection_OK = 4;
                m_Button_DOWN_SELECT = 1;
             end
             
             m_Button_DOWN_SELECT =0;

             
          end


          if(m_Pressed3 + m_Free3 == 2) //Event System Button START
             //Clear Buffer for event Button START      
             m_Pressed3=0;
             m_Free3=0;
             
             break;
             
          end


        
     frame;
  end
    

      stop_scroll(0);	
      
      //Load game
      if (id_Selection_OK == 1)
		
		stop_wav(id_CHANNEL_Opening);
		unload_wav(id_SND_Opening);
		delete_Text(0);
		video_intro();
					
      end

      //Load password
      if (id_Selection_OK == 2)
		
		stop_wav(id_CHANNEL_Opening);
		unload_wav(id_SND_Opening);      	
		delete_Text(0);
      	
		if(id_VMU_Use == 0)
			password_cwb();   //PASSWORD SYSTEM 
		else
			ps2_mc();         //MEMORYCARD
		end			
			
      end

      //Load options
      if (id_Selection_OK == 3)

		stop_wav(id_CHANNEL_Opening);
		unload_wav(id_SND_Opening);
		delete_Text(0);
      	setup_s();	
		
      end


      //Load about
      if (id_Selection_OK == 4)

		stop_wav(id_CHANNEL_Opening);
		unload_wav(id_SND_Opening);     			
		delete_Text(0);
      	about_s();	
		
      end

      
      //Load demo
      if (id_Selection_OK == 5)

		stop_wav(id_CHANNEL_Opening);
		unload_wav(id_SND_Opening);     			
		delete_Text(0);
      	demo2d();	
		
      end


	  
end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:command_dx                                                         //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process command_dx();
begin
    file = id_FPG_Mazinger;
	graph=1;
	x=15;
	y=id_Axis_Y_Main;
	z=0;
	size=100;
	frame;
end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process game_over                                                          //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process game_over();
begin

	id_CHANNEL_Opening = 1;
	id_SND_Opening     = load_wav(DC_DIR + "GOVER.ADX");
	play_wav(id_SND_Opening,1,id_CHANNEL_Opening);


    file = id_FPG_Mazinger;
	clear_screen();		
    graph=44;
    x=164;
    y=120;
    z=0;

	timer[0]=0;
	
    loop

	
	   if(timer[0] > 1050)
		  break;
	   end
	
	   //if(JOY_PS2_TRIANGLE(0))
	   //  break;
	   //end

       frame;
	   
    end

	stop_wav(id_CHANNEL_Opening);
	unload_wav(id_SND_Opening);	
	delete_text(0);
	
	main_menu();
end

