int read(int __fd, const void *__buf, int __n){
    int ret_val;
  __asm__ __volatile__(
    "mv a0, %1           # file descriptor\n"
    "mv a1, %2           # buffer \n"
    "mv a2, %3           # size \n"
    "li a7, 63           # syscall write code (63) \n"
    "ecall               # invoke syscall \n"
    "mv %0, a0           # move return value to ret_val\n"
    : "=r"(ret_val)  // Output list
    : "r"(__fd), "r"(__buf), "r"(__n)    // Input list
    : "a0", "a1", "a2", "a7"
  );
  return ret_val;
}

void write(int __fd, const void *__buf, int __n)
{
  __asm__ __volatile__(
    "mv a0, %0           # file descriptor\n"
    "mv a1, %1           # buffer \n"
    "mv a2, %2           # size \n"
    "li a7, 64           # syscall write (64) \n"
    "ecall"
    :   // Output list
    :"r"(__fd), "r"(__buf), "r"(__n)    // Input list
    : "a0", "a1", "a2", "a7"
  );
}

void exit(int code)
{
  __asm__ __volatile__(
    "mv a0, %0           # return code\n"
    "li a7, 93           # syscall exit (64) \n"
    "ecall"
    :   // Output list
    :"r"(code)    // Input list
    : "a0", "a7"
  );
}

void hex_code(int val){
    char hex[11];
    unsigned int uval = (unsigned int) val, aux;
    
    hex[0] = '0';
    hex[1] = 'x';
    hex[10] = '\n';

    for (int i = 9; i > 1; i--){
        aux = uval % 16;
        if (aux >= 10)
            hex[i] = aux - 10 + 'A';
        else
            hex[i] = aux + '0';
        uval = uval / 16;
    }
    write(1, hex, 11);
}

unsigned int fexp(unsigned int a, unsigned int b){
    // a^b = 1                 , if b = 0      
    //     = a^b/2 * a^b/2     , if b is even  
    //     = a^b/2 * a^b/2 * a , if b is odd
    if(b == 0) return 1;                                                                      
    unsigned int tmp = fexp(a,b/2);                                                           
    tmp = (tmp*tmp);                           
    if(b % 2 == 1) tmp=(tmp*a);                                                               
    return tmp;                                
}    

char buffer[30];

int main()
{
	read(0, buffer, 30);

	int bitmask[5] = {fexp(2,3)-1, fexp(2,8)-1, fexp(2,5)-1, fexp(2,5)-1, fexp(2,11)-1};
	int shift[5] = {0, 3, 11, 16, 21};
	int ans = 0;

	for(int i=0; i<30; i+=6){
		int n=0;
		
		for(int off=i+1; off<=i+4; off++)
			n += (buffer[off]-'0') * fexp(10, i+4-off);

		if(buffer[i] == '-') n *= -1;
		
		ans |= (n & bitmask[i/6]) << shift[i/6];
	}
	hex_code(ans);	
}

void _start()
{
  int ret_code = main();
  exit(ret_code);
}
