/*

    This program is distributed in the hope that it will be useful,
    but without any warranty, without even the implied warranty of
    particular purpose.

	  Nova32 Development Software
	  (c) Rolando Fernandez Benavidez, March 2019.

--------------------------------------------------------------------------
                       M A Z I N G E R   Z   -HOMEBREW-

                                 マジンガーz

                  セガサターンで動作するようにプログラムされたアクションゲーム。

                                 use only
                           GNU GCC-COFF & Jo-Engine

    このプログラムはフリーソフトウェアです：あなたはそれを再配布することができますおよび/
    または変更することができます
    によって公開されているGNU一般公衆利用許諾契約書の条項の下で
    Free Software Foundation、ライセンスのバージョン3、または
    （あなたの選択で）それ以降のバージョン。

    このプログラムは、役に立つことを願って配布されています。
    しかし、いかなる保証もありません。 の黙示的な保証もありません。
    商品性または特定の目的への適合性。 を参照してください
    詳細については、GNU General Public License。

    あなたはGNU General Public Licenseのコピーを受け取っているはずです。
    このプログラムと一緒に。 そうでない場合は、<https://www.nova32.com.mx>を参照してください。
    <（c）Rolando Fernández Benavidez 2019>。

 Platform: SEGA SATURN

 Version 3.0.0

*/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <sgl.h>
#include <jo/jo.h>
#include "global.h"
#include "mazinger.h"

/////////////////////////////////////////////////////////////////////////////
// Function: Exec_Assembler_Hitachi_SH2_CPU                                //
// Summary : HITACHI SH-2 MASTER CPU TEST                                  //
/////////////////////////////////////////////////////////////////////////////

void Exec_Assembler_Hitachi_SH2_CPU(void)
{


// この関数は日立SH-2 CPUのテストを実行することを可能にし、SDKがSEGA Saturnハードウ
// ェアへのフルアクセスでCOFFフォーマットでバイナリをコンパイルすることを可能にすることを実証します。


	asm ("		.ORG    H'1006 			");
	asm ("		MOV   	#H'7B1 , R1    	");  // STAGES=3 CYCLES=1
	asm ("		MOV   	#H'7C4 , R5    	");  // STAGES=3 CYCLES=1
	asm ("		NOT   	   R5  , R1  	");
	asm ("		ADD     #–1    , R0   	");  // STAGES=3 CYCLES=1
	asm ("		TST     R0     , R0  	");  // STAGES=6 CYCLES=1
	asm ("		SETT                	");
	asm ("		NEG     R1     , R0    	");
    asm ("		.ALIGN  2     			");
	asm ("		CLRMAC         			");
	asm ("		CLRT         			");
	asm ("DATAS1:	               		");
	asm ("		MOV		#H'4D3 , R0     "); // STAGES=3 CYCLES=1
	asm ("		MOV   	#H'7C3 , R1    	"); // STAGES=3 CYCLES=1
	asm ("OPERATION:   					");
	asm ("		ADD   	    R0 , R1  	"); // STAGES=3 CYCLES=1
	asm ("		NOT   	    R0 , R1  	");
    asm ("		STS 	  MACH , R1		"); // STAGES=4 CYCLES=1
    asm ("		SUB         R0 , R1    	");
	asm ("		MULU   	    R2 , R0    	");	// STAGES=6/7*3 CYCLES=1
	asm ("NOP          					");
	asm ("TARGET:      					");
	asm ("		.ALIGN  4     			");
	asm ("		SETT                	");
	asm ("		OR         R5 , R0    	");
	asm ("DATAS2:	               		");
	asm ("		MOV		#H'00A , R0     "); // STAGES=3 CYCLES=1
	asm ("		MOV   	#H'01C , R1    	");	// STAGES=3 CYCLES=1
	asm ("		ADD   	    R5 , R1    	");	// STAGES=3 CYCLES=1
	asm ("		LDC         R1 , SR  	");
	asm ("		STS       MACL , R0		"); // STAGES=4 CYCLES=1
	asm ("		SETT                	");
    asm ("		MOV		#H'00A , R7     ");	// STAGES=3 CYCLES=1
	asm ("		MOV   	#H'01C , R8    	");
	asm ("		MULU   	    R7 , R8    	");	// STAGES=6/7*3 CYCLES=1
	asm ("		STS 	  MACL , R7		");
	asm ("		STS 	  MACH , R5		"); // STAGES=4 CYCLES=1
	asm ("		NEG         R5 , R0    	");
	asm ("		SUB         R5 , R1    	");
	asm ("NOP          					");

}


//ゲームのソースコード


/*
-----------------------------------------------------------------------------
Function: Exec_Game
Summary : ゲームのエントリーポイント
-----------------------------------------------------------------------------
*/

void Exec_Game(void)
{

#ifdef MAZINGER_DEBUG

	//MASTER SH-2 TEST:                    //この関数は日立SH-2 CPUのテストを実行することを可能にし、
	                                       //SDKがSEGA Saturnハードウ
	Exec_Assembler_Hitachi_SH2_CPU();      //ェアへのフルアクセスでCOFFフォーマットでバイナリをコンパイルす
	                                       //ることを可能にすることを実証します。

#endif

	//Initialize Jo-Engine
	jo_core_init(JO_COLOR_Black);   //エンジン始動（JO-ENGINE）

	//SetBackground();   //壁紙の描画が中止されました

	jo_move_background (0,80);  //資金を正しい位置に移動します。

	Init_mode7();  //MODO7を起動します
	Awake();  //ゲームのリソースをメモリにロードします

	game_status = MAZINGER_MENU; //最初の状態はメインメニューです

	Environment.RAM = jo_memory_usage_percent();
	Environment.VRAM = jo_sprite_usage_percent();
	Environment.Language = slGetLanguage();

	jo_core_add_slave_callback(Splash);	 // SLAVE  CPU HITACHI SH2
	jo_core_add_slave_callback(Frame);	 // SLAVE  CPU HITACHI SH2
	jo_core_add_callback(Update);        // MASTER CPU HITACHI SH2

	jo_core_run(); //エンジンを始動する
}

/*
-----------------------------------------------------------------------------
Function: load_background
Summary : 背景TGAを設定する
-----------------------------------------------------------------------------
*/

void SetBackground(void)
{
    jo_img bg;

    bg.data = JO_NULL;
    jo_tga_loader(&bg, "ASSETS", "WORLD.TGA", JO_COLOR_Black);
    jo_set_background_sprite(&bg, 0, 0);
	jo_move_background (0,80);
    jo_free_img(&bg);
}


/*
-----------------------------------------------------------------------------
Function: Collision
Summary : コライダーイベント
-----------------------------------------------------------------------------
*/

int Collision(PLAYER *A,PLAYER *B)
{
	if(!A->active) return 0;
	if(!B->active) return 0;
	return (int) jo_hitbox_detection(A->id,A->x,A->y,B->id,B->x,B->y);
}


/*
-----------------------------------------------------------------------------
Function: Debug
Summary : デバッガゲーム
-----------------------------------------------------------------------------
*/

void Debug(void)
{

	if (jo_is_pad1_key_pressed(JO_KEY_B))
	{
		 unsigned short  *ptr;
		 int l=7;

		 Debug_Show = TRUE;

         jo_printf(7,0, "VDP2 VRAM A0      : 0x%X  ", VDP2_VRAM_A0);
		 jo_printf(7,1, "RAM memory usage  : %d%%  ", Environment.RAM);
		 jo_printf(7,2, "Video memory usage: %d%%  ", Environment.VRAM);
		 jo_printf(7,3, "Peripheral 1 mode : 0x%X  ", slGetPortMode1());
		 jo_printf(7,4, "User Language     : %d    ", slGetLanguage());
		 jo_printf(7,5, "Sound mode        : %d    ", slGetSoundOutput());
		 jo_printf(7,6, "SMPC system status: 0x%X  ", Smpc_Status); //マイクロコントローラ日立HD404920

		 for (ptr = (unsigned short *)JO_VDP1_REG; ptr <= (unsigned short *)JO_VDP1_LAST_REG; ++ptr)
		     {
				jo_printf(7,l, "VDP1: 0x%X = 0x%X", (int)ptr, *ptr);
				l++;
			 }

		for (ptr = (unsigned short *)JO_VDP2_REG; ptr <= (unsigned short *)JO_VDP2_LAST_REG; ++ptr)
		     {
				jo_printf(7,l, "VDP2: 0x%X = 0x%X", (int)ptr, *ptr);
				l++;
			 }


	}
	else Debug_Show = FALSE;

}


/*
-----------------------------------------------------------------------------
Function: Frame
Summary : ゲーム上ですべてのグラフィックを描く
-----------------------------------------------------------------------------
*/

void Frame(void)
{
	if(game_status != MAZINGER_PLAY || !Run) return;

	//プレイフィールドエリアをクリア
    jo_clear_screen();

	switch(Level)
	{
		case 1: { id_spr_use = id_spr_city1; break; }
		case 2: { id_spr_use = id_spr_city2; break; }
		case 3: { id_spr_use = id_spr_city3; break; }
		case 4: { id_spr_use = id_spr_city1; break; }
		case 5: { id_spr_use = id_spr_city2; break; }
	}

	//プレイフィールド
	jo_sprite_draw3D2(id_spr_use,0,0,500);


	jo_sprite_draw3D2(id_spr_pilot,30,160,500);

	//ロボット
	jo_sprite_draw3D2(Robot1.id,Robot1.x,Robot1.y,Robot1.z);
	jo_sprite_draw3D2(Robot2.id,Robot2.x,Robot2.y,Robot2.z);
	jo_sprite_draw3D2(Robot3.id,Robot3.x,Robot3.y,Robot3.z);
	jo_sprite_draw3D2(Robot4.id,Robot4.x,Robot4.y,Robot4.z);
	jo_sprite_draw3D2(Robot5.id,Robot5.x,Robot5.y,Robot5.z);

	//プレーヤー
	jo_sprite_draw3D2(Player0.id,Player0.x,Player0.y,Player0.z);

	//アニメーション
	PowerAnimation();
	BulletAnimation();
	FireAnimation();

DEBUG_GO

	//メッセージを書く
	//sprintf(str,"  x: %d   y: %d   status: %d",Player0.x,Player0.y,game_status);
	sprintf(str,"Score: %d   Level: %d   Energy: %d",Score,Level,Energy);
	jo_printf(0,0,str);

DEBUG_END


#ifdef MAZINGER_DEBUG
	Debug();
#endif


	Render_mode7();
}


/*
-----------------------------------------------------------------------------
Function: play_song
Summary : ゲームの音楽（SATURN CD）
-----------------------------------------------------------------------------
*/

void play_song(void)
{

	if(is_cd_playing) return;

	switch(Level)
	{
		case  1: {jo_audio_play_cd_track(TRACK_LEVEL1,TRACK_LEVEL1, CD_LOOP); is_cd_playing = TRUE; break;}
		case  2: {jo_audio_play_cd_track(TRACK_LEVEL2,TRACK_LEVEL2, CD_LOOP); is_cd_playing = TRUE; break;}
		case  3: {jo_audio_play_cd_track(TRACK_LEVEL3,TRACK_LEVEL3, CD_LOOP); is_cd_playing = TRUE; break;}
		case  4: {jo_audio_play_cd_track(TRACK_LEVEL4,TRACK_LEVEL4, CD_LOOP); is_cd_playing = TRUE; break;}
		case  5: {jo_audio_play_cd_track(TRACK_LEVEL5,TRACK_LEVEL5, CD_LOOP); is_cd_playing = TRUE; break;}

		case  6: {jo_audio_play_cd_track(TRACK_LEVEL1,TRACK_LEVEL1, CD_LOOP); is_cd_playing = TRUE; break;}
		case  7: {jo_audio_play_cd_track(TRACK_LEVEL2,TRACK_LEVEL2, CD_LOOP); is_cd_playing = TRUE; break;}
		case  8: {jo_audio_play_cd_track(TRACK_LEVEL3,TRACK_LEVEL3, CD_LOOP); is_cd_playing = TRUE; break;}
		case  9: {jo_audio_play_cd_track(TRACK_LEVEL4,TRACK_LEVEL4, CD_LOOP); is_cd_playing = TRUE; break;}
		case 10: {jo_audio_play_cd_track(TRACK_LEVEL5,TRACK_LEVEL5, CD_LOOP); is_cd_playing = TRUE; break;}

		case 11: {jo_audio_play_cd_track(TRACK_LEVEL1,TRACK_LEVEL1, CD_LOOP); is_cd_playing = TRUE; break;}
		case 12: {jo_audio_play_cd_track(TRACK_LEVEL2,TRACK_LEVEL2, CD_LOOP); is_cd_playing = TRUE; break;}
		case 13: {jo_audio_play_cd_track(TRACK_LEVEL3,TRACK_LEVEL3, CD_LOOP); is_cd_playing = TRUE; break;}
		case 14: {jo_audio_play_cd_track(TRACK_LEVEL4,TRACK_LEVEL4, CD_LOOP); is_cd_playing = TRUE; break;}
		case 15: {jo_audio_play_cd_track(TRACK_LEVEL5,TRACK_LEVEL5, CD_LOOP); is_cd_playing = TRUE; break;}

		case 16: {jo_audio_play_cd_track(TRACK_LEVEL1,TRACK_LEVEL1, CD_LOOP); is_cd_playing = TRUE; break;}

	}


}


/*
-----------------------------------------------------------------------------
Function: OnGameOver
Summary : ゲームオーバーイベントコントローラ
-----------------------------------------------------------------------------
*/

void OnGameOver()
{
   	jo_audio_stop_cd();
   	is_cd_playing = FALSE;
   	Run = FALSE;

	jo_clear_background(JO_COLOR_Black);
	jo_printf(15,27,"  GAME OVER!");

    jo_sprite_draw3D(id_spr_gameover,0,0,500);

	timer[1]++;
	if(timer[1] > 500)
	{
        Score+=Level_Score;
		game_status = MAZINGER_MENU;
		timer[1]=0;
	}

}


/*
-----------------------------------------------------------------------------
Function: Update
Summary : ゲームループで更新
-----------------------------------------------------------------------------
*/


void Update()
{
	if(game_status != MAZINGER_PLAY) return;

RUN

	play_song();

	floor_pos_y += SPEED_POS;

DEBUG_GO

	//-------------------------ロボット IA------------------------------------------------------//
	timer[0]++;
	if(timer[0] > 5)
	{
		if (Robot1.x < Player0.x) Robot1.x += Enemy_Velocity;
		if (Robot1.x > Player0.x) Robot1.x -= Enemy_Velocity;
		if (Robot1.y < Player0.y) Robot1.y += Enemy_Velocity;
		if (Robot1.y > Player0.y) Robot1.y -= Enemy_Velocity;

	timer[0]=0;
	}

	//--------------------------ロボット 2-----------------------//
	Rand_X = rand()%5;
	Rand_Value = rand()%7;
	if (Rand_X == 0) if (Robot2.x < SCREEN_H_MAX) Robot2.x += Rand_Value;
	if (Rand_X == 1) if (Robot2.x > SCREEN_H_MIN) Robot2.x -= Rand_Value;
	Rand_Y = rand()%5;
	Rand_Value = rand()%7;
	if (Rand_Y == 0) if (Robot2.y < SCREEN_V_MAX) Robot2.y += Rand_Value;
	if (Rand_Y == 1) if (Robot2.y > SCREEN_V_MIN) Robot2.y -= Rand_Value;

	//--------------------------ロボット 3-----------------------//
	Rand_X = rand()%5;
	Rand_Value = rand()%7;
	if (Rand_X == 0) if (Robot3.x < SCREEN_H_MAX) Robot3.x += Rand_Value;
	if (Rand_X == 1) if (Robot3.x > SCREEN_H_MIN) Robot3.x -= Rand_Value;
	Rand_Y = rand()%5;
	Rand_Value = rand()%7;
	if (Rand_Y == 0) if (Robot3.y < SCREEN_V_MAX) Robot3.y += Rand_Value;
	if (Rand_Y == 1) if (Robot3.y > SCREEN_V_MIN) Robot3.y -= Rand_Value;

	//--------------------------ロボット 4-----------------------//
	Rand_X = rand()%5;
	Rand_Value = rand()%7;
	if (Rand_X == 0) if (Robot4.x < SCREEN_H_MAX) Robot4.x += Rand_Value;
	if (Rand_X == 1) if (Robot4.x > SCREEN_H_MIN) Robot4.x -= Rand_Value;
	Rand_Y = rand()%5;
	Rand_Value = rand()%7;
	if (Rand_Y == 0) if (Robot4.y < SCREEN_V_MAX) Robot4.y += Rand_Value;
	if (Rand_Y == 1) if (Robot4.y > SCREEN_V_MIN) Robot4.y -= Rand_Value;

	//--------------------------ロボット 5-----------------------//
	Rand_X = rand()%5;
	Rand_Value = rand()%7;
	if (Rand_X == 0) if (Robot5.x < SCREEN_H_MAX) Robot5.x += Rand_Value;
	if (Rand_X == 1) if (Robot5.x > SCREEN_H_MIN) Robot5.x -= Rand_Value;
	Rand_Y = rand()%5;
	Rand_Value = rand()%7;
	if (Rand_Y == 0) if (Robot5.y < SCREEN_V_MAX) Robot5.y += Rand_Value;
	if (Rand_Y == 1) if (Robot5.y > SCREEN_V_MIN) Robot5.y -= Rand_Value;


DEBUG_END


	//ジョイスティックコントローラー------------------------------------------------------------------------//

	if (jo_is_pad1_key_pressed(JO_KEY_UP))
	{
		if(Player0.y > SCREEN_V_MIN) {Player0.y-= SHIP_VELOCITY; Player0Direction = PLAYER_UP;}
	}

	if (jo_is_pad1_key_pressed(JO_KEY_DOWN))
	{
		if(Player0.y < SCREEN_V_MAX) {Player0.y+= SHIP_VELOCITY; Player0Direction = PLAYER_DOWN;}
	}

	if (jo_is_pad1_key_pressed(JO_KEY_RIGHT))
	{
		if(Player0.x < SCREEN_H_MAX) {Player0.x+= SHIP_VELOCITY; Player0Direction = PLAYER_RIGHT;}
	}

	if (jo_is_pad1_key_pressed(JO_KEY_LEFT))
	{
		if(Player0.x > SCREEN_H_MIN) {Player0.x-= SHIP_VELOCITY; Player0Direction = PLAYER_LEFT;}
	}

	//----------------------サターンPADボタンイベント-------------------//

	if (jo_is_pad1_key_pressed(JO_KEY_A))
	{
		jo_audio_play_sound_on_channel(&snd_bullet, 0);

		if(Render_Bullet != TRUE)
		{
			FBullet.x = Player0.x + 20;
			FBullet.y = Player0.y - 7;
		}

		Render_Bullet = TRUE;
	} else Render_Bullet = FALSE;

	if (jo_is_pad1_key_pressed(JO_KEY_C))
	{
		jo_audio_stop_cd();
	 	jo_goto_boot_menu();
	}

	if (jo_is_pad1_key_pressed(JO_KEY_X))
	{
		jo_core_suspend(); //一時停止し、続行するには[START]を押してください
	}


	//----------------------------コリジョンズロジック-----------------------------------------------//
    Render_Xplot0 = FALSE; Render_Xplot1 = FALSE;

	if(Collision(&Player0, TYPE &Robot1)) { jo_audio_play_sound_on_channel(&snd_xplot,1); Energy-=Dificulty; Render_Xplot0 = TRUE; }
	if(Collision(&Player0, TYPE &Robot2)) { jo_audio_play_sound_on_channel(&snd_xplot,1); Energy-=Dificulty; Render_Xplot0 = TRUE; }
	if(Collision(&Player0, TYPE &Robot3)) { jo_audio_play_sound_on_channel(&snd_xplot,1); Energy-=Dificulty; Render_Xplot0 = TRUE; }
	if(Collision(&Player0, TYPE &Robot4)) { jo_audio_play_sound_on_channel(&snd_xplot,1); Energy-=Dificulty; Render_Xplot0 = TRUE; }
	if(Collision(&Player0, TYPE &Robot5)) { jo_audio_play_sound_on_channel(&snd_xplot,1); Energy-=Dificulty; Render_Xplot0 = TRUE; }

	if(Collision(&FBullet, TYPE &Robot1)) { jo_audio_play_sound_on_channel(&snd_xplot,1); Level_Score+=Bonus; Score+=Bonus; Render_Xplot1 = TRUE; }
	if(Collision(&FBullet, TYPE &Robot2)) { jo_audio_play_sound_on_channel(&snd_xplot,1); Level_Score+=Bonus; Score+=Bonus; Render_Xplot1 = TRUE; }
	if(Collision(&FBullet, TYPE &Robot3)) { jo_audio_play_sound_on_channel(&snd_xplot,1); Level_Score+=Bonus; Score+=Bonus; Render_Xplot1 = TRUE; }
	if(Collision(&FBullet, TYPE &Robot4)) { jo_audio_play_sound_on_channel(&snd_xplot,1); Level_Score+=Bonus; Score+=Bonus; Render_Xplot1 = TRUE; }
	if(Collision(&FBullet, TYPE &Robot5)) { jo_audio_play_sound_on_channel(&snd_xplot,1); Level_Score+=Bonus; Score+=Bonus; Render_Xplot1 = TRUE; }


END_RUN


    //ゲームのルール----------------------------------------------------------//

	if(Level_Score >= NextLevel)
	{
		OnWinner();
	}

    if(Energy <= 0)
    {
    	OnGameOver();
    }





}


/*
-----------------------------------------------------------------------------
Function: Awake
Summary : すべてのアセットを読み込む
-----------------------------------------------------------------------------
*/

void Awake()
{

	id_spr_city1 = jo_sprite_add_tga("ASSETS", "CITY1.TGA", JO_COLOR_Transparent);
	id_spr_city2 = jo_sprite_add_tga("ASSETS", "CITY2.TGA", JO_COLOR_Transparent);
	id_spr_city3 = jo_sprite_add_tga("ASSETS", "CITY3.TGA", JO_COLOR_Transparent);
	id_spr_pilot = jo_sprite_add_tga("ASSETS", "PILOT.TGA", JO_COLOR_Transparent);

	Player0.id = jo_sprite_add_tga("ASSETS", "MAZINGER.TGA", JO_COLOR_Black);
	FBullet.id = jo_sprite_add_tga("ASSETS", "BULLET.TGA", JO_COLOR_Transparent);
	PowerShip.id = jo_sprite_add_tga("ASSETS", "POWER.TGA", JO_COLOR_Transparent);
	Fire.id = jo_sprite_add_tga("ASSETS", "FIRE.TGA", JO_COLOR_Transparent);

	id_spr_main = jo_sprite_add_tga("ASSETS", "MAIN.TGA", JO_COLOR_Transparent);
	id_spr_title = jo_sprite_add_tga("ASSETS", "TITLE.TGA", JO_COLOR_Transparent);
	id_spr_bonus = jo_sprite_add_tga("ASSETS", "BONUS.TGA", JO_COLOR_Transparent);
	id_spr_gameover = jo_sprite_add_tga("ASSETS", "GOVER.TGA", JO_COLOR_Transparent);
	id_spr_endgame = jo_sprite_add_tga("ASSETS", "END.TGA", JO_COLOR_Transparent);
	id_spr_saturn = jo_sprite_add_tga("ASSETS", "SATURN.TGA", JO_COLOR_Transparent);

	id_spr_mazinga = jo_sprite_add_tga("ASSETS", "JAP01.TGA", JO_COLOR_Transparent);

	Robot1.id = jo_sprite_add_tga("ASSETS", "ENEMY1.TGA", JO_COLOR_Black);
	Robot2.id = jo_sprite_add_tga("ASSETS", "ENEMY2.TGA", JO_COLOR_Black);
	Robot3.id = jo_sprite_add_tga("ASSETS", "ENEMY3.TGA", JO_COLOR_Black);
	Robot4.id = jo_sprite_add_tga("ASSETS", "ENEMY4.TGA", JO_COLOR_Black);
	Robot5.id = jo_sprite_add_tga("ASSETS", "ENEMY5.TGA", JO_COLOR_Black);

	jo_audio_load_pcm("BULLET.PCM", JoSoundMono16Bit, &snd_bullet);
	jo_audio_load_pcm("XPLOT.PCM", JoSoundMono16Bit, &snd_xplot);



}


/*
-----------------------------------------------------------------------------
Function: Start
Summary : ゲームを初期化する
-----------------------------------------------------------------------------
*/

void Start()
{

	Player0.x   = 141;
	Player0.y   = 107;
	Player0.z   = 500;
	Player0.w   = 31;
	Player0.h   = 48;
	Player0.active = TRUE;

	FBullet.x   = 141;
	FBullet.y   = 107;
	FBullet.z   = 500;
	FBullet.w   = 8;
	FBullet.h   = 8;
	FBullet.active = TRUE;

	PowerShip.x   = 141;
	PowerShip.y   = 107;
	PowerShip.z   = 500;
	PowerShip.w   = 16;
	PowerShip.h   = 16;
	PowerShip.active = TRUE;

	Fire.x   = 141;
	Fire.y   = 107;
	Fire.z   = 500;
	Fire.w   = 32;
	Fire.h   = 32;
	Fire.active = TRUE;

	Robot1.x   = 9;
	Robot1.y   = 70;
	Robot1.z   = 500;
	Robot1.w   = 32;
	Robot1.h   = 32;
	Robot1.active = TRUE;

	Robot2.x   = 57;
	Robot2.y   = 70;
	Robot2.z   = 500;
	Robot2.w   = 32;
	Robot2.h   = 32;
	Robot2.active = TRUE;

	Robot3.x   = 165;
	Robot3.y   = 70;
	Robot3.z   = 500;
	Robot3.w   = 32;
	Robot3.h   = 32;
	Robot3.active = TRUE;

	Robot4.x   = 207;
	Robot4.y   = 30;
	Robot4.z   = 500;
	Robot4.w   = 32;
	Robot4.h   = 32;
	Robot4.active = TRUE;

	Robot5.x   = 267;
	Robot5.y   = 50;
	Robot5.z   = 500;
	Robot5.w   = 32;
	Robot5.h   = 32;
	Robot5.active = TRUE;


	switch(Level)
	{

		case 1:
		{
			Dificulty      = 1;
			Enemy_Velocity = 3;
			Bonus          = 3;
			Energy         = 3000;
			Level_Score    = 0;
			NextLevel      = 400;
			break;
		}

		case 2:
		{
			Dificulty      = 1;
			Enemy_Velocity = 3;
			Bonus          = 3;
			Energy         = 3000;
			Level_Score    = 0;
			NextLevel      = 500;
			break;
		}

		case 3:
		{
			Dificulty      = 1;
			Enemy_Velocity = 3;
			Bonus          = 2;
			Energy         = 3000;
			Level_Score    = 0;
			NextLevel      = 600;
			break;
		}

		case 4:
		{
			Dificulty      = 1;
			Enemy_Velocity = 4;
			Bonus          = 3;
			Energy         = 3000;
			Level_Score    = 0;
			NextLevel      = 600;
			break;
		}

		case 5:
		{
			Dificulty      = 1;
			Enemy_Velocity = 4;
			Bonus          = 3;
			Energy         = 3000;
			Level_Score    = 0;
			NextLevel      = 600;
			break;
		}

		case 6:
		{
			Dificulty      = 1;
			Enemy_Velocity = 4;
			Bonus          = 3;
			Energy         = 3000;
			Level_Score    = 0;
			NextLevel      = 600;
			break;
		}

		case 7:
		{
			Dificulty      = 1;
			Enemy_Velocity = 4;
			Bonus          = 3;
			Energy         = 3000;
			Level_Score    = 0;
			NextLevel      = 600;
			break;
		}

		case 8:
		{
			Dificulty      = 1;
			Enemy_Velocity = 4;
			Bonus          = 3;
			Energy         = 3000;
			Level_Score    = 0;
			NextLevel      = 600;
			break;
		}

		case 9:
		{
			Dificulty      = 1;
			Enemy_Velocity = 4;
			Bonus          = 3;
			Energy         = 3000;
			Level_Score    = 0;
			NextLevel      = 600;
			break;
		}

		case 10:
		{
			Dificulty      = 1;
			Enemy_Velocity = 4;
			Bonus          = 3;
			Energy         = 3000;
			Level_Score    = 0;
			NextLevel      = 600;
			break;
		}

		case 11:
		{
			Dificulty      = 1;
			Enemy_Velocity = 4;
			Bonus          = 3;
			Energy         = 3000;
			Level_Score    = 0;
			NextLevel      = 600;
			break;
		}

		case 12:
		{
			Dificulty      = 1;
			Enemy_Velocity = 4;
			Bonus          = 3;
			Energy         = 3000;
			Level_Score    = 0;
			NextLevel      = 600;
			break;
		}

		case 13:
		{
			Dificulty      = 1;
			Enemy_Velocity = 4;
			Bonus          = 3;
			Energy         = 3000;
			Level_Score    = 0;
			NextLevel      = 600;
			break;
		}

		case 14:
		{
			Dificulty      = 1;
			Enemy_Velocity = 4;
			Bonus          = 3;
			Energy         = 3000;
			Level_Score    = 0;
			NextLevel      = 600;
			break;
		}

		case 15:
		{
			Dificulty      = 1;
			Enemy_Velocity = 4;
			Bonus          = 3;
			Energy         = 3000;
			Level_Score    = 0;
			NextLevel      = 600;
			break;
		}

		case 16:
		{
			Dificulty      = 1;
			Enemy_Velocity = 1;
			Bonus          = 2;
			Energy         = 7000;
			Level_Score    = 0;
			NextLevel      = 6500;
			break;
		}

	}


	srand(time(NULL));

	is_cd_playing = FALSE;

	Render_Bullet = 0;
	Render_Bullet_Timer = 0;

	Render_Xplot0 = 0;
	Render_Xplot1 = 0;

	Debug_Show = FALSE;

	Player0Direction = PLAYER_UP;


}



/*
-----------------------------------------------------------------------------
Function: FireAnimation
Summary : 衝突のための火災アニメーション
-----------------------------------------------------------------------------
*/

void FireAnimation()
{
	if(Render_Xplot0)
	{
		int r,t;

		Fire.x = Player0.x;
		Fire.y = Player0.y;

		for (r = 0; r <= 5; r++) //速度
		{
			Fire.x+= rand() % 7;
			Fire.y+= rand() % 7;
			jo_sprite_draw3D2(Fire.id,Fire.x,Fire.y,Fire.z);
		}
	}

	if(Render_Xplot1)
	{
		int r,t;

		Fire.x = FBullet.x;
		Fire.y = FBullet.y;

		for (r = 0; r <= 5; r++) //速度
		{
			Fire.x+= rand() % 7;
			Fire.y+= rand() % 7;
			jo_sprite_draw3D2(Fire.id,Fire.x,Fire.y,Fire.z);
		}
	}




}


/*
-----------------------------------------------------------------------------
Function: BulletAnimation
Summary : 船の弾丸
-----------------------------------------------------------------------------
*/

void BulletAnimation()
{
	if (Render_Bullet && (Render_Bullet_Timer == 0))
	    Render_Bullet_Timer = 20;

	if(Render_Bullet_Timer > 0)
	{
	    FBullet.active = TRUE;

	    /*
        switch(Player0Direction)
        {
        	case PLAYER_UP:    {FBullet.y -= BULLET_VELOCITY; break;}
        	case PLAYER_DOWN:  {FBullet.y += BULLET_VELOCITY; break;}
        	case PLAYER_RIGHT: {FBullet.x += BULLET_VELOCITY; break;}
        	case PLAYER_LEFT:  {FBullet.x -= BULLET_VELOCITY; break;}
		}
		*/

		FBullet.y -= BULLET_VELOCITY;

		jo_sprite_draw3D2(FBullet.id,FBullet.x,FBullet.y,FBullet.z);
		Render_Bullet_Timer--;
	}
	else
		FBullet.active = FALSE;

}




/*
-----------------------------------------------------------------------------
Function: PowerAnimation
Summary : パワーアニメーション
-----------------------------------------------------------------------------
*/

void PowerAnimation()
{
		int r,t;

		PowerShip.x = Player0.x+7;
		PowerShip.y = Player0.y + 20;

		for (r = 0; r <= 3; r++) //速度
		{
			PowerShip.x+= rand() % 7;
			PowerShip.y+= rand() % 7;
			jo_sprite_draw3D2(PowerShip.id,PowerShip.x,PowerShip.y,PowerShip.z);
		}

}



/*
-----------------------------------------------------------------------------
Function: OnWinner
Summary : 勝者アニメーション
-----------------------------------------------------------------------------
*/

void OnWinner()
{

   	jo_audio_stop_cd();
   	is_cd_playing = FALSE;
   	Run = FALSE;

	jo_clear_background(JO_COLOR_Black);


	if(Level < 16)
	{
		jo_printf(12,27,"CONGRATULATIONS!");
		jo_sprite_draw3D(id_spr_bonus,0,0,500);
	}
	else
	{
		jo_printf(12,27,"    END OF GAME!");
		jo_sprite_draw3D(id_spr_endgame,0,0,500);
	}


	timer[1]++;
	if(timer[1] > 500)
	{
        Score+=Level_Score;

		if(Level < 16)
			Level++;
		else
			jo_goto_boot_menu();

		Start();
		Run = TRUE;
		timer[1]=0;
	}

}


/*
-----------------------------------------------------------------------------
Function: Splash
Summary : メイン画面ゲーム
-----------------------------------------------------------------------------
*/

void Splash()
{
	if(game_status != MAZINGER_MENU) return;

 	if(!is_cd_playing)
    {
        jo_audio_play_cd_track(TRACK_INTRO,TRACK_INTRO, CD_LOOP);
        is_cd_playing = TRUE;
    }

	Level = 1;
	Score = 0;

    jo_clear_screen();
	jo_clear_background(JO_COLOR_Black);


	timer[0]++;

	if(timer[0] > 1)
	{
		jo_printf(24,17,"PRESS START...");
		timer[0]=0;
	}

	jo_printf(1,28,"(c)Nova32, Rolando Fernandez Benavidez 2019.");

	jo_sprite_draw3D2(id_spr_title,10,0,500);
	jo_sprite_draw3D2(id_spr_main,0,50,500);
	jo_sprite_draw3D2(id_spr_saturn,270,185,500);
	jo_sprite_draw3D2(id_spr_mazinga,80,180,500);

	if (jo_is_pad1_key_pressed(JO_KEY_START))
	{
		jo_clear_screen();
		game_status = MAZINGER_PLAY;
		Start();
		jo_audio_stop_cd();
		is_cd_playing = FALSE;
		Run = TRUE;
	}

}


/*
-----------------------------------------------------------------------------
Function: Init_mode7
Summary : 初期化モード7
-----------------------------------------------------------------------------
*/

void Init_mode7()
{
    tile.data = JO_NULL;
    jo_tga_loader(&tile,"ASSETS","MODE7.TGA", JO_COLOR_Transparent);

    mode7.space_z = 50;
    mode7.horizon = 140; //地平線(y)
    mode7.scale_x = 100;
    mode7.scale_y = 500;
    mode7.output_left = 0;
    mode7.output_top =  0;

	jo_init_mode7_for_screen_output(&mode7, tile.width, tile.height);
    need_redraw_background = 1;
}


/*
-----------------------------------------------------------------------------
Function: Splash
Summary : ゲームでmode7を描く
-----------------------------------------------------------------------------
*/

void Render_mode7()
{
        need_redraw_background = 0;
        jo_update_screen_output_coord_for_mode7(&mode7);
        jo_do_mode7_floor(&tile,0, floor_pos_y, &mode7);
}


//ゲーム用の変数とグローバルタイプを含むファイル。




