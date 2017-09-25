# MazingerZ
Mazinger Z Homebrew Game

Welcome to the video game "Mazinger Z Homebrew", which tries to amuse the Gamers with a 2D Arcade type interface, making use of the classic Scrolling genre of videogames from the time of the memorable 80's.

At the same time allows to make a modest tribute to the series of Japanese anime Mazinger Z, which laid the bases of the anime of Mechas.

If you made a payment to obtain this video game, this amount is equivalent only to the costs of writing, printing, distributing or shipping DVD discs and packaging.

Your payment covers these costs and represents a recovery fee for the dealer of the same.

The video game "Mazinger Z Homebrew" is freely distributed and free.

In the package you will find 2 disks, one containing the video game to be executed on a PlayStation 2 (Slim), which must have a ModChip installed to be able to run Backups.

The second disk contains the source code in BennuGD programming language, Manuals in PDF format, GNU/GPL license version 3.0 and multimedia material for Mac, Windows or Linux.

The game launcher resides in the IO.SYS binary which was written using the PS2SDK tools (https://github.com/ps2dev/ps2sdk) and the popular BennuGD programming language (https://forum.bennugd.org /index.php).

The BennuGD port for PlayStation 2 (bennugd.elf) was created by the ColDev development team, later I had to modify it to get IO.SYS, the current launcher of the Mazinger Z Homebrew DCB program.


Starter Sequence of Mazinger Z Homebrew:

1. PlayStation2 console reads the file SYSTEM.CNF
2. IO.SYS is run
3. IO.SYS validates the existence of the NTSC.SYS, GMLOAD.SYS and PS2OS.SYS program which contains the bytecode of BennuGD.
4. Starts the video game of Mazinger Z
5. The game makes calls to IO.SYS using the IOSYS API functions.



"I hope you enjoy"



Best regards.
Rolando Fernández Benavidez (Folken), September 25, 2017.
Programmer.
