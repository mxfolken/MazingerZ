#
#    This program is distributed in the hope that it will be useful,
#    but without any warranty, without even the implied warranty of
#    particular purpose.
#
#	  Nova32 Development Software
#	  (c) Rolando Fernandez Benavidez, March 2019.
#
#--------------------------------------------------------------------------
#                       M A Z I N G E R   Z   -HOMEBREW-
#
#                                 マジンガーz
#
#                  セガサターンで動作するようにプログラムされたアクションゲーム。
#
#                                 use only
#                           GNU GCC-COFF & Jo-Engine
#
#    このプログラムはフリーソフトウェアです：あなたはそれを再配布することができますおよび/
#    または変更することができます
#    によって公開されているGNU一般公衆利用許諾契約書の条項の下で
#    Free Software Foundation、ライセンスのバージョン3、または
#    （あなたの選択で）それ以降のバージョン。
#
#    このプログラムは、役に立つことを願って配布されています。
#    しかし、いかなる保証もありません。 の黙示的な保証もありません。
#    商品性または特定の目的への適合性。 を参照してください
#    詳細については、GNU General Public License。
#
#    あなたはGNU General Public Licenseのコピーを受け取っているはずです。
#    このプログラムと一緒に。 そうでない場合は、<https://www.nova32.com.mx>を参照してください。
#    <（c）Rolando Fernández Benavidez 2019>。
#
# Platform: SEGA SATURN
#
# Version 3.0.0
#
JO_COMPILE_WITH_VIDEO_MODULE = 0
JO_COMPILE_WITH_BACKUP_MODULE = 0
JO_COMPILE_WITH_TGA_MODULE = 1
JO_COMPILE_WITH_AUDIO_MODULE = 1
JO_COMPILE_WITH_3D_MODULE = 0
JO_COMPILE_WITH_PSEUDO_MODE7_MODULE = 1
JO_COMPILE_WITH_EFFECTS_MODULE = 0
JO_DEBUG = 1
JO_COMPILE_USING_SGL=1
JO_COMPILE_WITH_DUAL_CPU_MODULE = 1
SRCS=main.c mazinger.c
JO_ENGINE_SRC_DIR=../../jo_engine
COMPILER_DIR=../../Compiler
include $(COMPILER_DIR)/COMMON/jo_engine_makefile
