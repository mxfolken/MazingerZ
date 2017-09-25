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
// PROCESS final_history()                                                    //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process final_history();
begin

  //Assign channels and load soundtrack  
  id_CHANNEL_Opening = 1;
  id_SND_Opening     = load_wav(DC_DIR + "FINAL.ADX");
  play_wav(id_SND_Opening,SNDENV,id_CHANNEL_Opening);
	

if (id_Language == 1)
   write(0,160,180,4,"Scientists Juzo Kabuto and Dr.Hell");
   write(0,160,190,4,"an important discovery on the");
   write(0,160,200,4,"Greek island of Rhodes.");
else
   write(0,160,180,4,"Los científicos Juzo Kabuto y Dr.Hell");
   write(0,160,190,4,"hacen un importante descubrimiento");
   write(0,160,200,4,"en la isla griega de Rodas.");
end


file = id_FPG_history;
clear_screen();
graph=1;
x=164;
y=87;


timer[1]=0;

     loop

       if(timer[1] > 1200)
          break;
       end  

     frame;
     end
     
     delete_text(0);     
     final_history_sec02();
     
end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// PROCESS final_history_sec02()                                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process final_history_sec02();
begin

if (id_Language == 1)
   write(0,160,180,4,"An ancient Mycenaean civilization");
   write(0,160,190,4,"had created some giant automatons.");
   write(0,160,200,4," ");
else
   write(0,160,180,4,"Una antigua civilización micénica");
   write(0,160,190,4,"había creado unos gigantescos");
   write(0,160,200,4,"autómatas.");
end


file = id_FPG_history;
clear_screen();
graph=2;
x=164;
y=87;


timer[1]=0;

     loop

       if(timer[1] > 1200)
          break;
       end  

     frame;
     end
     
     delete_text(0);     
     final_history_sec03();
     
end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// PROCESS final_history_sec03()                                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process final_history_sec03();
begin

if (id_Language == 1)
   write(0,160,180,4,"Dr.Hell uses this technology to try");
   write(0,160,190,4,"conquer the world, kill all your");
   write(0,160,200,4,"colleagues.");
else
   write(0,160,180,4,"El Dr.Hell utiliza esa tecnología");
   write(0,160,190,4,"para intentar conquistar el mundo,");
   write(0,160,200,4,"mata a todos sus colegas.");
end


file = id_FPG_history;
clear_screen();
graph=3;
x=164;
y=87;


timer[1]=0;

     loop

       if(timer[1] > 1200)
          break;
       end  

     frame;
     end
     
     delete_text(0);     
     final_history_sec04();
     
end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// PROCESS final_history_sec04()                                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process final_history_sec04();
begin

if (id_Language == 1)
   write(0,160,180,4,"Dr.Kabuto manages to escape");
   write(0,160,190,4,"to take refuge in Japan.");
   write(0,160,200,4," ");
else
   write(0,160,180,4,"El Dr.Kabuto logra escapar");
   write(0,160,190,4,"para refugiarse en Japón.");
   write(0,160,200,4," ");
end


file = id_FPG_history;
clear_screen();
graph=4;
x=164;
y=87;


timer[1]=0;

     loop

       if(timer[1] > 1200)
          break;
       end  

     frame;
     end
     
     delete_text(0);     
     final_history_sec05();
     
end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// PROCESS final_history_sec05()                                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process final_history_sec05();
begin

if (id_Language == 1)
   write(0,160,180,4,"Juzo Kabuto creates a super");
   write(0,160,190,4,"robot called Mazinger Z");
   write(0,160,200,4,"to face Dr.Hell.");
else
   write(0,160,180,4,"Juzo Kabuto crea un super");
   write(0,160,190,4,"robot llamado Mazinger Z");
   write(0,160,200,4,"para enfrentarse al Dr.Hell.");
end


file = id_FPG_history;
clear_screen();
graph=5;
x=164;
y=87;


timer[1]=0;

     loop

       if(timer[1] > 1200)
          break;
       end  

     frame;
     end
     
     delete_text(0);     
     final_history_sec06();
     
end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// PROCESS final_history_sec06()                                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process final_history_sec06();
begin

if (id_Language == 1)
   write(0,160,180,4,"Baron Ashler was created by Dr.Hell");
   write(0,160,190,4,"using two Mikeneses mummies,");
   write(0,160,200,4,"as an ally.");
else
   write(0,160,180,4,"El Baron Ashler fue creado");
   write(0,160,190,4,"por el Dr.Hell usando dos momias");
   write(0,160,200,4,"Mikeneses, como aliado.");
end


file = id_FPG_history;
clear_screen();
graph=6;
x=164;
y=87;


timer[1]=0;

     loop

       if(timer[1] > 1200)
          break;
       end  

     frame;
     end
     
     delete_text(0);     
     final_history_sec07();
     
end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// PROCESS final_history_sec07()                                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process final_history_sec07();
begin

if (id_Language == 1)
   write(0,160,180,4,"Koji Kabuto is the grandson");
   write(0,160,190,4,"of Dr.Juzo and");
   write(0,160,200,4,"is the crew of Mazinger Z.");
else
   write(0,160,180,4,"Koji Kabuto es el nieto del");
   write(0,160,190,4,"Dr.Juzo y es el tripulante");
   write(0,160,200,4,"de Mazinger Z.");
end


file = id_FPG_history;
clear_screen();
graph=7;
x=164;
y=87;


timer[1]=0;

     loop

       if(timer[1] > 1200)
          break;
       end  

     frame;
     end
     
     delete_text(0);     
     final_history_sec08();
     
end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// PROCESS final_history_sec08()                                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process final_history_sec08();
begin

if (id_Language == 1)
   write(0,160,180,4,"Dr.Yumi, his daughter Sayaka,");
   write(0,160,190,4,"a motorcyclist called Boss and other");
   write(0,160,200,4,"allies will fight against Dr.Hell.");
else
   write(0,160,180,4,"El Dr.Yumi, su hija Sayaka,");
   write(0,160,190,4,"un motociclista llamado Boss,");
   write(0,160,200,4,"lucharán contra Dr.Hell.");
end


file = id_FPG_history;
clear_screen();
graph=8;
x=164;
y=87;


timer[1]=0;

     loop

       if(timer[1] > 1200)
          break;
       end  

     frame;
     end
     
     delete_text(0);     
     final_history_sec09();
     
end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// PROCESS final_history_sec09()                                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process final_history_sec09();
begin

if (id_Language == 1)
   write(0,160,180,4,"For a long time Mazinger Z achieved");
   write(0,160,190,4,"defeat Dr.Hell.");
   write(0,160,200,4," ");
else
   write(0,160,180,4,"Durante mucho tiempo");
   write(0,160,190,4,"Mazinger Z logró derrotar");
   write(0,160,200,4,"al Dr.Hell.");
end


file = id_FPG_history;
clear_screen();
graph=9;
x=164;
y=87;


timer[1]=0;

     loop

       if(timer[1] > 1200)
          break;
       end  

     frame;
     end
     
     delete_text(0);     
     final_history_sec10();
     
end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// PROCESS final_history_sec10()                                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process final_history_sec10();
begin

if (id_Language == 1)
   write(0,160,180,4,"One day Dr.Hell's robots");
   write(0,160,190,4,"destroyed");
   write(0,160,200,4,"Mazinger Z.");
else
   write(0,160,180,4,"Un día los robots del");
   write(0,160,190,4,"Dr.Hell destruyeron a");
   write(0,160,200,4,"Mazinger Z.");
end


file = id_FPG_history;
clear_screen();
graph=10;
x=164;
y=87;


timer[1]=0;

     loop

       if(timer[1] > 1200)
          break;
       end  

     frame;
     end
     
     delete_text(0);     
     final_history_sec11();
     
end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// PROCESS final_history_sec11()                                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process final_history_sec11();
begin

if (id_Language == 1)
   write(0,160,180,4,"Kenzo Kabuto's father");
   write(0,160,190,4,"activates a new");
   write(0,160,200,4,"Mazinger to save him.");
else
   write(0,160,180,4,"Kenzo Kabuto padre de");
   write(0,160,190,4,"Koji activa un nuevo");
   write(0,160,200,4,"Mazinger para salvarlo.");
end


file = id_FPG_history;
clear_screen();
graph=11;
x=164;
y=87;


timer[1]=0;

     loop

       if(timer[1] > 1200)
          break;
       end  

     frame;
     end
     
     delete_text(0);     
     final_history_sec12();
     
end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// PROCESS final_history_sec12()                                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process final_history_sec12();
begin

if (id_Language == 1)
   write(0,160,180,4,"Sayaka and Koji leave");
   write(0,160,190,4,"Japan and go to");
   write(0,160,200,4,"study in the United States.");
else
   write(0,160,180,4,"Sayaka y Koji abandonan");
   write(0,160,190,4,"Japón y van a estudiar");
   write(0,160,200,4,"a Estados Unidos.");
end


file = id_FPG_history;
clear_screen();
graph=12;
x=164;
y=87;


timer[1]=0;

     loop

       if(timer[1] > 1200)
          break;
       end  

     frame;
     end
     
     delete_text(0);     
     final_history_sec13();
     
end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// PROCESS final_history_sec13()                                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process final_history_sec13();
begin

if (id_Language == 1)
   write(0,160,180,4,"Starts Mazinger's");
   write(0,160,190,4,"new adventure...");
   write(0,160,200,4," ");
else
   write(0,160,180,4,"Inicia la nueva aventura");
   write(0,160,190,4,"de Gran Mazinger...");
   write(0,160,200,4," ");
end


file = id_FPG_history;
clear_screen();
graph=13;
x=164;
y=87;


timer[1]=0;

     loop

       if(timer[1] > 1200)
          break;
       end  

     frame;
     end
     
     delete_text(0);     
     completed_game();
     
end


////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// PROCESS completed_game()                                                   //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

PROCESS completed_game();

BEGIN

file = id_FPG_history;
clear_screen();
Graph=14;
x=164;
y=90;
z=0;

write    (0,10,190,0,"Programmer: Rolando Fernández Benavidez");
write    (0,10,200,0,"(c)Nova32 Development Software 2017.");
write    (0,10,210,0,"SCORE:");
write_int(0,10,220,0,&id_SUPER_RECORD_Counter);


    loop

		
	    if(JOY_PS2_CROSS(0))      //PS2_BUTTON = (X)
		  break;
	    end

		
	    if(JOY_PS2_CIRCLE(0))    //PS2_BUTTON = (O)
		  break;
	    end

		
	    if(JOY_PS2_TRIANGLE(0))  //PS2_BUTTON = (/\)
		  break;
	    end
		
		
	   if(JOY_PS2_SQUARE(0))    //PS2_BUTTON = ([])
		  break;
	    end
		
		
		
    FRAME;
    end
	
	
	stop_wav(id_CHANNEL_Opening);
	unload_wav(id_SND_Opening);
	delete_text(0);
	main_menu();
	
END








