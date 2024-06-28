// msc.h
// Generated by Mojon Script Compiler v3.97 20191202 from MT Engine MK1 v5.0+
// Copyleft 2015 The Mojon Twins

#ifdef CLEAR_FLAGS
void msc_init_all (void) {
    for (sc_c = 0; sc_c < MAX_FLAGS; ++ sc_c)
        flags [sc_c] = 0;
}
#endif

unsigned char read_byte (void) {
    #asm
            di
            ld b, SCRIPT_PAGE
            call SetRAMBank

            ld  hl, (_script)
            ld  a, (hl)
            ld  (_safe_byte), a
            inc hl
            ld  (_script), hl

            ld b, 0
            call SetRAMBank
            ei
    #endasm
    return safe_byte;
}

unsigned char read_vbyte (void) {
    #asm
        call _read_byte
        ld  a, l
        and 128
        ret z
        ld  a, l
        and 127
        ld  c, a
        ld  b, 0
        ld  hl, _flags
        add hl, bc
        ld  l, (hl)
        ld  h, 0
        ret
    #endasm
}

void readxy (void) {
    sc_x = read_vbyte ();
    sc_y = read_vbyte ();
}

void stop_player (void) {
    p_vx = p_vy = 0;
}

void reloc_player (void) {
    p_x = read_vbyte () << (4+FIXBITS);
    p_y = read_vbyte () << (4+FIXBITS);
    stop_player ();
}

void read_two_bytes_D_E (void) {
    #asm
            // Read two bytes: flag #, number

                di
                ld  b, SCRIPT_PAGE
                call SetRAMBank

                ld  hl, (_script)
                ld  d, (hl)         // flag #
                inc hl
                ld  e, (hl)         // number
                inc hl
                ld  (_script), hl

                ld  b, 0
                call SetRAMBank
                ei
    #endasm
}
unsigned char *next_script;
void run_script (unsigned char whichs) {

    // main_script_offset contains the address of scripts for current level
    asm_int = main_script_offset + whichs + whichs;
#ifdef DEBUG
    debug_print_16bits (0, 23, asm_int);
#endif

    #asm
        di
        ld b, SCRIPT_PAGE
        call SetRAMBank
    #endasm

    #asm
        ld hl, (_asm_int)
        ld a, (hl)
        inc hl
        ld h, (hl)
        ld l, a
        ld  (_script), hl
    #endasm

    #asm
        ld b, 0
        call SetRAMBank
        ei
    #endasm

#ifdef DEBUG
    debug_print_16bits (5, 23, (unsigned int) script);
#endif

    if (script == 0)
        return;

    script += main_script_offset;
#ifdef DEBUG
    debug_print_16bits (10, 23, (unsigned int) script);
#endif


    while ((sc_c = read_byte ()) != 0xFF) {
        next_script = script + sc_c;
        sc_terminado = sc_continuar = 0;
        while (!sc_terminado) {
            switch (read_byte ()) {
                case 0x10:
                    // IF FLAG sc_x = sc_n
                    // Opcode: 10 sc_x sc_n
                    // readxy ();
                    // sc_terminado = (flags [sc_x] != sc_y);
                    #asm
                            call _read_two_bytes_D_E
                            // Set sc_terminado if flags [C] != E
                            ld  b, 0
                            ld  c, d
                            ld  hl, _flags
                            add hl, bc
                            ld  a, (hl)
                            cp  e
                            jr  z, _flag_equal_val_ok
                            ld  a, 1
                            ld  (_sc_terminado), a
                        ._flag_equal_val_ok
                    #endasm
                    break;
                case 0x20:
                    // IF PLAYER_TOUCHES sc_x, sc_y
                    // Opcode: 20 sc_x sc_y
                    readxy ();
                    sc_x <<= 4; sc_y <<= 4;
                    sc_terminado = (!(gpx + 15 >= sc_x && gpx <= sc_x + 15 && gpy + 15 >= sc_y && gpy <= sc_y + 15));
                    break;
                case 0xF0:
                     // IF TRUE
                     // Opcode: F0
                     break;
                case 0xFF:
                    // THEN
                    // Opcode: FF
                    sc_terminado = 1;
                    sc_continuar = 1;
                    break;
            }
        }
        if (sc_continuar) {
            sc_terminado = 0;
            while (!sc_terminado) {
                switch (read_byte ()) {
                    case 0x20:
                        // SET TILE (sc_x, sc_y) = sc_n
                        // Opcode: 20 sc_x sc_y sc_n
                        readxy ();
                        sc_n = read_vbyte ();
                        _x = sc_x; _y = sc_y; _n = behs [sc_n]; _t = sc_n; update_tile ();
                        break;
                    case 0x69:
                        // WARP_TO_LEVEL
                        // Opcode: 69 l n_pant x y silent
                        level = read_vbyte ();
                        n_pant = read_vbyte ();
                        o_pant = 99;
                        reloc_player ();
                        silent_level = read_vbyte ();
                        sc_terminado = 1;
                        script_result = 3;
                        return;
                    case 0xE4:
                        // EXTERN sc_n
                        // Opcode: 0xE4 sc_n
                        do_extern_action (read_byte ());
                        break;
                    case 0xE6:
                        // MUSIC n
                        sc_n = read_vbyte ();
                        if (sc_n == 0xff) {
                            STOP_SOUND ();
                        } else {
                            PLAY_MUSIC (sc_n);
                        }
                        break;
                    case 0xF3:
                        // Final del todo
                        script_result = 4;
                        return;
                        break;
                    case 0xF4:
                        // DECORATIONS
                        while (0xff != (sc_x = read_byte ())) {
                            sc_n = read_byte ();
                            _x = sc_x >> 4; _y = sc_x & 15; _n = behs [sc_n]; _t = sc_n; update_tile ();
                        }
                        break;
                    case 0xFF:
                        sc_terminado = 1;
                        break;
                }
            }
        }
        script = next_script;
    }
}