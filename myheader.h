typedef enum { INT, CHAR, UNDEC} nodeEnum;

struct variable{
	nodeEnum Type;
	char s[20];
	struct variable * next;
};
struct variable * ptr;