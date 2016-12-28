typedef struct counter {
	int var;
} counter;

int counterInc( counter *self ) {
	int* i=&self->var;
	i++;
  return(*i);
};
