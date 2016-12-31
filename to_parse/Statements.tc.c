#define i32 int
void i32Select( i32 *self ){*self++}

int main(){
	i32 i;
	i32Select( &i );
}
