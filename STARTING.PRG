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



process starting_level()

private

	int  id_GRAPHICS_Milerna;
	int  id_GRAPHICS_Milerna_Select;
	byte m_opt_selected;

begin

	//Load Graphics
	file = id_FPG_starting;
	clear_screen();

	id_GRAPHICS_Milerna = 0;  // Next GR.30
	id_GRAPHICS_Milerna_Select = 0;  

	if(id_LEVEL_STATUS < 11)
		write    (0,160,220,4,"NOW LOADING LEVEL:");
		write_int(0,160,230,4,&id_LEVEL_STATUS);
	else
		switch(id_LEVEL_STATUS)
			case 11:  write(0,160,220,4,"CONGRATULATIONS, GAME COMPLETED!"); end
			case 31:  write(0,160,220,4,"KOJI VS ASHURA");     end
			case 71:  write(0,160,220,4,"KOJI VS DECAPITADO"); end
			case 101: write(0,160,220,4,"KOJI VS DR.HELL");    end
		end
	end


	timer[0]=0; 
	timer[1]=0;	   
	m_opt_selected = false;
     
     loop
     
                
        if(timer[1] > 1500)
        	break;
        end
        
                
		if(timer[0] > 10)
			
			   if (id_GRAPHICS_Milerna == 0 and id_GRAPHICS_Milerna_Select == 0)
					 id_GRAPHICS_Milerna = 1;
					 id_GRAPHICS_Milerna_Select = 1;
			   end
			   
			   if (id_GRAPHICS_Milerna == 1 and id_GRAPHICS_Milerna_Select == 0)
					 id_GRAPHICS_Milerna = 2;
					 id_GRAPHICS_Milerna_Select = 1;
			   end			   
			
			   if (id_GRAPHICS_Milerna == 2 and id_GRAPHICS_Milerna_Select == 0)
					 id_GRAPHICS_Milerna = 3;
					 id_GRAPHICS_Milerna_Select = 1;
			   end
			   
			   if (id_GRAPHICS_Milerna == 3 and id_GRAPHICS_Milerna_Select == 0)
					 id_GRAPHICS_Milerna = 4;                                    
					 id_GRAPHICS_Milerna_Select = 1;
			   end
			   
			   if (id_GRAPHICS_Milerna == 4 and id_GRAPHICS_Milerna_Select == 0)
					 id_GRAPHICS_Milerna = 5;                                    
					 id_GRAPHICS_Milerna_Select = 1;
			   end


			   if (id_GRAPHICS_Milerna == 5 and id_GRAPHICS_Milerna_Select == 0)
					 id_GRAPHICS_Milerna = 6;                                    
					 id_GRAPHICS_Milerna_Select = 1;
			   end


			   if (id_GRAPHICS_Milerna == 6 and id_GRAPHICS_Milerna_Select == 0)
					 id_GRAPHICS_Milerna = 1;                                    
					 id_GRAPHICS_Milerna_Select = 1;
			   end


			   //restart timer
			   id_GRAPHICS_Milerna_Select = 0;
			   timer[0]=0;

			end
			//----Timer[0]---------End Code              



					//file = id_FPG_starting;
					graph=id_GRAPHICS_Milerna;
					x=161;
					y=101;
					z=0;
				




			frame;

		 end
    

     clear_screen();
     delete_text(0);	        
    

    if (id_LEVEL_STATUS == 1 && m_opt_selected == false)
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
        txt_soundtrack     = "LMZ0000.ADX";		
		id_LEVEL_STATUS    = 2; //NEXT LEVEL ON WINNER
		m_opt_selected     = true;
		training();
    end

    if (id_LEVEL_STATUS == 2 && m_opt_selected == false)
		id_Next_LEVEL     = 0;
		id_GAME_OVER      = 0;
		id_Pause          = 0;
		id_Record_Counter = 0;
		id_Num_Fires      = 900; //10
		//System core parameters of level
		id_LEVEL_Dificulty = 500;
		id_HP_counter      = 150;
		id_LEVEL_counter   = 2;	
		id_level_winner    = 100; //100		
		txt_soundtrack     = "LEVEL03.ADX";
		id_LEVEL_STATUS    = 31; //NEXT LEVEL ON WINNER (3-1 boss1) 
		m_opt_selected     = true;
		engine2d();		
    end

    if (id_LEVEL_STATUS == 31 && m_opt_selected == false)
		id_HP_counter            = 150;   //150
		id_Num_Fires             = 10;	
		id_Healty_Boss1          = 2000;  //2000 
		id_boss_CLLN_majinga     = 4;     //8
		id_boss_CLLN_fire        = 30;    //10
		id_majinga_CLLN_fireboss = 1;     //4		
		id_LEVEL_STATUS          = 4;     //NEXT LEVEL ON WINNER
		m_opt_selected           = true;
		splash_boss1();			
    end

    if (id_LEVEL_STATUS == 3 && m_opt_selected == false)
		id_Next_LEVEL     = 0;
		id_GAME_OVER      = 0;
		id_Pause          = 0;
		id_Record_Counter = 0;
		id_Num_Fires      = 10;
		//System core parameters of level
		id_LEVEL_Dificulty = 500;
		id_HP_counter      = 150;
		id_LEVEL_counter   = 3;	
		id_level_winner    = 100; //100
		txt_soundtrack     = "LEVEL02.ADX";
		id_LEVEL_STATUS    = 4; //NEXT LEVEL ON WINNER
		m_opt_selected     = true;
		engine2d();			
    end

    if (id_LEVEL_STATUS == 4 && m_opt_selected == false)
		id_Next_LEVEL     = 0;
		id_GAME_OVER      = 0;
		id_Pause          = 0;
		id_Record_Counter = 0;
		id_Num_Fires      = 10;
		//System core parameters of level
		id_LEVEL_Dificulty = 500;
		id_HP_counter      = 150;
		id_LEVEL_counter   = 4;	
		id_level_winner    = 100; //100
		txt_soundtrack     = "LMZ0000.ADX";
		id_LEVEL_STATUS    = 5; //NEXT LEVEL ON WINNER
		m_opt_selected     = true;
		engine2d();			
    end


    if (id_LEVEL_STATUS == 5 && m_opt_selected == false)
		id_Next_LEVEL     = 0;
		id_GAME_OVER      = 0;
		id_Pause          = 0;
		id_Record_Counter = 0;
		id_Num_Fires      = 10;
		//System core parameters of level
		id_LEVEL_Dificulty = 500;
		id_HP_counter      = 150;
		id_LEVEL_counter   = 5;	
		id_level_winner    = 100; //100
		txt_soundtrack     = "LEVEL05.ADX";
		id_LEVEL_STATUS    = 6; //NEXT LEVEL ON WINNER
		m_opt_selected     = true;
		engine2d();			
    end


    if (id_LEVEL_STATUS == 6 && m_opt_selected == false)
		id_Next_LEVEL     = 0;
		id_GAME_OVER      = 0;
		id_Pause          = 0;
		id_Record_Counter = 0;
		id_Num_Fires      = 10;
		//System core parameters of level
		id_LEVEL_Dificulty = 500;
		id_HP_counter      = 150;
		id_LEVEL_counter   = 6;	
		id_level_winner    = 100; //100
		txt_soundtrack     = "LEVEL06.ADX";
		id_LEVEL_STATUS    = 7; //NEXT LEVEL ON WINNER
		m_opt_selected     = true;
		engine2d();			
    end


    if (id_LEVEL_STATUS == 7 && m_opt_selected == false)
		id_Next_LEVEL     = 0;
		id_GAME_OVER      = 0;
		id_Pause          = 0;
		id_Record_Counter = 0;
		id_Num_Fires      = 10;
		//System core parameters of level
		id_LEVEL_Dificulty = 500;
		id_HP_counter      = 150;
		id_LEVEL_counter   = 7;	
		id_level_winner    = 100; //100
		txt_soundtrack     = "LMZ0000.ADX";
		id_LEVEL_STATUS    = 71; //NEXT LEVEL ON WINNER (7-1 boss2)
		m_opt_selected     = true;
		engine2d();			
    end

    if (id_LEVEL_STATUS == 71 && m_opt_selected == false)
		id_HP_counter            = 150;
		id_Num_Fires             = 10;	
		id_Healty_Boss1          = 3000;  //3000 
		id_boss_CLLN_majinga     = 4;     //10
		id_boss_CLLN_fire        = 30;    //9
		id_majinga_CLLN_fireboss = 1;     //18			
		id_LEVEL_STATUS          = 8;     //NEXT LEVEL ON WINNER
		m_opt_selected           = true;
		splash_boss2();			
    end
	
    if (id_LEVEL_STATUS == 8 && m_opt_selected == false)
		id_Next_LEVEL     = 0;
		id_GAME_OVER      = 0;
		id_Pause          = 0;
		id_Record_Counter = 0;
		id_Num_Fires      = 10;
		//System core parameters of level
		id_LEVEL_Dificulty = 500;
		id_HP_counter      = 150;
		id_LEVEL_counter   = 8;	
		id_level_winner    = 100; //100
		txt_soundtrack     = "LEVEL08.ADX";
		id_LEVEL_STATUS    = 9; //NEXT LEVEL ON WINNER
		m_opt_selected     = true;
		engine2d();			
    end

    if (id_LEVEL_STATUS == 9 && m_opt_selected == false)
		id_Next_LEVEL     = 0;
		id_GAME_OVER      = 0;
		id_Pause          = 0;
		id_Record_Counter = 0;
		id_Num_Fires      = 10;
		//System core parameters of level
		id_LEVEL_Dificulty = 500;
		id_HP_counter      = 150;
		id_LEVEL_counter   = 9;	
		id_level_winner    = 100; //100
		txt_soundtrack     = "LMZ0000.ADX";
		id_LEVEL_STATUS    = 10; //NEXT LEVEL ON WINNER
		m_opt_selected     = true;
		engine2d();			
    end


    if (id_LEVEL_STATUS == 10 && m_opt_selected == false)
		id_Next_LEVEL     = 0;
		id_GAME_OVER      = 0;
		id_Pause          = 0;
		id_Record_Counter = 0;
		id_Num_Fires      = 10;
		//System core parameters of level
		id_LEVEL_Dificulty = 500;
		id_HP_counter      = 150;
		id_LEVEL_counter   = 10;	
		id_level_winner    = 100; //100
		txt_soundtrack     = "LEVEL10.ADX";
		id_LEVEL_STATUS    = 101; //NEXT LEVEL ON WINNER  (10-1 boss3)
		m_opt_selected     = true;
		engine2d();				
    end

    if (id_LEVEL_STATUS == 101 && m_opt_selected == false)
		id_HP_counter            = 150;
		id_Num_Fires             = 10;	
		id_Healty_Boss1          = 4000;  //4000 
		id_boss_CLLN_majinga     = 4;     //10
		id_boss_CLLN_fire        = 30;    //8
		id_majinga_CLLN_fireboss = 1;     //23					
		id_LEVEL_STATUS          = 11; //NEXT LEVEL ON WINNER
		m_opt_selected           = true;
		splash_boss3();			
    end
	
	
    if (id_LEVEL_STATUS == 11 && m_opt_selected == false)
		m_opt_selected = true;
		final_history();
    end


end
