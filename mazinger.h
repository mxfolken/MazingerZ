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


#ifndef __MAZINGER_H__
# define __MAZINGER_H__


#define MAZINGER_DEBUG

//Functions prototype:

//関数定義を含むヘッダファイル
                                                  //この関数は日立SH-2 CPUのテストを実行することを可能にし、
void Exec_Assembler_Hitachi_SH2_CPU(void);        //SDKがSEGA Saturnハードウ
void OnWinner();                                  //ェアへのフルアクセスでCOFFフォーマットでバイナリをコンパイルす
void SetBackground(void);                         //ることを可能にすることを実証します。
int  Collision(PLAYER *A,PLAYER *B);
void Stars(void);
void Frame(void);
void play_song(void);
void OnGameOver();
void Update();              //ゲームロジック
void Awake();
void Start();
void Splash();
void Debug(void);           //デバッグする機能
void PowerAnimation();
void BulletAnimation();
void FireAnimation();
void Init_mode7();          //MODO7を起動
void Render_mode7();        //MODE7を描く

#endif


//ゲーム用の変数とグローバルタイプを含むファイル。


