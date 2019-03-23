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

#ifndef __GLOBAL_H__
# define __GLOBAL_H__


//ゲーム用の変数とグローバルタイプを含むファイル。

#define MAZINGER_VERSION 3

#define MAXMAP 10
#define TYPE
#define SCREEN_V_MIN   0
#define SCREEN_V_MAX   107
#define SCREEN_H_MIN   0
#define SCREEN_H_MAX   288

#define CD_LOOP         1    //音楽トラックの制御
#define TRACK_INTRO     2    //主な音楽
#define TRACK_LEVEL1    3
#define TRACK_LEVEL2    4
#define TRACK_LEVEL3    5
#define TRACK_LEVEL4    6
#define TRACK_LEVEL5    7

#define RUN             if(Run){      //ゲームは実行中です
#define END_RUN         }

#define DEBUG_GO        if(Debug_Show == FALSE){   //デバッガを表示する
#define DEBUG_END       }

#define SPEED_POS        (7)

#define BULLET_VELOCITY  7
#define SHIP_VELOCITY    5


//プレイヤーの方向制御
enum ePlayerDirection
{
    PLAYER_UP    = 0x0001,
    PLAYER_DOWN  = 0x0002,
    PLAYER_RIGHT = 0x0003,
    PLAYER_LEFT  = 0x0004
};


//エンジン内のゲーム状態
enum eGameStatus
{
	MAZINGER_MENU = 0x001,
	MAZINGER_PLAY = 0x002,
	MAZINGER_STOP = 0x003
};


//アクターのデータ構造
struct __stPlayer
{
	int id;
	int x;
	int y;
	int z;
	int w;
	int h;
	int active;
};
typedef struct __stPlayer PLAYER;

//アクターの定義
PLAYER 	Player0,
		FBullet,
		PowerShip,
		Fire,
		Robot1,
		Robot2,
		Robot3,
		Robot4,
		Robot5;

//スプライトハンドラ
int id_spr_city1;
int id_spr_city2;
int id_spr_city3;
int id_spr_use;
int id_spr_pilot;
int id_spr_gameover;
int id_spr_main;
int id_spr_title;
int id_spr_bonus;
int id_spr_endgame;
int id_spr_mazinga;
int id_spr_saturn;


int game_status;
char str[80];

int Dificulty;
int Enemy_Velocity;
int Energy;
int Level;
int Score;
int Level_Score;
int Bonus;
int NextLevel;

int timer[10];
int Rand_X;
int Rand_Y;
int	Rand_Value;
int is_cd_playing;

static jo_sound snd_bullet;
static jo_sound snd_xplot;

int idx_std=MAXMAP-2;
int idx_in=0;

int Run;
int Debug_Show;

int Render_Bullet;
int Render_Bullet_Timer;

int Render_Xplot0;
int Render_Xplot1;


//システム情報
struct __stSaturnSystem
{
	int RAM;
	int VRAM;
	int Language;
}Environment;


static jo_img       tile;
static jo_mode7     mode7;
static int          floor_pos_y = 0;
static int          need_redraw_background = 0;

int Player0Direction;


#endif

//ゲーム用の変数とグローバルタイプを含むファイル。


