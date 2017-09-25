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
// PROCESS: About_s                                                           //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

PROCESS About_s()

PRIVATE

   INT m_Pressed1;   //Button (/\)
   INT m_Free1;
   
BEGIN

	m_Pressed1      = 0; // (/\)
	m_Free1         = 0; 

	file = id_FPG_Mazinger;
	put_screen(id_FPG_Mazinger,40);

	Graph=41;
	x=82;
	y=190;

    IF ( id_Language == 1)
	write(0,20,100,0,    "Mazinger Z, was designed GNU/GPL License "); 
        write(0,20,120,0,"and is of free distribution PlayStation 2.");
	write(0,20,140,0,    "programmer:");
	write(0,20,160,0,    "Rolando Fernandez Benavidez");
	write(0,25,190,0,    "Press        to Return.");
    ELSE
	write(0,20,100,0,    "Mazinger Z, diseñado con licencia GNU"); 
        write(0,20,120,0,"y es de libre distribución PlayStation 2.");
	write(0,20,140,0,    "programador:");
	write(0,20,160,0,    "Rolando Fernández Benavidez");
	write(0,25,190,0,    "Pulsa        para regresar.");
    END





	LOOP

          //--------------------DETECTION BUTTON PRESSED AND FREE (/\) ----->      
          IF(JOY_PS2_TRIANGLE(0))          //PS2_BUTTON = (/\)
             m_Pressed1=1;    
             m_Free1=0;         
          END
          
          IF(NOT JOY_PS2_TRIANGLE(0))
             m_Free1=1;        //PS2_BUTTON = (/\)
          END      
          //---------------------------------------------------------------->
          

          IF(m_Pressed1 + m_Free1 == 2)     //Event System Button (/\)
             //Clear Buffer for event Button (/\)      
             m_Pressed1=0;
             m_Free1=0;
             
             BREAK;
             
          END

	FRAME;
	END

Delete_Text(0);
main_menu();

END



