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

#define STDIN_FD  0
#define STDOUT_FD 1

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

int base2_complement(int n){
  // b-1N = max - n
  // bN = b-1N + 1 = (max - n) + 1 = (b^n -1) -n + 1 = b^n - n
  // unsigned int doesn't support 2^32 
  // let's stick to 2^32 -1 and subtract n from that, we add the 1 later
  unsigned int max = 4294967295; // 2^32 - 1
  return (max - n) + 1;
}

char digit_to_hex(int digit){
  if(digit == 10) digit = 'a';
  else if(digit == 11) digit = 'b';
  else if(digit == 12) digit = 'c';
  else if(digit == 13) digit = 'd';
  else if(digit == 14) digit = 'e';
  else if(digit == 15) digit = 'f';
  else digit = digit + '0';
  return digit;
}

int hex_to_digit(char hex){
  int digit;
  if(hex == 'a') digit = 10;
  else if(hex == 'b') digit = 11;
  else if(hex == 'c') digit = 12;
  else if(hex == 'd') digit = 13;
  else if(hex == 'e') digit = 14;
  else if(hex == 'f') digit = 15;
  else digit = hex - '0';
  return digit;
}

char digits[36];
int tamanho;

void change_base(unsigned int quo, int base){
    int i = 0;
    while(quo){
        int digit = (quo % base);
        quo = quo / base;
        
        digits[i] = digit_to_hex(digit);

        i++;
    }
    tamanho = i;
    digits[i] = '\n';

    for(int idx = 0; idx < i/2; idx++){
        char tmp = digits[idx]; 
        digits[idx] = digits[i-1-idx];
        digits[i-1-idx] = tmp;
    }

    write(STDOUT_FD, digits, i+1);
}

int main()
{
  char str[36];
  int ret_val = read(STDIN_FD, str, 20);

  int numero = 0;

  if(str[0] == '0' && str[1] == 'x'){
    // hex input
    int tam = 0;
    int digit;
    while(str[tam+2] != '\n') tam++;
    for(int i = tam+1; i >= 2; i--)
        numero += hex_to_digit(str[i]) * fexp(16, tam+1-i);
  }
  else{
    // dec input
    int tam = 0;
    int negative = 0;

    if(str[0] == '-') negative = 1;

    while(str[tam+negative] != '\n') tam++;

    for(int i = tam-1+negative; i >= negative; i--)
        numero += (str[i]-'0') * fexp(10, tam-1+negative-i);

    if(negative) numero = base2_complement(numero);
  }

  
  // binario
  char base[2] = {'0', 'b'};
  write(STDOUT_FD, base, 2);
  change_base(numero, 2);
  // decimal
  base[0] = '-'; 
  if(str[0] == '-'){
    write(STDOUT_FD, base, 1);
    change_base(base2_complement(numero), 10); // original n -> complement of complement n
  }
  else if(numero >= fexp(2, 31)) {
    write(STDOUT_FD, base, 1);
    change_base(base2_complement(numero), 10);
  }
  else 
    change_base(numero, 10);
  
  // hex
  base[0] = '0'; base[1] = 'x';
  write(STDOUT_FD, base, 2);
  change_base(numero, 16);
 
  // swap endiannes :: swap hex by pairs 
  
  char swap[9] = {'0', '0', '0', '0', '0', '0', '0', '0', '\n'};
  for(int i=8-tamanho; i<8; i++)
    swap[i] = digits[i - (8-tamanho)];

  for(int i=0; i<8/2; i+=2){
    char tmp = swap[i];
    swap[i] = swap[6-i];
    swap[6-i] = tmp;

    tmp = swap[i+1];
    swap[i+1] = swap[7-i];
    swap[7-i] = tmp;
  }

  numero = 0;
  for(int i = 7; i >= 0; i--)
    numero += hex_to_digit(swap[i]) * fexp(16, 7-i);
 
  change_base(numero, 10);
  
  return 0;
}

void _start()
{
  int ret_code = main();
  exit(ret_code);
}


