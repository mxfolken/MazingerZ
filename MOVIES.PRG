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
// PROCESS: video_intro()                                                     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process video_intro();
private
   int m_CHANNEL_track;
   int m_SND_track; 
   int m_GFX_Frame;
   int m_GFX_Frame_Selected;
   int m_GFX_Frame_Finished;
begin

//Assign channel of playstation2 hardware, 16 channels available.
//Sony CHIP 4335KSZ PS2 model 77001.
m_CHANNEL_track = 1;
  
//Load in RAM soundtrack
m_SND_track = load_wav(DC_DIR + "INTRO.MOS");
play_wav(m_SND_track  ,SNDENV, m_CHANNEL_track);
	   
file = id_MOV_Intro;

clear_screen();
graph=1;
x=160;
y=120;
z=0;

	
timer[0]=0; 
timer[1]=0;	 

m_GFX_Frame          = 0;
m_GFX_Frame_Selected = 0;
m_GFX_Frame_Finished = 0;  


	
	loop
		if(timer[0] > 500)
			break;
		end
		frame;
	end

	timer[0] = 0;
     
     loop
     
        
        
        if (timer[1] > 2500)
        	break;
        end
        
        
        //-----Timer[0]-------- Timer code resembling VB 
        //Timer1 will be activated less than every 10 milliseconds. 1= second = 100
        
	if (timer[0] > 20)
        

           if (m_GFX_Frame == 0 and m_GFX_Frame_Selected == 0)
           		 m_GFX_Frame = 1;
           		 m_GFX_Frame_Selected = 1;
           end
				
           if (m_GFX_Frame == 1 and m_GFX_Frame_Selected == 0)
           		 m_GFX_Frame = 2;
           		 m_GFX_Frame_Selected = 1;
           end
		
           if (m_GFX_Frame == 2 and m_GFX_Frame_Selected == 0)
           		 m_GFX_Frame = 3;
           		 m_GFX_Frame_Selected = 1;
           end
           
           if (m_GFX_Frame == 3 and m_GFX_Frame_Selected == 0)
           		 m_GFX_Frame = 4;                                    
           		 m_GFX_Frame_Selected = 1;
           end
           
           IF (m_GFX_Frame == 4 AND m_GFX_Frame_Selected == 0)
           		 m_GFX_Frame = 5;                                    
           		 m_GFX_Frame_Selected = 1;
           END


           IF (m_GFX_Frame == 5 AND m_GFX_Frame_Selected == 0)
           		 m_GFX_Frame = 6;                                    
           		 m_GFX_Frame_Selected = 1;
           END


           IF (m_GFX_Frame == 6 AND m_GFX_Frame_Selected == 0)
           		 m_GFX_Frame = 7;                                    
           		 m_GFX_Frame_Selected = 1;
           END


           IF (m_GFX_Frame == 7 AND m_GFX_Frame_Selected == 0)
           		 m_GFX_Frame = 8;                                    
           		 m_GFX_Frame_Selected = 1;
           END


           IF (m_GFX_Frame == 8 AND m_GFX_Frame_Selected == 0)
           		 m_GFX_Frame = 9;                                    
           		 m_GFX_Frame_Selected = 1;
           END


           IF (m_GFX_Frame == 9 AND m_GFX_Frame_Selected == 0)
           		 m_GFX_Frame = 10;                                    
           		 m_GFX_Frame_Selected = 1;
           END

           IF (m_GFX_Frame == 10 AND m_GFX_Frame_Selected == 0)
           		 m_GFX_Frame = 11;                                    
           		 m_GFX_Frame_Selected = 1;
           END

           IF (m_GFX_Frame == 11 AND m_GFX_Frame_Selected == 0)
           		 m_GFX_Frame = 12;                                    
           		 m_GFX_Frame_Selected = 1;
           END


           IF (m_GFX_Frame == 12 AND m_GFX_Frame_Selected == 0)
           		 m_GFX_Frame = 13;                                    
           		 m_GFX_Frame_Selected = 1;
           END


           IF (m_GFX_Frame == 13 AND m_GFX_Frame_Selected == 0)
           		 m_GFX_Frame = 14;                                    
           		 m_GFX_Frame_Selected = 1;
           END

           IF (m_GFX_Frame == 14 AND m_GFX_Frame_Selected == 0)
           		 m_GFX_Frame = 15;                                    
           		 m_GFX_Frame_Selected = 1;
           END

           IF (m_GFX_Frame == 15 AND m_GFX_Frame_Selected == 0)
           		 m_GFX_Frame = 16;                                    
           		 m_GFX_Frame_Selected = 1;
           END

           IF (m_GFX_Frame == 16 AND m_GFX_Frame_Selected == 0)
           		 m_GFX_Frame = 17;                                    
           		 m_GFX_Frame_Selected = 1;
           END

           IF (m_GFX_Frame == 17 AND m_GFX_Frame_Selected == 0)
           		 m_GFX_Frame = 18;                                    
           		 m_GFX_Frame_Selected = 1;
           END

           IF (m_GFX_Frame == 18 AND m_GFX_Frame_Selected == 0)
           		 m_GFX_Frame = 19;                                    
           		 m_GFX_Frame_Selected = 1;
           END

           IF (m_GFX_Frame == 19 AND m_GFX_Frame_Selected == 0)
           		 m_GFX_Frame = 20;                                    
           		 m_GFX_Frame_Selected = 1;
           END

           IF (m_GFX_Frame == 20 AND m_GFX_Frame_Selected == 0)
           		 m_GFX_Frame = 21;                                    
           		 m_GFX_Frame_Selected = 1;
           END

           IF (m_GFX_Frame == 21 AND m_GFX_Frame_Selected == 0)
           		 m_GFX_Frame = 22;                                    
           		 m_GFX_Frame_Selected = 1;
           END

           IF (m_GFX_Frame == 22 AND m_GFX_Frame_Selected == 0)
           		 m_GFX_Frame = 23;                                    
           		 m_GFX_Frame_Selected = 1;
           END

           IF (m_GFX_Frame == 23 AND m_GFX_Frame_Selected == 0)
           		 m_GFX_Frame = 24;                                    
           		 m_GFX_Frame_Selected = 1;
           END

           IF (m_GFX_Frame == 24 AND m_GFX_Frame_Selected == 0)
           		 m_GFX_Frame = 25;                                    
           		 m_GFX_Frame_Selected = 1;
           END

           IF (m_GFX_Frame == 25 AND m_GFX_Frame_Selected == 0)
           		 m_GFX_Frame = 26;                                    
           		 m_GFX_Frame_Selected = 1;           		 
           END

           IF (m_GFX_Frame == 26 AND m_GFX_Frame_Selected == 0)
           		 m_GFX_Frame = 27;                                    
           		 m_GFX_Frame_Selected = 1;           		 
           END

           IF (m_GFX_Frame == 27 AND m_GFX_Frame_Selected == 0)
           		 m_GFX_Frame = 27;                                    
           		 m_GFX_Frame_Selected = 1;
           		 m_GFX_Frame_Finished = 1;
           END
		   

           IF (m_GFX_Frame_Finished == 0)
           		m_GFX_Frame_Selected = 0;
           ELSE
              m_GFX_Frame_Selected = 1;
           END
           
           //Reset Selection and Timer
           timer[0]=0;
        END
        //----Timer[0]---------End Code              



                //clear_screen();
				graph=m_GFX_Frame;
				x=160;
				y=120;
				z=0;
				




        frame;

     end
    
	timer[0]=0; 
	timer[1]=0;	
	
	stop_wav(m_CHANNEL_track);
	unload_wav(m_SND_track);
	
   	id_LEVEL_STATUS=1;
	starting_level();

    
end

