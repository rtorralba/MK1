// MTE MK1 v4.8
// Copyleft 2010, 2011, 2020 by The Mojon Twins

// ISR routine
// isr

#asm
	defw 0	// 2 bytes libres
#endasm

void ISR (void) {	
	#ifdef MIN_FAPS_PER_FRAME
		#asm
				ld  hl, _isrc
				inc (hl)
			#if defined MODE_128K_DUAL && defined ENABLE_ARKOS
					ld  a, (_ay_player_on)
					or  a
					jr  z, skip_arkos
					
					ld  b, ARKOS_RAM
					call SetRAMBank
					call ARKOS_ADDRESS_ATPLAY
					ld  b, 0
					call SetRAMBank

				.skip_arkos
			#endif
		#endasm
	#endif
}
