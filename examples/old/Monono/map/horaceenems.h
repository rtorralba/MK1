#define BADDIES_COUNT 65

typedef struct {
	int x, y;
	unsigned char x1, y1, x2, y2;
	char mx, my;
	char t;
#ifdef PLAYER_CAN_FIRE
	unsigned char life;
#endif
} MALOTE;

MALOTE malotes [] = {
	{32, 112, 32, 112, 192, 112, 1, 0, 4},
	{96, 96, 96, 96, 192, 96, 1, 0, 1},
	{0, 0, 0, 0, 0, 0, 0, 0, 0},
	{144, 80, 144, 80, 144, 128, 0, 1, 1},
	{160, 128, 160, 128, 160, 96, 0, -1, 1},
	{144, 16, 144, 16, 32, 16, -1, 0, 2},
	{160, 80, 160, 80, 160, 128, 0, 2, 3},
	{80, 128, 80, 128, 80, 80, 0, -2, 3},
	{144, 16, 144, 16, 160, 16, 1, 0, 1},
	{32, 112, 32, 112, 192, 112, 2, 0, 4},
	{208, 64, 208, 64, 208, 64, 0, 0, 3},
	{16, 64, 16, 64, 32, 64, 0, 0, 3},
	{80, 16, 80, 16, 64, 64, -1, 1, 3},
	{208, 128, 208, 128, 32, 128, -2, 0, 4},
	{0, 0, 0, 0, 0, 0, 0, 0, 0},
	{208, 128, 208, 128, 16, 128, -2, 0, 4},
	{48, 64, 48, 64, 160, 64, 2, 0, 2},
	{192, 16, 192, 16, 192, 112, 0, 2, 3},
	{128, 16, 128, 16, 128, 80, 0, 2, 3},
	{96, 32, 96, 32, 96, 80, 0, 2, 3},
	{64, 16, 64, 16, 64, 96, 0, 2, 3},
	{48, 96, 48, 96, 176, 96, 2, 0, 3},
	{112, 32, 112, 32, 128, 32, 0, 0, 1},
	{16, 80, 16, 80, 208, 80, 2, 0, 4},
	{32, 96, 32, 96, 96, 96, 2, 0, 1},
	{160, 64, 160, 64, 80, 64, -1, 0, 1},
	{144, 32, 144, 32, 208, 32, 2, 0, 1},
	{32, 64, 32, 64, 192, 64, 2, 0, 2},
	{160, 96, 160, 96, 16, 96, -1, 0, 1},
	{208, 32, 208, 32, 32, 32, -4, 0, 3},
	{16, 64, 16, 64, 208, 64, 2, 0, 1},
	{208, 96, 208, 96, 16, 96, -2, 0, 1},
	{96, 112, 96, 112, 128, 128, 1, 1, 3},
	{176, 112, 176, 112, 48, 112, -2, 0, 4},
	{64, 64, 64, 64, 64, 16, 0, -2, 1},
	{80, 80, 80, 80, 208, 32, 1, -1, 3},
	{64, 32, 64, 32, 208, 32, 1, 0, 1},
	{208, 96, 208, 96, 16, 96, -1, 0, 2},
	{16, 16, 16, 16, 48, 80, 2, 2, 3},
	{16, 80, 16, 80, 112, 80, 2, 0, 4},
	{208, 32, 208, 32, 144, 32, -2, 0, 2},
	{32, 128, 32, 128, 192, 128, 2, 0, 3},
	{16, 96, 16, 96, 128, 96, 2, 0, 1},
	{192, 64, 192, 64, 48, 64, -1, 0, 1},
	{176, 16, 176, 16, 80, 16, -1, 0, 3},
	{208, 112, 208, 112, 80, 112, -2, 0, 1},
	{16, 80, 16, 80, 48, 128, 1, 1, 3},
	{176, 112, 176, 112, 176, 16, 0, -1, 4},
	{16, 112, 16, 112, 96, 128, 1, 1, 1},
	{208, 112, 208, 112, 128, 128, -1, 1, 2},
	{144, 80, 144, 80, 80, 80, -1, 0, 3},
	{208, 80, 208, 80, 32, 80, -1, 0, 1},
	{144, 32, 144, 32, 64, 32, -1, 0, 1},
	{16, 112, 16, 112, 208, 128, 1, 1, 3},
	{96, 128, 96, 128, 96, 16, 0, -2, 4},
	{32, 16, 32, 16, 64, 16, 1, 0, 2},
	{144, 16, 144, 16, 208, 128, 2, 2, 3},
	{192, 48, 192, 48, 16, 48, -1, 0, 1},
	{16, 96, 16, 96, 176, 96, 1, 0, 2},
	{64, 144, 64, 144, 64, 32, 0, -2, 4},
	{192, 32, 192, 32, 16, 32, -2, 0, 3},
	{48, 64, 48, 64, 80, 128, 1, 1, 1},
	{64, 144, 64, 144, 208, 144, 1, 0, 4},
	{32, 16, 32, 16, 32, 144, 0, 2, 4},
	{160, 96, 160, 96, 48, 96, -2, 0, 2},
	{16, 16, 16, 16, 16, 64, 0, 1, 1},
	{112, 16, 112, 16, 112, 112, 0, 1, 3},
	{176, 48, 176, 48, 176, 112, 0, 2, 3},
	{16, 32, 16, 32, 16, 112, 0, 2, 3},
	{192, 16, 192, 16, 192, 128, 0, 1, 1},
	{144, 128, 144, 128, 48, 128, -2, 0, 4},
	{32, 32, 32, 32, 32, 128, 0, 2, 3},
	{192, 128, 192, 128, 192, 32, 0, -2, 4},
	{128, 128, 128, 128, 128, 32, 0, -1, 4},
	{48, 128, 48, 128, 48, 48, 0, -1, 4},
	{144, 128, 144, 128, 144, 32, 0, -1, 4},
	{48, 128, 48, 128, 48, 48, 0, -1, 4},
	{16, 0, 16, 0, 208, 32, 1, 1, 3},
	{32, 128, 32, 128, 32, 16, 0, -2, 4},
	{80, 128, 80, 128, 80, 64, 0, -1, 1},
	{128, 16, 128, 16, 128, 96, 0, 1, 3},
	{64, 32, 64, 32, 192, 32, 1, 0, 4},
	{208, 32, 208, 32, 208, 96, 0, 1, 4},
	{48, 80, 48, 80, 192, 80, 2, 0, 3},
	{16, 80, 16, 80, 96, 80, 1, 0, 4},
	{112, 64, 112, 64, 208, 64, 1, 0, 4},
	{32, 16, 32, 16, 192, 32, 1, 1, 3},
	{16, 80, 16, 80, 80, 80, 1, 0, 4},
	{128, 112, 128, 112, 128, 16, 0, -1, 4},
	{16, 16, 16, 16, 160, 32, 1, 1, 3}
};

typedef struct {
	unsigned char xy, tipo, act;
} HOTSPOT;

HOTSPOT hotspots [] = {
	{17, 1, 0},
	{0, 0, 0},
	{216, 2, 0},
	{0, 0, 0},
	{0, 0, 0},
	{0, 0, 0},
	{18, 2, 0},
	{0, 0, 0},
	{18, 2, 0},
	{18, 1, 0},
	{0, 0, 0},
	{20, 1, 0},
	{0, 0, 0},
	{0, 0, 0},
	{212, 1, 0},
	{17, 1, 0},
	{0, 0, 0},
	{0, 0, 0},
	{23, 1, 0},
	{0, 0, 0},
	{210, 1, 0},
	{162, 1, 0},
	{0, 0, 0},
	{0, 0, 0},
	{0, 0, 0},
	{0, 0, 0},
	{194, 1, 0},
	{0, 0, 0},
	{0, 0, 0},
	{210, 1, 0}
};
