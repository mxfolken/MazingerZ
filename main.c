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
#include <jo/jo.h>

extern void Exec_Game();   //外部機能

void jo_main(void)
{
	Exec_Game();  //モーター入口点
}


//ゲーム用の変数とグローバルタイプを含むファイル。




