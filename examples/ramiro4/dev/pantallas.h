// MTE MK1 v4.8
// Copyleft 2010, 2011, 2020 by The Mojon Twins

// pantallas.h
// Includes the binary of the aplib-compressed static screens.
// title.bin, marco.bin (if suited) and ending.bin should be
// in the same directory.

extern unsigned char s_title [];
extern unsigned char s_marco [];
extern unsigned char s_ending [];

#asm
	._s_title
		BINARY "title.bin"
	._s_marco
#endasm
#ifndef DIRECT_TO_PLAY
#asm
		BINARY "marco.bin"
#endasm
#endif
#asm
	._s_ending
		BINARY "ending.bin"
#endasm

void unpack (void) {
	#asm
		ld hl, 22528
		ld de, 22529
		ld bc, 767
		xor a
		ld (hl), a
		ldir

		ld hl, (_asm_int)
		ld de, 16384
		jp depack
	#endasm
}

void espera_activa (int espera) {
	// Waits until "espera" halts have passed 
	// or a key has been pressed.

	#asm 
		ei
	#endasm
	while (espera--)  {
		#asm
			halt
		#endasm
		if (any_key ()) {
			break;
		}
	}
	#asm
		di
	#endasm
}

void title_screen (void) {
	sp_UpdateNow();
	asm_int = (unsigned int) (s_title); unpack ();

	#asm
		; Music generated by beepola
		call musicstart
		di
	#endasm
	
	while (1) {
		if (sp_KeyPressed (key_1)) {
			joyfunc = sp_JoyKeyboard; break;
		} else if (sp_KeyPressed (key_2)) {
			joyfunc = sp_JoyKempston; break;
		} else if (sp_KeyPressed (key_3)) {
			joyfunc = sp_JoySinclair1; break;
		}			
	}
}

void game_ending (void) {
	sp_UpdateNow();
	asm_int = (unsigned int) (s_ending); unpack ();
	beepet (); peta_el_beeper (11);
	espera_activa (500);
}

void game_over (void) {
	draw_rectangle (10, 11, 21, 13, GAME_OVER_ATTR);		
	draw_text (11, 12, GAME_OVER_ATTR, "GAME OVER!");
	sp_UpdateNow ();
	beepet (); peta_el_beeper (10);
	espera_activa (500);
}