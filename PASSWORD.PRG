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
// process ps2_mc()                                                           //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process ps2_mc()
begin

file = id_FPG_password;
clear_screen();

//Use password system
if (id_Language == 1)
	Graph=6; //spanish
else
	Graph=7; //english
end

x=161;
y=126;
z=0;

    timer[0] = 0;
	
    loop       
        if(timer[0] > 800)
           break;
        end               
        frame;
    end	

	if(IOSYS_CALL_MC_LOAD("MAZINGER", MEMORYCARD, sizeof(MEMORYCARD),PS2_MEMORY_CARD1))	//8 CHARS MAX	
		id_LEVEL_STATUS         = MEMORYCARD.m_level;
        id_SUPER_RECORD_Counter = MEMORYCARD.m_score;
		id_Language             = MEMORYCARD.m_language;
		Starting_Level();  
	else
	    //ERROR ON READ SONY MEMORYCARD
		Graph=8;		
        timer[0]=0;
		loop   
			if(timer[0] > 300)
				break;
			end
		frame;
		end		
		main_menu();
	end
	
	
end


////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// password_cwb                                                               //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

PROCESS password_cwb()

PRIVATE

       int m_ID_KEY1;
       int m_ID_KEY2;
       int m_ID_KEY3;

       int m_KEY_1;
       int m_KEY_2;
       int m_KEY_3;
       
       int m_FNT_Files;
       int m_KEY_NUM;
       int m_KEY_SELECTION;

       int m_Time_Button_A;
       int m_Pointer_Position;
       int m_Time_Button_UP;
       int m_Time_Button_DOWN;

       int m_KEY_TRUE;
       
       int m_Pressed1;   //Button (X)
       int m_Free1;
       
       int m_Pressed2;   //Button (UP-L1)
       int m_Free2;

       int m_Pressed3;   //Button (DOWN-L2)
       int m_Free3;


BEGIN

m_KEY_NUM = 1;
m_KEY_SELECTION=0;
m_Time_Button_A=1;
m_Pointer_Position=1;
m_Time_Button_UP=1;
m_Time_Button_DOWN=1;
m_KEY_TRUE = 0;

file = id_FPG_password;
clear_screen();


//Use password system
if (id_Language == 1)
	Graph=1; //spanish
else
	Graph=2; //english
end
   
    m_ID_KEY1 = write_int(m_FNT_Files,160,170,0,&m_KEY_1);
    m_ID_KEY2 = write_int(m_FNT_Files,210,170,0,&m_KEY_2);
    m_ID_KEY3 = write_int(m_FNT_Files,270,170,0,&m_KEY_3);
	
x=161;
y=126;
z=0;

   loop

          //--------------------DETECTION BUTTON PRESSED AND FREE (X) ----->      
          if(JOY_PS2_CROSS(0))
             m_Pressed1=1;    
             m_Free1=0;         
          end
          
          if(NOT JOY_PS2_CROSS(0))
             m_Free1=1;
          end      
          //--------------------DETECTION BUTTON PRESSED AND FREE [UP-L1] ----->      
          if(JOY_PS2_L1(0) )
             m_Pressed2=1;    
             m_Free2=0;         
          end
          
          if(NOT JOY_PS2_L1(0) )
             m_Free2=1;
          end      

          //--------------------DETECTION BUTTON PRESSED AND FREE [DOWN-L2] ----->      
          if(JOY_PS2_L2(0) )
             m_Pressed3=1;    
             m_Free3=0;         
          end
          
          if(NOT JOY_PS2_L2(0))
             m_Free3=1;
          end      


          //---------------------------------------------------------------->

          if(m_Pressed1 + m_Free1 == 2)     //Event System Button (X)
             //Clear Buffer for event Button (X)      
             m_Pressed1=0;
             m_Free1=0;
   
   
             if(m_KEY_NUM == 1 && m_KEY_SELECTION == 0)
                m_KEY_NUM =2;
                m_KEY_SELECTION =1;
                m_Pointer_Position=2;
             end   

             if(m_KEY_NUM == 2 && m_KEY_SELECTION == 0)
                m_KEY_NUM =3;
                m_KEY_SELECTION =1;
                m_Pointer_Position=3;
             end   

             if(m_KEY_NUM == 3 && m_KEY_SELECTION == 0)
                BREAK;
             end

             m_KEY_SELECTION = 0;
        end
   
//------------------------------------------
if(m_KEY_NUM==1)

          if(m_Pressed2 + m_Free2 == 2)     //Event System Button UP-L1
             //Clear Buffer for event Button UP-L1      
             m_Pressed2=0;
             m_Free2=0;
             
                if(m_KEY_1 < 9)
                m_KEY_1+=1;
                end
             
             
          end

          if(m_Pressed3 + m_Free3 == 2)     //Event System Button DOWN-L2
             //Clear Buffer for event Button DOWN-L2  
             m_Pressed3=0;
             m_Free3=0;
             
             
                if(m_KEY_1 > 0)
                m_KEY_1-=1;
                end

             
          end


end
//------------------------------------------
if(m_KEY_NUM==2)

          if(m_Pressed2 + m_Free2 == 2)     //Event System Button UP-L1
             //Clear Buffer for event Button UP-L1      
             m_Pressed2=0;
             m_Free2=0;
             
                if(m_KEY_2 < 9)
                m_KEY_2+=1;
                end
          
             
          end

          if(m_Pressed3 + m_Free3 == 2)     //Event System Button DOWN-L2
             //Clear Buffer for event Button DOWN-L2  
             m_Pressed3=0;
             m_Free3=0;
             
                if(m_KEY_2 > 0)
                m_KEY_2-=1;
                end
          
             
          end


end
//------------------------------------------
if(m_KEY_NUM==3)

          if(m_Pressed2 + m_Free2 == 2)     //Event System Button UP-L1
             //Clear Buffer for event Button UP-L1      
             m_Pressed2=0;
             m_Free2=0;
             
                if(m_KEY_3 < 9)
                m_KEY_3+=1;
                end
          
             
          end

          if(m_Pressed3 + m_Free3 == 2)     //Event System Button DOWN-L2
             //Clear Buffer for event Button DOWN-L2  
             m_Pressed3=0;
             m_Free3=0;
             
                if(m_KEY_3 > 0)
                m_KEY_3-=1;
                end
             
             
          end


end

//-------------------------------------------
   pointer_ps(m_Pointer_Position);

   FRAME;
   end
   
   delete_text(0);
   
//----------------> DETERMINATION LEVEL PASSWORD OK
   
   if(m_KEY_1 == 2 && m_KEY_2 == 7 && m_KEY_3 == 9)         
      signal(TYPE Pointer_ps,s_kill);
      //Level 1
      id_LEVEL_STATUS = 1;
      m_KEY_TRUE = 1;
      Starting_Level();  
   end
   
   if(m_KEY_1 == 2 && m_KEY_2 == 2 && m_KEY_3 == 6)  
      signal(TYPE Pointer_ps,s_kill);
      //Level 2
      id_LEVEL_STATUS = 2;
      m_KEY_TRUE = 1;
      Starting_Level();  
   end

   if(m_KEY_1 == 6 && m_KEY_2 == 2 && m_KEY_3 == 4)  
      signal(TYPE Pointer_ps,s_kill);
      //Level 3
      id_LEVEL_STATUS = 3;
      m_KEY_TRUE = 1;
      Starting_Level();  
   end

   if(m_KEY_1 == 4 && m_KEY_2 == 7 && m_KEY_3 == 9)  
      signal(TYPE Pointer_ps,s_kill);
      //Level 4
      id_LEVEL_STATUS = 4;
      m_KEY_TRUE = 1;
      Starting_Level();  
   end

   if(m_KEY_1 == 3 && m_KEY_2 == 3 && m_KEY_3 == 8)
      signal(TYPE Pointer_ps,s_kill);
      //Level 5
      id_LEVEL_STATUS = 5;
      m_KEY_TRUE = 1;
      Starting_Level();  
   end

   if(m_KEY_1 == 8 && m_KEY_2 == 6 && m_KEY_3 == 5) 
      signal(TYPE Pointer_ps,s_kill);
      //Level 6
      id_LEVEL_STATUS = 6;
      m_KEY_TRUE = 1;
      Starting_Level();  
   end

   if(m_KEY_1 == 6 && m_KEY_2 == 9 && m_KEY_3 == 7)
      signal(TYPE Pointer_ps,s_kill);
      //Level 7
      id_LEVEL_STATUS = 7;
      m_KEY_TRUE = 1;
      Starting_Level();  
   end

   if(m_KEY_1 == 3 && m_KEY_2 == 6 && m_KEY_3 == 1)
      signal(TYPE Pointer_ps,s_kill);
      //Level 8
      id_LEVEL_STATUS = 8;
      m_KEY_TRUE = 1;
      Starting_Level();  
   end

   if(m_KEY_1 == 8 && m_KEY_2 == 5 && m_KEY_3 == 1)    
      signal(TYPE Pointer_ps,s_kill);
      //Level 9
      id_LEVEL_STATUS = 9;
      m_KEY_TRUE = 1;
      Starting_Level();  
   end

   if(m_KEY_1 == 9 && m_KEY_2 == 3 && m_KEY_3 == 7)  
      signal(TYPE Pointer_ps,s_kill);
      //Level 10
      id_LEVEL_STATUS = 10;
      m_KEY_TRUE = 1;
      Starting_Level();  
   end

//-----------------NOT Password TRUE

if(m_KEY_TRUE == 0)      
   Timer[0]=0;

   if(id_Language == 1)
      Graph=5;
   else
      Graph=3;
   end
   
   loop   
   
       if(timer[0] > 200)
          BREAK;
       end
   
   FRAME;
   end
   
   signal(TYPE Pointer_ps,s_kill);
   main_menu();

end
   
END

////////////////////////////////
//
// Pointer
//
////////////////////////////////

PROCESS Pointer_ps(m_Position)

BEGIN

file = id_FPG_password;
graph=4;

if(m_Position == 1)
   x=147;
   y=180;
end

if(m_Position == 2)
   x=201;
   y=180;
end

if(m_Position == 3)
   x=261;
   y=180;
end


z=0;
size=40;

FRAME;

END





