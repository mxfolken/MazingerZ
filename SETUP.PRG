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
// PROCESS: Setup_s                                                           //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

PROCESS Setup_s()

PRIVATE

    STRING s_Text_Fire;
    STRING s_Text_Dialog;
    STRING s_Text_Message;
    
    STRING s_SELECTION_Fire;
    STRING s_SELECTION_Dialog;

	int s_tmp_x;
	int s_tmp_y;
	int s_WND_Show_Window;
	int s_ICON_Active;

	int s_Selection_main_menu;   
	int s_Selection_OK;
	int s_Axis_Y_Main;
	
   int m_Pressed1;   //(DOWN-L2)
   int m_Free1;
   int m_Button_DOWN_SELECT;
   
   int m_Pressed2;  //(UP-L1)
   int m_Free2;
   int m_Button_UP_SELECT;
	
   int m_Pressed3; // (X)
   int m_Free3;


BEGIN

    file = id_FPG_Mazinger;

	s_Selection_main_menu=1;
	s_Selection_OK=1;
	s_Axis_Y_Main = 27;
	s_WND_Show_Window=3;

    s_Text_Fire = "FIRE:";
    s_Text_Dialog = "DIALOG:";
    s_Text_Message = "[L1] or [L2]";
    s_SELECTION_Fire=" ";
    s_SELECTION_Dialog=" ";
    s_ICON_Active = 1;
	
	put_screen(id_FPG_Mazinger,34);
	
	Graph=35;
	x=37;
	y=27;
	z=0;

    write(0,70,200,0," [L1] [L2] Select icons setup.");
    write(0,70,210,0," Button (X) = OK");

    write_string(0,100,120,0,&s_Text_Fire);
    write_string(0,100,130,0,&s_Text_Dialog);
    write_string(0,100,150,0,&s_Text_Message);
    write_string(0,180,120,0,&s_SELECTION_Fire);
    write_string(0,180,130,0,&s_SELECTION_Dialog);
    

	loop


	y = s_Axis_Y_Main;

	// =====================================
	SWITCH (s_Selection_OK)        
		
		CASE 1: 
                   s_Axis_Y_Main=27;
                   s_WND_Show_Window=36;
                   s_ICON_Active=1;
                   s_tmp_x=163;
                   s_tmp_y=121;
                   s_Text_Fire = "FIRE:";
                   s_Text_Dialog = "DIALOG:";
                   s_Text_Message = "[R1] or [R2]";
                   if ( id_Firing == 1)
                   s_SELECTION_Fire =   "X";
                   s_SELECTION_Dialog = "O";
                   else
                   s_SELECTION_Fire =   "O";
                   s_SELECTION_Dialog = "X";                   
                   end
        END
        	    
		CASE 2: 
                   s_Axis_Y_Main=87;
                   s_WND_Show_Window=37;
                   s_ICON_Active=2;
                   s_tmp_x=163;
                   s_tmp_y=121;
                   s_Text_Fire = " ";
                   s_Text_Dialog = "CHOICE:";
                   s_Text_Message = "[R1] or [R2]";
                   if ( id_Language == 1)
                   s_SELECTION_Fire =   " ";
                   s_SELECTION_Dialog = "English";
                   else
                   s_SELECTION_Fire =   " ";
                   s_SELECTION_Dialog = "Espanish";                   
                   end                                                        
        END
        	    
		CASE 3: 
                   s_Axis_Y_Main=145;
                   s_WND_Show_Window=38;
                   s_ICON_Active=3;
                   s_tmp_x=163;
                   s_tmp_y=121;
                   s_Text_Fire = "Use password system";
                   s_Text_Dialog = "CHOICE:";
                   s_Text_Message = "[R1] or [R2]";
                   if ( id_VMU_Use == 1)
                   s_SELECTION_Fire =   " ";
                   s_SELECTION_Dialog = "YES";
                   else
                   s_SELECTION_Fire =   " ";
                   s_SELECTION_Dialog = "NOT";                   
                   end                                      
        END
        	    
		CASE 4: 
                   s_Axis_Y_Main=202;
                   s_WND_Show_Window=39;
                   s_ICON_Active=4;
                   s_tmp_x=163;
                   s_tmp_y=121;
                   s_Text_Fire = " ";
                   s_Text_Dialog = " ";
                   s_Text_Message = " ";
                   s_SELECTION_Fire =   " ";
                   s_SELECTION_Dialog = " ";
                   
                   
                   
        END                
    END


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

          //--------------------DETECTION BUTTON PRESSED AND FREE (X) ----->      
          if(JOY_PS2_CROSS(0))
             m_Pressed3=1;    
             m_Free3=0;         
          end
          
          if(NOT JOY_PS2_CROSS(0))
             m_Free3=1;
          end
          //---------------------------------------------------------->


          if(m_Pressed1 + m_Free1 == 2)     //Event System Button DOWN-L2
             //Clear Buffer for event Button DOWN-L2         
             m_Pressed1=0;
             m_Free1=0;


             if(s_Selection_main_menu < 4)
                s_Selection_main_menu+=1;
             end
             
             
             if(s_Selection_main_menu == 1 && m_Button_DOWN_SELECT == 0)
                s_Selection_OK = 1;
                m_Button_DOWN_SELECT = 1;                
             end
             
             if(s_Selection_main_menu == 2 && m_Button_DOWN_SELECT == 0)
                s_Selection_OK = 2;
                m_Button_DOWN_SELECT = 1;
             end

             if(s_Selection_main_menu == 3 && m_Button_DOWN_SELECT == 0)
                s_Selection_OK = 3;
                m_Button_DOWN_SELECT = 1;
             end

             if(s_Selection_main_menu == 4 && m_Button_DOWN_SELECT == 0)
                s_Selection_OK = 4;
                m_Button_DOWN_SELECT = 1;
             end
             
             m_Button_DOWN_SELECT =0;
             
          end


          if(m_Pressed2 + m_Free2 == 2) //Event System Button UP-L1
             //Clear Buffer for event Button UP-L1      
             m_Pressed2=0;
             m_Free2=0;
             
             if(s_Selection_main_menu > 1)
                s_Selection_main_menu-=1;
             end
             
             
             if(s_Selection_main_menu == 1 && m_Button_DOWN_SELECT == 0)
                s_Selection_OK = 1;
                m_Button_DOWN_SELECT = 1;                
             end
             
             if(s_Selection_main_menu == 2 && m_Button_DOWN_SELECT == 0)
                s_Selection_OK = 2;
                m_Button_DOWN_SELECT = 1;
             end

             if(s_Selection_main_menu == 3 && m_Button_DOWN_SELECT == 0)
                s_Selection_OK = 3;
                m_Button_DOWN_SELECT = 1;
             end

             if(s_Selection_main_menu == 4 && m_Button_DOWN_SELECT == 0)
                s_Selection_OK = 4;
                m_Button_DOWN_SELECT = 1;
             end
             
             m_Button_DOWN_SELECT =0;

             
          end


  
        if (JOY_PS2_R1(0))
           
           if (s_ICON_Active == 1)
              id_Firing = 2;
           end

           if (s_ICON_Active == 2)
              id_Language = 2;
           end

           if (s_ICON_Active == 3)
              id_VMU_Use = 1;
           end

           
        end

        if (JOY_PS2_R2(0))
        
           if (s_ICON_Active == 1)
              id_Firing = 1;
           end

           if (s_ICON_Active == 2)
              id_Language = 1;
           end

           if (s_ICON_Active == 3)
              id_VMU_Use = 0;
           end

        
        end


          if(m_Pressed3 + m_Free3 == 2) //Event System Button (X)
             //Clear Buffer for event Button (X)      
             m_Pressed3=0;
             m_Free3=0;
             
             if (s_ICON_Active == 4)
              BREAK;
             end
                          
          end



        WindowX(s_WND_Show_Window,s_tmp_x,s_tmp_y);

	FRAME;
	end


		Delete_Text(0);

        main_menu();
END

///////////////////////////////////////////////////////////////////////////////
//
// PROCESS WINDOWS
///////////////////////////////////////////////////////////////////////////////

PROCESS WindowX(w_WND_Message,w_posX,w_posY)

BEGIN

file = id_FPG_Mazinger;
Graph=w_WND_Message;
x=w_posX;
y=w_posY;
z=0;
FRAME;

END


