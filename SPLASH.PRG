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
// PROCESS: setdualshock()                                                   //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process setdualshock(pcontroller,pintensity)
begin

    if(pintensity < 0)
		pintensity = 0;
	end

    if(pintensity > 255)
		pintensity = 255;
	end
	
	timer[9]=0;
	
    //Parameters (gamepad-port, typeengine, intensity 0..255)
	IOSYS_CALL_DUALSHOCK(pcontroller,BIGENGINE_DS, pintensity);

    loop
        frame;	
        if(timer[9] > 100)
           break;
        end               
    end	
		
	IOSYS_CALL_DUALSHOCK(pcontroller,BIGENGINE_DS,NOTHING);

end


////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// PROCESS: verifygpu                                                         //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process verifygpu();
private    	
	int m_Memory_RAM_Free;
	int m_Memory_RAM_Total;
begin
    
	m_Memory_RAM_Free  = IOSYS_CALL_RAM_FREE();
	m_Memory_RAM_Total = IOSYS_CALL_RAM_TOTAL();
	
	#ifdef PS2_KERNEL_DBG

		clear_screen();
	
		write    (0,10,10,0,"Memory RAM TOTAL: (mb)");
		write_int(0,10,20,0,&m_Memory_RAM_Total);      //RAM AVAILABLE IN PS2 HARDWARE BEFORE IO.SYS,IRX,PADS LOAD.

		write    (0,10,40,0,"Memory RAM FREE: (mb)");
		write_int(0,10,50,0,&m_Memory_RAM_Free);
		
		timer[0]=0;
		loop
		
			if(timer[0] > 2000)
				break;
			end
			
			frame;
		end
		
		delete_text(0);
		
	#endif
	

	if (OS_ID !=  PLAYSTATION2_HARDWARE)
       
   	   set_mode(640,480,16);
   	   clear_screen();
   	   
    
       write(0,20,30,0,"This game requires PlayStation 2 hardware model SCPH-77001 or compatible");
       write(0,20,40,0,"and load from the DVD-ROM unit. The load of the game has been cancelled.");
       write(0,20,150,0,"Use PlayStation 2 SCPH series only.");
              
       timer[0]=0;
       
       loop       
            if(timer[0] > 6000)
               break;
            end
            
            if(Key(_esc))
               break;
            end
       
            frame;
       end
    
       exit("ERROR:Hardware PlayStation2 not available, stop run program.",100);
    
    else
       //---> Hardware PlayStation2 Detected
       //---> Continue Load Game...
    end


	
nova32();

end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// PROCESS: nova32                                                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process nova32();

begin
    file = id_FPG_splash;
	clear_screen();


	//Initializing for FRAMES....and...system............----->

	id_GRAPHICS_Sonic = 2;  // Nex to graphics 25.
	id_GRAPHICS_Sonic_Select = 0;  
	id_GRAPHICS_Sonic_END = 0;

	//--------------------------------------------------------->

timer[0]=0;

graph=1;
x=162;
y=119;
z=0;
size=100;


        loop

		if( timer[0] > 400 )
			break;
                end

		frame;

        end

	PSXStartup();

END


////////////////////////////////////////////////////////////////////////////////
// PROCESS: PSXStartup()                                                      //
// Sonic presentations Procedure                                              //
////////////////////////////////////////////////////////////////////////////////

process PSXStartup();
private
   int m_CHANNEL_track;
   int m_SND_track;   
begin

//Assign channel of playstation2 hardware, 16 channels available.
//Sony CHIP 4335KSZ PS2 model 77001.
m_CHANNEL_track = 1;
  
//Load in RAM soundtrack
m_SND_track = load_wav(DC_DIR + "PSXSTD.ADX");
play_wav(m_SND_track  ,SNDENV, m_CHANNEL_track);
	   
file = id_FPG_splash;
clear_screen();
	
timer[0]=0; 
timer[1]=0;	   
     
     loop
     
        
        
        if (timer[1] > 1300)
        	break;
        end
        
        
        //-----Timer[0]-------- Timer code resembling VB 
        //Timer1 will be activated less than every 10 milliseconds. 1= second = 100
        
	if (timer[0] > 30)
        
           
           if (id_GRAPHICS_Sonic == 2 and id_GRAPHICS_Sonic_Select == 0)
           		 id_GRAPHICS_Sonic = 3;
           		 id_GRAPHICS_Sonic_Select = 1;
           end
           
           if (id_GRAPHICS_Sonic == 3 and id_GRAPHICS_Sonic_Select == 0)
           		 id_GRAPHICS_Sonic = 4;                                    
           		 id_GRAPHICS_Sonic_Select = 1;
           end
           
           IF (id_GRAPHICS_Sonic == 4 AND id_GRAPHICS_Sonic_Select == 0)
           		 id_GRAPHICS_Sonic = 5;                                    
           		 id_GRAPHICS_Sonic_Select = 1;
           END


           IF (id_GRAPHICS_Sonic == 5 AND id_GRAPHICS_Sonic_Select == 0)
           		 id_GRAPHICS_Sonic = 6;                                    
           		 id_GRAPHICS_Sonic_Select = 1;
           END


           IF (id_GRAPHICS_Sonic == 6 AND id_GRAPHICS_Sonic_Select == 0)
           		 id_GRAPHICS_Sonic = 7;                                    
           		 id_GRAPHICS_Sonic_Select = 1;
           END


           IF (id_GRAPHICS_Sonic == 7 AND id_GRAPHICS_Sonic_Select == 0)
           		 id_GRAPHICS_Sonic = 8;                                    
           		 id_GRAPHICS_Sonic_Select = 1;
           END


           IF (id_GRAPHICS_Sonic == 8 AND id_GRAPHICS_Sonic_Select == 0)
           		 id_GRAPHICS_Sonic = 9;                                    
           		 id_GRAPHICS_Sonic_Select = 1;
           END


           IF (id_GRAPHICS_Sonic == 9 AND id_GRAPHICS_Sonic_Select == 0)
           		 id_GRAPHICS_Sonic = 10;                                    
           		 id_GRAPHICS_Sonic_Select = 1;
           END

           IF (id_GRAPHICS_Sonic == 10 AND id_GRAPHICS_Sonic_Select == 0)
           		 id_GRAPHICS_Sonic = 11;                                    
           		 id_GRAPHICS_Sonic_Select = 1;
           END

           IF (id_GRAPHICS_Sonic == 11 AND id_GRAPHICS_Sonic_Select == 0)
           		 id_GRAPHICS_Sonic = 12;                                    
           		 id_GRAPHICS_Sonic_Select = 1;
           END


           IF (id_GRAPHICS_Sonic == 12 AND id_GRAPHICS_Sonic_Select == 0)
           		 id_GRAPHICS_Sonic = 13;                                    
           		 id_GRAPHICS_Sonic_Select = 1;
           END


           IF (id_GRAPHICS_Sonic == 13 AND id_GRAPHICS_Sonic_Select == 0)
           		 id_GRAPHICS_Sonic = 14;                                    
           		 id_GRAPHICS_Sonic_Select = 1;
           END

           IF (id_GRAPHICS_Sonic == 14 AND id_GRAPHICS_Sonic_Select == 0)
           		 id_GRAPHICS_Sonic = 15;                                    
           		 id_GRAPHICS_Sonic_Select = 1;
           END

           IF (id_GRAPHICS_Sonic == 15 AND id_GRAPHICS_Sonic_Select == 0)
           		 id_GRAPHICS_Sonic = 16;                                    
           		 id_GRAPHICS_Sonic_Select = 1;
           END

           IF (id_GRAPHICS_Sonic == 16 AND id_GRAPHICS_Sonic_Select == 0)
           		 id_GRAPHICS_Sonic = 17;                                    
           		 id_GRAPHICS_Sonic_Select = 1;
           END

           IF (id_GRAPHICS_Sonic == 17 AND id_GRAPHICS_Sonic_Select == 0)
           		 id_GRAPHICS_Sonic = 18;                                    
           		 id_GRAPHICS_Sonic_Select = 1;
           END

           IF (id_GRAPHICS_Sonic == 18 AND id_GRAPHICS_Sonic_Select == 0)
           		 id_GRAPHICS_Sonic = 19;                                    
           		 id_GRAPHICS_Sonic_Select = 1;
           END

           IF (id_GRAPHICS_Sonic == 19 AND id_GRAPHICS_Sonic_Select == 0)
           		 id_GRAPHICS_Sonic = 20;                                    
           		 id_GRAPHICS_Sonic_Select = 1;
           END

           IF (id_GRAPHICS_Sonic == 20 AND id_GRAPHICS_Sonic_Select == 0)
           		 id_GRAPHICS_Sonic = 21;                                    
           		 id_GRAPHICS_Sonic_Select = 1;
           END

           IF (id_GRAPHICS_Sonic == 21 AND id_GRAPHICS_Sonic_Select == 0)
           		 id_GRAPHICS_Sonic = 22;                                    
           		 id_GRAPHICS_Sonic_Select = 1;
           END

           IF (id_GRAPHICS_Sonic == 22 AND id_GRAPHICS_Sonic_Select == 0)
           		 id_GRAPHICS_Sonic = 23;                                    
           		 id_GRAPHICS_Sonic_Select = 1;
           END

           IF (id_GRAPHICS_Sonic == 23 AND id_GRAPHICS_Sonic_Select == 0)
           		 id_GRAPHICS_Sonic = 24;                                    
           		 id_GRAPHICS_Sonic_Select = 1;
           END

           IF (id_GRAPHICS_Sonic == 24 AND id_GRAPHICS_Sonic_Select == 0)
           		 id_GRAPHICS_Sonic = 25;                                    
           		 id_GRAPHICS_Sonic_Select = 1;
           END

           IF (id_GRAPHICS_Sonic == 25 AND id_GRAPHICS_Sonic_Select == 0)
           		 id_GRAPHICS_Sonic = 24;                                    
           		 id_GRAPHICS_Sonic_Select = 1;
           		 id_GRAPHICS_Sonic_END = 1;
           END



           IF (id_GRAPHICS_Sonic_END == 0)
           		id_GRAPHICS_Sonic_Select = 0;
           ELSE
              id_GRAPHICS_Sonic_Select = 1;
           END
           
           //Reset Selection and Timer
           timer[0]=0;
        END
        //----Timer[0]---------End Code              



                clear_screen();
				graph=id_GRAPHICS_Sonic;
				x=161;
				y=120;
				z=0;
				//size=250;




        frame;

     end
    
	timer[0]=0; 
	timer[1]=0;	
	
	stop_wav(m_CHANNEL_track);
	unload_wav(m_SND_track);
	
    main_menu();
    
end

