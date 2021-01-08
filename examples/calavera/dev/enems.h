// MTE MK1 (la Churrera) v4
// Copyleft 2010-2014, 2020 by the Mojon Twins

// Generated by ene2h.exe from ..\enems\enems.ene
// Copyleft 2010, 2017, 2020 by The Mojon Twins

typedef struct {
	unsigned char x, y;
	unsigned char x1, y1, x2, y2;
	char mx, my;
	char t;
#if defined PLAYER_CAN_FIRE || defined ENABLE_SWORD
	unsigned char life;
#endif
} MALOTE;

MALOTE malotes [] = {
	// Pantalla 0
 	{16, 16, 16, 16, 32, 16, 1, 0, 5},
 	{112, 112, 112, 64, 112, 112, 0, -2, 2},
 	{80, 128, 32, 128, 80, 128, -1, 0, 1},

	// Pantalla 1
 	{96, 64, 96, 64, 112, 112, 1, 1, 1},
 	{48, 32, 48, 32, 48, 96, 0, 2, 2},
 	{176, 128, 176, 128, 208, 128, 1, 0, 1},

	// Pantalla 2
 	{144, 16, 144, 16, 192, 128, 4, 4, 1},
 	{208, 48, 144, 48, 208, 96, -2, 2, 2},
 	{160, 112, 160, 32, 192, 112, 1, -1, 1},

	// Pantalla 3
 	{96, 16, 96, 16, 112, 16, 1, 0, 5},
 	{96, 32, 96, 32, 112, 32, 1, 0, 5},
 	{96, 48, 96, 48, 112, 48, 1, 0, 5},

	// Pantalla 4
 	{112, 128, 112, 64, 112, 128, 0, -2, 4},
 	{192, 80, 144, 80, 192, 80, -1, 0, 1},
 	{96, 128, 96, 80, 96, 128, 0, -1, 2},

	// Pantalla 5
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 6
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 7
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 8
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 9
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 10
 	{96, 112, 64, 112, 96, 112, -1, 0, 1},
 	{16, 16, 16, 16, 32, 16, 1, 0, 5},
 	{16, 32, 16, 32, 32, 32, 1, 0, 5},

	// Pantalla 11
 	{112, 80, 80, 80, 112, 80, -1, 0, 1},
 	{48, 112, 48, 32, 48, 112, 0, -2, 1},
 	{144, 48, 144, 48, 208, 128, 1, 1, 2},

	// Pantalla 12
 	{48, 16, 48, 16, 96, 80, 1, 1, 1},
 	{32, 128, 32, 128, 80, 128, 1, 0, 2},
 	{128, 96, 128, 96, 160, 96, 1, 0, 2},

	// Pantalla 13
 	{48, 144, 48, 64, 48, 144, 0, -2, 4},
 	{80, 64, 80, 64, 176, 64, 1, 0, 1},
 	{64, 144, 64, 128, 64, 144, 0, -1, 5},

	// Pantalla 14
 	{192, 128, 64, 128, 192, 128, -1, 0, 1},
 	{160, 96, 128, 96, 160, 96, -1, 0, 2},
 	{144, 64, 144, 64, 160, 64, 1, 0, 1},

	// Pantalla 15
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 16
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 17
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 18
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 19
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 20
 	{48, 16, 48, 16, 64, 16, 1, 0, 5},
 	{48, 32, 48, 32, 64, 32, 1, 0, 5},
 	{48, 48, 48, 48, 64, 48, 1, 0, 5},

	// Pantalla 21
 	{128, 48, 128, 48, 144, 128, 1, 1, 1},
 	{160, 80, 160, 80, 160, 128, 0, 1, 2},
 	{112, 112, 16, 112, 112, 112, -1, 0, 4},

	// Pantalla 22
 	{160, 80, 160, 80, 160, 96, 0, 1, 5},
 	{112, 96, 64, 96, 112, 96, -1, 0, 1},
 	{192, 96, 192, 64, 192, 96, 0, -2, 2},

	// Pantalla 23
 	{96, 16, 96, 16, 96, 32, 0, 1, 5},
 	{160, 16, 160, 16, 160, 32, 0, 1, 5},
 	{48, 112, 48, 112, 80, 112, 1, 0, 2},

	// Pantalla 24
 	{176, 48, 144, 48, 176, 48, -1, 0, 2},
 	{176, 32, 176, 32, 176, 48, 0, 1, 5},
 	{80, 16, 80, 16, 80, 80, 0, 1, 1},

	// Pantalla 25
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 26
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 27
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 28
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 29
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 30
 	{48, 32, 48, 32, 64, 80, 1, 1, 2},
 	{160, 64, 96, 64, 160, 64, -1, 0, 1},
 	{192, 0, 192, 0, 192, 48, 0, 1, 1},

	// Pantalla 31
 	{160, 16, 160, 16, 160, 80, 0, 1, 4},
 	{176, 64, 176, 64, 176, 112, 0, 1, 4},
 	{96, 32, 16, 32, 96, 32, -1, 0, 1},

	// Pantalla 32
 	{64, 0, 64, 0, 64, 80, 0, 1, 2},
 	{96, 64, 96, 0, 96, 64, 0, -1, 1},
 	{224, 16, 144, 16, 224, 48, -1, 1, 1},

	// Pantalla 33
 	{144, 96, 32, 96, 144, 96, -2, 0, 4},
 	{48, 96, 48, 96, 128, 128, 2, 2, 1},
 	{208, 32, 160, 32, 208, 32, -1, 0, 2},

	// Pantalla 34
 	{32, 128, 32, 128, 48, 128, 1, 0, 5},
 	{64, 128, 64, 128, 80, 128, 1, 0, 5},
 	{208, 32, 0, 32, 208, 32, -1, 0, 1},

	// Pantalla 35
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 36
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 37
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 38
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 39
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 40
 	{144, 80, 80, 80, 144, 80, -1, 0, 1},
 	{160, 112, 160, 16, 160, 112, 0, -2, 2},
 	{176, 48, 176, 48, 208, 112, 1, 1, 1},

	// Pantalla 41
 	{64, 144, 64, 16, 64, 144, 0, -1, 4},
 	{144, 64, 144, 16, 160, 64, 1, -1, 2},
 	{208, 32, 176, 32, 208, 32, -1, 0, 1},

	// Pantalla 42
 	{32, 48, 32, 0, 32, 48, 0, -1, 1},
 	{160, 32, 160, 32, 192, 80, 2, 2, 2},
 	{176, 144, 176, 16, 176, 144, 0, -1, 4},

	// Pantalla 43
 	{16, 112, 16, 16, 16, 112, 0, -1, 4},
 	{176, 32, 176, 32, 192, 32, 1, 0, 5},
 	{160, 48, 160, 48, 176, 48, 1, 0, 5},

	// Pantalla 44
 	{48, 128, 48, 48, 48, 128, 0, -1, 4},
 	{80, 64, 80, 64, 208, 64, 1, 0, 4},
 	{112, 48, 112, 48, 160, 80, 2, 2, 2},

	// Pantalla 45
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 46
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 47
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 48
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 49
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 50
 	{160, 128, 160, 128, 160, 144, 0, 0, 15},
 	{144, 48, 144, 48, 144, 64, 0, 0, 15},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 51
 	{192, 64, 192, 64, 192, 80, 0, 0, 15},
 	{144, 144, 144, 144, 160, 144, 0, 0, 15},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 52
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 53
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 54
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 55
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 56
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 57
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 58
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},

	// Pantalla 59
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 0, 0, 0, 0, 0}

};

#define N_ENEMS_TYPE_0 101
#define N_ENEMS_TYPE_1 27
#define N_ENEMS_TYPE_2 19
#define N_ENEMS_TYPE_3 0
#define N_ENEMS_TYPE_5 18
#define N_ENEMS_TYPE_6 0
#define N_ENEMS_TYPE_7 0
#define N_ENEMS_TYPE_15 4

// This is output the way it worked originally, please modify if you need
// You may want to add type 5 or 6's below.
#define BADDIES_COUNT (N_ENEMS_TYPE_1+N_ENEMS_TYPE_2+N_ENEMS_TYPE_3)

typedef struct {
	unsigned char xy, tipo, act;
} HOTSPOT;

HOTSPOT hotspots [] = {
	{38, 1, 0}, 
	{32, 1, 0}, 
	{114, 1, 0}, 
	{0, 0, 0}, 
	{195, 1, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{54, 1, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{136, 1, 0}, 
	{97, 1, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{36, 1, 0}, 
	{0, 0, 0}, 
	{177, 1, 0}, 
	{0, 0, 0}, 
	{146, 1, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{36, 1, 0}, 
	{0, 0, 0}, 
	{212, 1, 0}, 
	{180, 1, 0}, 
	{193, 1, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{116, 1, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{179, 1, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}, 
	{0, 0, 0}
};

#define N_HOTSPOTS_TYPE_0 44
#define N_HOTSPOTS_TYPE_1 16
#define N_HOTSPOTS_TYPE_2 0
#define N_HOTSPOTS_TYPE_3 0
#define N_HOTSPOTS_TYPE_4 0
#define N_HOTSPOTS_TYPE_5 0
#define N_HOTSPOTS_TYPE_6 0
#define N_HOTSPOTS_TYPE_7 0

