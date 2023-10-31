
user/_my_shell:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <readLine>:
#include "kernel/fcntl.h"
#include "kernel/param.h"

int
readLine(char buffer[], const int bufferSize)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
   c:	84aa                	mv	s1,a0
   e:	892e                	mv	s2,a1
    //constantly display command prompt
    write(2, ">>> ", 4);
  10:	4611                	li	a2,4
  12:	00001597          	auipc	a1,0x1
  16:	96e58593          	addi	a1,a1,-1682 # 980 <malloc+0xf0>
  1a:	4509                	li	a0,2
  1c:	00000097          	auipc	ra,0x0
  20:	45a080e7          	jalr	1114(ra) # 476 <write>

    //read input from user
    // bytesRead = read(0, p, 1);
    gets(buffer, bufferSize);
  24:	85ca                	mv	a1,s2
  26:	8526                	mv	a0,s1
  28:	00000097          	auipc	ra,0x0
  2c:	27a080e7          	jalr	634(ra) # 2a2 <gets>


    if (strlen(buffer) == 1)
  30:	8526                	mv	a0,s1
  32:	00000097          	auipc	ra,0x0
  36:	200080e7          	jalr	512(ra) # 232 <strlen>
  3a:	2501                	sext.w	a0,a0
  3c:	4785                	li	a5,1
  3e:	00f50963          	beq	a0,a5,50 <readLine+0x50>
    {
        write(2, "\n", 2);
        readLine(buffer, bufferSize);
    }
    return 1;
}
  42:	4505                	li	a0,1
  44:	60e2                	ld	ra,24(sp)
  46:	6442                	ld	s0,16(sp)
  48:	64a2                	ld	s1,8(sp)
  4a:	6902                	ld	s2,0(sp)
  4c:	6105                	addi	sp,sp,32
  4e:	8082                	ret
        write(2, "\n", 2);
  50:	4609                	li	a2,2
  52:	00001597          	auipc	a1,0x1
  56:	93658593          	addi	a1,a1,-1738 # 988 <malloc+0xf8>
  5a:	4509                	li	a0,2
  5c:	00000097          	auipc	ra,0x0
  60:	41a080e7          	jalr	1050(ra) # 476 <write>
        readLine(buffer, bufferSize);
  64:	85ca                	mv	a1,s2
  66:	8526                	mv	a0,s1
  68:	00000097          	auipc	ra,0x0
  6c:	f98080e7          	jalr	-104(ra) # 0 <readLine>
  70:	bfc9                	j	42 <readLine+0x42>

0000000000000072 <formatLine>:

void
formatLine(char *buffer, char *args[])
{
  72:	1101                	addi	sp,sp,-32
  74:	ec06                	sd	ra,24(sp)
  76:	e822                	sd	s0,16(sp)
  78:	e426                	sd	s1,8(sp)
  7a:	e04a                	sd	s2,0(sp)
  7c:	1000                	addi	s0,sp,32
  7e:	84aa                	mv	s1,a0
  80:	892e                	mv	s2,a1

    int pid = fork();
  82:	00000097          	auipc	ra,0x0
  86:	3cc080e7          	jalr	972(ra) # 44e <fork>
    if (pid < 0)
  8a:	00054e63          	bltz	a0,a6 <formatLine+0x34>
    {
        // fprintf("Fork failed");
        exit(1);
    } else if(pid == 1)
  8e:	4785                	li	a5,1
  90:	04f51b63          	bne	a0,a5,e6 <formatLine+0x74>
        //set argument pointer to the start of the argument array
        argumentPointer = &args[0];

        //set buffer pointer to start of buffer
        bufferPointer = buffer;
        while (*bufferPointer != '\0') {
  94:	0004c783          	lbu	a5,0(s1)
  98:	cb95                	beqz	a5,cc <formatLine+0x5a>
        argumentPointer = &args[0];
  9a:	864a                	mv	a2,s2
        int wordstart = 1;
  9c:	872a                	mv	a4,a0
            if (*bufferPointer != ' ') 
  9e:	02000693          	li	a3,32

                //assigns the address 'bufferPointer' to the pointer '*argumentPointer'
                //this effectively stores the starting address of the new word in the 'args' array.
                //it also sets wordstart to 0 to indicate that a word has begun  
                *argumentPointer = bufferPointer;
                wordstart = 0;
  a2:	4581                	li	a1,0
  a4:	a839                	j	c2 <formatLine+0x50>
        exit(1);
  a6:	4505                	li	a0,1
  a8:	00000097          	auipc	ra,0x0
  ac:	3ae080e7          	jalr	942(ra) # 456 <exit>
                
            }   else 
            {
                // A word in the line has ended since we met a space.
                if (!wordstart) 
  b0:	e709                	bnez	a4,ba <formatLine+0x48>
                {

                // replaces the space character with a null-terminating character \0.
                // this marks the end of the current word  
                *bufferPointer = '\0';
  b2:	00048023          	sb	zero,0(s1)

                // the pointer a is then incremented to point ot the next element in the args array,
                // preparing it to store the address of the next word. 
                argumentPointer++;
  b6:	0621                	addi	a2,a2,8

                //ws is set to 1 indicating the whitespace has started, as we're in the space between words.
                wordstart = 1;
  b8:	872a                	mv	a4,a0
                }
            }

        // pointer b is moved to the next character in the line, and the process continues for the next character
        bufferPointer++;
  ba:	0485                	addi	s1,s1,1
        while (*bufferPointer != '\0') {
  bc:	0004c783          	lbu	a5,0(s1)
  c0:	c791                	beqz	a5,cc <formatLine+0x5a>
            if (*bufferPointer != ' ') 
  c2:	fed787e3          	beq	a5,a3,b0 <formatLine+0x3e>
                *argumentPointer = bufferPointer;
  c6:	e204                	sd	s1,0(a2)
                wordstart = 0;
  c8:	872e                	mv	a4,a1
  ca:	bfc5                	j	ba <formatLine+0x48>
        }
        // At this point args stores pointers to the original
        // command passed to xargs plus pointers to any inputs from
        // the standard input. Execute the command.
        exec(args[0], args);
  cc:	85ca                	mv	a1,s2
  ce:	00093503          	ld	a0,0(s2)
  d2:	00000097          	auipc	ra,0x0
  d6:	3bc080e7          	jalr	956(ra) # 48e <exec>
        
    } else // parent
        wait(0);
}
  da:	60e2                	ld	ra,24(sp)
  dc:	6442                	ld	s0,16(sp)
  de:	64a2                	ld	s1,8(sp)
  e0:	6902                	ld	s2,0(sp)
  e2:	6105                	addi	sp,sp,32
  e4:	8082                	ret
        wait(0);
  e6:	4501                	li	a0,0
  e8:	00000097          	auipc	ra,0x0
  ec:	376080e7          	jalr	886(ra) # 45e <wait>
}
  f0:	b7ed                	j	da <formatLine+0x68>

00000000000000f2 <cd>:

//function to change directory
void
cd(char *path)
{
  f2:	1101                	addi	sp,sp,-32
  f4:	ec06                	sd	ra,24(sp)
  f6:	e822                	sd	s0,16(sp)
  f8:	e426                	sd	s1,8(sp)
  fa:	1000                	addi	s0,sp,32
  fc:	84aa                	mv	s1,a0
    if(chdir(path) < 0)
  fe:	00000097          	auipc	ra,0x0
 102:	3c8080e7          	jalr	968(ra) # 4c6 <chdir>
 106:	00054763          	bltz	a0,114 <cd+0x22>
    {
        printf("cd: Error. Cannot cd to %s\n", path);
    }

}
 10a:	60e2                	ld	ra,24(sp)
 10c:	6442                	ld	s0,16(sp)
 10e:	64a2                	ld	s1,8(sp)
 110:	6105                	addi	sp,sp,32
 112:	8082                	ret
        printf("cd: Error. Cannot cd to %s\n", path);
 114:	85a6                	mv	a1,s1
 116:	00001517          	auipc	a0,0x1
 11a:	87a50513          	addi	a0,a0,-1926 # 990 <malloc+0x100>
 11e:	00000097          	auipc	ra,0x0
 122:	6ba080e7          	jalr	1722(ra) # 7d8 <printf>
}
 126:	b7d5                	j	10a <cd+0x18>

0000000000000128 <main>:

int 
main(int argc, char *argv[]) 
{
 128:	7169                	addi	sp,sp,-304
 12a:	f606                	sd	ra,296(sp)
 12c:	f222                	sd	s0,288(sp)
 12e:	ee26                	sd	s1,280(sp)
 130:	ea4a                	sd	s2,272(sp)
 132:	e64e                	sd	s3,264(sp)
 134:	1a00                	addi	s0,sp,304
    const int BUFSIZE = 512;
    char buffer[BUFSIZE];    
 136:	7101                	addi	sp,sp,-512
 138:	898a                	mv	s3,sp

    char* args[MAXARG] = { 0 };
 13a:	10000613          	li	a2,256
 13e:	4581                	li	a1,0
 140:	ed040513          	addi	a0,s0,-304
 144:	00000097          	auipc	ra,0x0
 148:	118080e7          	jalr	280(ra) # 25c <memset>

    char *p;
    p = buffer;
    
    while (readLine(buffer, BUFSIZE))
 14c:	20098913          	addi	s2,s3,512
    {

        for (int i=0; i<BUFSIZE; i++)
        {
            if (buffer[i] == '\n')
 150:	44a9                	li	s1,10
    while (readLine(buffer, BUFSIZE))
 152:	a015                	j	176 <main+0x4e>
        for (int i=0; i<BUFSIZE; i++)
 154:	0785                	addi	a5,a5,1
 156:	01278963          	beq	a5,s2,168 <main+0x40>
            if (buffer[i] == '\n')
 15a:	0007c703          	lbu	a4,0(a5)
 15e:	fe971be3          	bne	a4,s1,154 <main+0x2c>
            {
                //replace with null-terminating char, to indicate end of command/argument
                buffer[i] = '\0';
 162:	00078023          	sb	zero,0(a5)
 166:	b7fd                	j	154 <main+0x2c>
            }
        }
    
        formatLine(buffer, args);
 168:	ed040593          	addi	a1,s0,-304
 16c:	854e                	mv	a0,s3
 16e:	00000097          	auipc	ra,0x0
 172:	f04080e7          	jalr	-252(ra) # 72 <formatLine>
    while (readLine(buffer, BUFSIZE))
 176:	20000593          	li	a1,512
 17a:	854e                	mv	a0,s3
 17c:	00000097          	auipc	ra,0x0
 180:	e84080e7          	jalr	-380(ra) # 0 <readLine>
 184:	c119                	beqz	a0,18a <main+0x62>
 186:	87ce                	mv	a5,s3
 188:	bfc9                	j	15a <main+0x32>
        p = buffer;

    p++;
    }
    if(buffer[0] == 'c' && buffer[1] == 'd' && buffer[2] == ' ')
 18a:	0009c703          	lbu	a4,0(s3)
 18e:	06300793          	li	a5,99
 192:	00f70c63          	beq	a4,a5,1aa <main+0x82>
 
        

    
    return 0;
 196:	4501                	li	a0,0
 198:	ed040113          	addi	sp,s0,-304
 19c:	70b2                	ld	ra,296(sp)
 19e:	7412                	ld	s0,288(sp)
 1a0:	64f2                	ld	s1,280(sp)
 1a2:	6952                	ld	s2,272(sp)
 1a4:	69b2                	ld	s3,264(sp)
 1a6:	6155                	addi	sp,sp,304
 1a8:	8082                	ret
    if(buffer[0] == 'c' && buffer[1] == 'd' && buffer[2] == ' ')
 1aa:	0019c703          	lbu	a4,1(s3)
 1ae:	06400793          	li	a5,100
 1b2:	fef712e3          	bne	a4,a5,196 <main+0x6e>
 1b6:	0029c703          	lbu	a4,2(s3)
 1ba:	02000793          	li	a5,32
 1be:	fcf71ce3          	bne	a4,a5,196 <main+0x6e>
        cd(path);
 1c2:	00398513          	addi	a0,s3,3
 1c6:	00000097          	auipc	ra,0x0
 1ca:	f2c080e7          	jalr	-212(ra) # f2 <cd>
 1ce:	b7e1                	j	196 <main+0x6e>

00000000000001d0 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 1d0:	1141                	addi	sp,sp,-16
 1d2:	e406                	sd	ra,8(sp)
 1d4:	e022                	sd	s0,0(sp)
 1d6:	0800                	addi	s0,sp,16
  extern int main();
  main();
 1d8:	00000097          	auipc	ra,0x0
 1dc:	f50080e7          	jalr	-176(ra) # 128 <main>
  exit(0);
 1e0:	4501                	li	a0,0
 1e2:	00000097          	auipc	ra,0x0
 1e6:	274080e7          	jalr	628(ra) # 456 <exit>

00000000000001ea <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 1ea:	1141                	addi	sp,sp,-16
 1ec:	e422                	sd	s0,8(sp)
 1ee:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1f0:	87aa                	mv	a5,a0
 1f2:	0585                	addi	a1,a1,1
 1f4:	0785                	addi	a5,a5,1
 1f6:	fff5c703          	lbu	a4,-1(a1)
 1fa:	fee78fa3          	sb	a4,-1(a5)
 1fe:	fb75                	bnez	a4,1f2 <strcpy+0x8>
    ;
  return os;
}
 200:	6422                	ld	s0,8(sp)
 202:	0141                	addi	sp,sp,16
 204:	8082                	ret

0000000000000206 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 206:	1141                	addi	sp,sp,-16
 208:	e422                	sd	s0,8(sp)
 20a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 20c:	00054783          	lbu	a5,0(a0)
 210:	cb91                	beqz	a5,224 <strcmp+0x1e>
 212:	0005c703          	lbu	a4,0(a1)
 216:	00f71763          	bne	a4,a5,224 <strcmp+0x1e>
    p++, q++;
 21a:	0505                	addi	a0,a0,1
 21c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 21e:	00054783          	lbu	a5,0(a0)
 222:	fbe5                	bnez	a5,212 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 224:	0005c503          	lbu	a0,0(a1)
}
 228:	40a7853b          	subw	a0,a5,a0
 22c:	6422                	ld	s0,8(sp)
 22e:	0141                	addi	sp,sp,16
 230:	8082                	ret

0000000000000232 <strlen>:

uint
strlen(const char *s)
{
 232:	1141                	addi	sp,sp,-16
 234:	e422                	sd	s0,8(sp)
 236:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 238:	00054783          	lbu	a5,0(a0)
 23c:	cf91                	beqz	a5,258 <strlen+0x26>
 23e:	0505                	addi	a0,a0,1
 240:	87aa                	mv	a5,a0
 242:	4685                	li	a3,1
 244:	9e89                	subw	a3,a3,a0
 246:	00f6853b          	addw	a0,a3,a5
 24a:	0785                	addi	a5,a5,1
 24c:	fff7c703          	lbu	a4,-1(a5)
 250:	fb7d                	bnez	a4,246 <strlen+0x14>
    ;
  return n;
}
 252:	6422                	ld	s0,8(sp)
 254:	0141                	addi	sp,sp,16
 256:	8082                	ret
  for(n = 0; s[n]; n++)
 258:	4501                	li	a0,0
 25a:	bfe5                	j	252 <strlen+0x20>

000000000000025c <memset>:

void*
memset(void *dst, int c, uint n)
{
 25c:	1141                	addi	sp,sp,-16
 25e:	e422                	sd	s0,8(sp)
 260:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 262:	ca19                	beqz	a2,278 <memset+0x1c>
 264:	87aa                	mv	a5,a0
 266:	1602                	slli	a2,a2,0x20
 268:	9201                	srli	a2,a2,0x20
 26a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 26e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 272:	0785                	addi	a5,a5,1
 274:	fee79de3          	bne	a5,a4,26e <memset+0x12>
  }
  return dst;
}
 278:	6422                	ld	s0,8(sp)
 27a:	0141                	addi	sp,sp,16
 27c:	8082                	ret

000000000000027e <strchr>:

char*
strchr(const char *s, char c)
{
 27e:	1141                	addi	sp,sp,-16
 280:	e422                	sd	s0,8(sp)
 282:	0800                	addi	s0,sp,16
  for(; *s; s++)
 284:	00054783          	lbu	a5,0(a0)
 288:	cb99                	beqz	a5,29e <strchr+0x20>
    if(*s == c)
 28a:	00f58763          	beq	a1,a5,298 <strchr+0x1a>
  for(; *s; s++)
 28e:	0505                	addi	a0,a0,1
 290:	00054783          	lbu	a5,0(a0)
 294:	fbfd                	bnez	a5,28a <strchr+0xc>
      return (char*)s;
  return 0;
 296:	4501                	li	a0,0
}
 298:	6422                	ld	s0,8(sp)
 29a:	0141                	addi	sp,sp,16
 29c:	8082                	ret
  return 0;
 29e:	4501                	li	a0,0
 2a0:	bfe5                	j	298 <strchr+0x1a>

00000000000002a2 <gets>:

char*
gets(char *buf, int max)
{
 2a2:	711d                	addi	sp,sp,-96
 2a4:	ec86                	sd	ra,88(sp)
 2a6:	e8a2                	sd	s0,80(sp)
 2a8:	e4a6                	sd	s1,72(sp)
 2aa:	e0ca                	sd	s2,64(sp)
 2ac:	fc4e                	sd	s3,56(sp)
 2ae:	f852                	sd	s4,48(sp)
 2b0:	f456                	sd	s5,40(sp)
 2b2:	f05a                	sd	s6,32(sp)
 2b4:	ec5e                	sd	s7,24(sp)
 2b6:	1080                	addi	s0,sp,96
 2b8:	8baa                	mv	s7,a0
 2ba:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2bc:	892a                	mv	s2,a0
 2be:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2c0:	4aa9                	li	s5,10
 2c2:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 2c4:	89a6                	mv	s3,s1
 2c6:	2485                	addiw	s1,s1,1
 2c8:	0344d863          	bge	s1,s4,2f8 <gets+0x56>
    cc = read(0, &c, 1);
 2cc:	4605                	li	a2,1
 2ce:	faf40593          	addi	a1,s0,-81
 2d2:	4501                	li	a0,0
 2d4:	00000097          	auipc	ra,0x0
 2d8:	19a080e7          	jalr	410(ra) # 46e <read>
    if(cc < 1)
 2dc:	00a05e63          	blez	a0,2f8 <gets+0x56>
    buf[i++] = c;
 2e0:	faf44783          	lbu	a5,-81(s0)
 2e4:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2e8:	01578763          	beq	a5,s5,2f6 <gets+0x54>
 2ec:	0905                	addi	s2,s2,1
 2ee:	fd679be3          	bne	a5,s6,2c4 <gets+0x22>
  for(i=0; i+1 < max; ){
 2f2:	89a6                	mv	s3,s1
 2f4:	a011                	j	2f8 <gets+0x56>
 2f6:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2f8:	99de                	add	s3,s3,s7
 2fa:	00098023          	sb	zero,0(s3)
  return buf;
}
 2fe:	855e                	mv	a0,s7
 300:	60e6                	ld	ra,88(sp)
 302:	6446                	ld	s0,80(sp)
 304:	64a6                	ld	s1,72(sp)
 306:	6906                	ld	s2,64(sp)
 308:	79e2                	ld	s3,56(sp)
 30a:	7a42                	ld	s4,48(sp)
 30c:	7aa2                	ld	s5,40(sp)
 30e:	7b02                	ld	s6,32(sp)
 310:	6be2                	ld	s7,24(sp)
 312:	6125                	addi	sp,sp,96
 314:	8082                	ret

0000000000000316 <stat>:

int
stat(const char *n, struct stat *st)
{
 316:	1101                	addi	sp,sp,-32
 318:	ec06                	sd	ra,24(sp)
 31a:	e822                	sd	s0,16(sp)
 31c:	e426                	sd	s1,8(sp)
 31e:	e04a                	sd	s2,0(sp)
 320:	1000                	addi	s0,sp,32
 322:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 324:	4581                	li	a1,0
 326:	00000097          	auipc	ra,0x0
 32a:	170080e7          	jalr	368(ra) # 496 <open>
  if(fd < 0)
 32e:	02054563          	bltz	a0,358 <stat+0x42>
 332:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 334:	85ca                	mv	a1,s2
 336:	00000097          	auipc	ra,0x0
 33a:	178080e7          	jalr	376(ra) # 4ae <fstat>
 33e:	892a                	mv	s2,a0
  close(fd);
 340:	8526                	mv	a0,s1
 342:	00000097          	auipc	ra,0x0
 346:	13c080e7          	jalr	316(ra) # 47e <close>
  return r;
}
 34a:	854a                	mv	a0,s2
 34c:	60e2                	ld	ra,24(sp)
 34e:	6442                	ld	s0,16(sp)
 350:	64a2                	ld	s1,8(sp)
 352:	6902                	ld	s2,0(sp)
 354:	6105                	addi	sp,sp,32
 356:	8082                	ret
    return -1;
 358:	597d                	li	s2,-1
 35a:	bfc5                	j	34a <stat+0x34>

000000000000035c <atoi>:

int
atoi(const char *s)
{
 35c:	1141                	addi	sp,sp,-16
 35e:	e422                	sd	s0,8(sp)
 360:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 362:	00054683          	lbu	a3,0(a0)
 366:	fd06879b          	addiw	a5,a3,-48
 36a:	0ff7f793          	zext.b	a5,a5
 36e:	4625                	li	a2,9
 370:	02f66863          	bltu	a2,a5,3a0 <atoi+0x44>
 374:	872a                	mv	a4,a0
  n = 0;
 376:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 378:	0705                	addi	a4,a4,1
 37a:	0025179b          	slliw	a5,a0,0x2
 37e:	9fa9                	addw	a5,a5,a0
 380:	0017979b          	slliw	a5,a5,0x1
 384:	9fb5                	addw	a5,a5,a3
 386:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 38a:	00074683          	lbu	a3,0(a4)
 38e:	fd06879b          	addiw	a5,a3,-48
 392:	0ff7f793          	zext.b	a5,a5
 396:	fef671e3          	bgeu	a2,a5,378 <atoi+0x1c>
  return n;
}
 39a:	6422                	ld	s0,8(sp)
 39c:	0141                	addi	sp,sp,16
 39e:	8082                	ret
  n = 0;
 3a0:	4501                	li	a0,0
 3a2:	bfe5                	j	39a <atoi+0x3e>

00000000000003a4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3a4:	1141                	addi	sp,sp,-16
 3a6:	e422                	sd	s0,8(sp)
 3a8:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3aa:	02b57463          	bgeu	a0,a1,3d2 <memmove+0x2e>
    while(n-- > 0)
 3ae:	00c05f63          	blez	a2,3cc <memmove+0x28>
 3b2:	1602                	slli	a2,a2,0x20
 3b4:	9201                	srli	a2,a2,0x20
 3b6:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 3ba:	872a                	mv	a4,a0
      *dst++ = *src++;
 3bc:	0585                	addi	a1,a1,1
 3be:	0705                	addi	a4,a4,1
 3c0:	fff5c683          	lbu	a3,-1(a1)
 3c4:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3c8:	fee79ae3          	bne	a5,a4,3bc <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3cc:	6422                	ld	s0,8(sp)
 3ce:	0141                	addi	sp,sp,16
 3d0:	8082                	ret
    dst += n;
 3d2:	00c50733          	add	a4,a0,a2
    src += n;
 3d6:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3d8:	fec05ae3          	blez	a2,3cc <memmove+0x28>
 3dc:	fff6079b          	addiw	a5,a2,-1
 3e0:	1782                	slli	a5,a5,0x20
 3e2:	9381                	srli	a5,a5,0x20
 3e4:	fff7c793          	not	a5,a5
 3e8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3ea:	15fd                	addi	a1,a1,-1
 3ec:	177d                	addi	a4,a4,-1
 3ee:	0005c683          	lbu	a3,0(a1)
 3f2:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3f6:	fee79ae3          	bne	a5,a4,3ea <memmove+0x46>
 3fa:	bfc9                	j	3cc <memmove+0x28>

00000000000003fc <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3fc:	1141                	addi	sp,sp,-16
 3fe:	e422                	sd	s0,8(sp)
 400:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 402:	ca05                	beqz	a2,432 <memcmp+0x36>
 404:	fff6069b          	addiw	a3,a2,-1
 408:	1682                	slli	a3,a3,0x20
 40a:	9281                	srli	a3,a3,0x20
 40c:	0685                	addi	a3,a3,1
 40e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 410:	00054783          	lbu	a5,0(a0)
 414:	0005c703          	lbu	a4,0(a1)
 418:	00e79863          	bne	a5,a4,428 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 41c:	0505                	addi	a0,a0,1
    p2++;
 41e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 420:	fed518e3          	bne	a0,a3,410 <memcmp+0x14>
  }
  return 0;
 424:	4501                	li	a0,0
 426:	a019                	j	42c <memcmp+0x30>
      return *p1 - *p2;
 428:	40e7853b          	subw	a0,a5,a4
}
 42c:	6422                	ld	s0,8(sp)
 42e:	0141                	addi	sp,sp,16
 430:	8082                	ret
  return 0;
 432:	4501                	li	a0,0
 434:	bfe5                	j	42c <memcmp+0x30>

0000000000000436 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 436:	1141                	addi	sp,sp,-16
 438:	e406                	sd	ra,8(sp)
 43a:	e022                	sd	s0,0(sp)
 43c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 43e:	00000097          	auipc	ra,0x0
 442:	f66080e7          	jalr	-154(ra) # 3a4 <memmove>
}
 446:	60a2                	ld	ra,8(sp)
 448:	6402                	ld	s0,0(sp)
 44a:	0141                	addi	sp,sp,16
 44c:	8082                	ret

000000000000044e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 44e:	4885                	li	a7,1
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <exit>:
.global exit
exit:
 li a7, SYS_exit
 456:	4889                	li	a7,2
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <wait>:
.global wait
wait:
 li a7, SYS_wait
 45e:	488d                	li	a7,3
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 466:	4891                	li	a7,4
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <read>:
.global read
read:
 li a7, SYS_read
 46e:	4895                	li	a7,5
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <write>:
.global write
write:
 li a7, SYS_write
 476:	48c1                	li	a7,16
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <close>:
.global close
close:
 li a7, SYS_close
 47e:	48d5                	li	a7,21
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <kill>:
.global kill
kill:
 li a7, SYS_kill
 486:	4899                	li	a7,6
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <exec>:
.global exec
exec:
 li a7, SYS_exec
 48e:	489d                	li	a7,7
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <open>:
.global open
open:
 li a7, SYS_open
 496:	48bd                	li	a7,15
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 49e:	48c5                	li	a7,17
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4a6:	48c9                	li	a7,18
 ecall
 4a8:	00000073          	ecall
 ret
 4ac:	8082                	ret

00000000000004ae <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4ae:	48a1                	li	a7,8
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <link>:
.global link
link:
 li a7, SYS_link
 4b6:	48cd                	li	a7,19
 ecall
 4b8:	00000073          	ecall
 ret
 4bc:	8082                	ret

00000000000004be <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4be:	48d1                	li	a7,20
 ecall
 4c0:	00000073          	ecall
 ret
 4c4:	8082                	ret

00000000000004c6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4c6:	48a5                	li	a7,9
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <dup>:
.global dup
dup:
 li a7, SYS_dup
 4ce:	48a9                	li	a7,10
 ecall
 4d0:	00000073          	ecall
 ret
 4d4:	8082                	ret

00000000000004d6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4d6:	48ad                	li	a7,11
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4de:	48b1                	li	a7,12
 ecall
 4e0:	00000073          	ecall
 ret
 4e4:	8082                	ret

00000000000004e6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4e6:	48b5                	li	a7,13
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4ee:	48b9                	li	a7,14
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <getyear>:
.global getyear
getyear:
 li a7, SYS_getyear
 4f6:	48d9                	li	a7,22
 ecall
 4f8:	00000073          	ecall
 ret
 4fc:	8082                	ret

00000000000004fe <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4fe:	1101                	addi	sp,sp,-32
 500:	ec06                	sd	ra,24(sp)
 502:	e822                	sd	s0,16(sp)
 504:	1000                	addi	s0,sp,32
 506:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 50a:	4605                	li	a2,1
 50c:	fef40593          	addi	a1,s0,-17
 510:	00000097          	auipc	ra,0x0
 514:	f66080e7          	jalr	-154(ra) # 476 <write>
}
 518:	60e2                	ld	ra,24(sp)
 51a:	6442                	ld	s0,16(sp)
 51c:	6105                	addi	sp,sp,32
 51e:	8082                	ret

0000000000000520 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 520:	7139                	addi	sp,sp,-64
 522:	fc06                	sd	ra,56(sp)
 524:	f822                	sd	s0,48(sp)
 526:	f426                	sd	s1,40(sp)
 528:	f04a                	sd	s2,32(sp)
 52a:	ec4e                	sd	s3,24(sp)
 52c:	0080                	addi	s0,sp,64
 52e:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 530:	c299                	beqz	a3,536 <printint+0x16>
 532:	0805c963          	bltz	a1,5c4 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 536:	2581                	sext.w	a1,a1
  neg = 0;
 538:	4881                	li	a7,0
 53a:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 53e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 540:	2601                	sext.w	a2,a2
 542:	00000517          	auipc	a0,0x0
 546:	4ce50513          	addi	a0,a0,1230 # a10 <digits>
 54a:	883a                	mv	a6,a4
 54c:	2705                	addiw	a4,a4,1
 54e:	02c5f7bb          	remuw	a5,a1,a2
 552:	1782                	slli	a5,a5,0x20
 554:	9381                	srli	a5,a5,0x20
 556:	97aa                	add	a5,a5,a0
 558:	0007c783          	lbu	a5,0(a5)
 55c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 560:	0005879b          	sext.w	a5,a1
 564:	02c5d5bb          	divuw	a1,a1,a2
 568:	0685                	addi	a3,a3,1
 56a:	fec7f0e3          	bgeu	a5,a2,54a <printint+0x2a>
  if(neg)
 56e:	00088c63          	beqz	a7,586 <printint+0x66>
    buf[i++] = '-';
 572:	fd070793          	addi	a5,a4,-48
 576:	00878733          	add	a4,a5,s0
 57a:	02d00793          	li	a5,45
 57e:	fef70823          	sb	a5,-16(a4)
 582:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 586:	02e05863          	blez	a4,5b6 <printint+0x96>
 58a:	fc040793          	addi	a5,s0,-64
 58e:	00e78933          	add	s2,a5,a4
 592:	fff78993          	addi	s3,a5,-1
 596:	99ba                	add	s3,s3,a4
 598:	377d                	addiw	a4,a4,-1
 59a:	1702                	slli	a4,a4,0x20
 59c:	9301                	srli	a4,a4,0x20
 59e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 5a2:	fff94583          	lbu	a1,-1(s2)
 5a6:	8526                	mv	a0,s1
 5a8:	00000097          	auipc	ra,0x0
 5ac:	f56080e7          	jalr	-170(ra) # 4fe <putc>
  while(--i >= 0)
 5b0:	197d                	addi	s2,s2,-1
 5b2:	ff3918e3          	bne	s2,s3,5a2 <printint+0x82>
}
 5b6:	70e2                	ld	ra,56(sp)
 5b8:	7442                	ld	s0,48(sp)
 5ba:	74a2                	ld	s1,40(sp)
 5bc:	7902                	ld	s2,32(sp)
 5be:	69e2                	ld	s3,24(sp)
 5c0:	6121                	addi	sp,sp,64
 5c2:	8082                	ret
    x = -xx;
 5c4:	40b005bb          	negw	a1,a1
    neg = 1;
 5c8:	4885                	li	a7,1
    x = -xx;
 5ca:	bf85                	j	53a <printint+0x1a>

00000000000005cc <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5cc:	7119                	addi	sp,sp,-128
 5ce:	fc86                	sd	ra,120(sp)
 5d0:	f8a2                	sd	s0,112(sp)
 5d2:	f4a6                	sd	s1,104(sp)
 5d4:	f0ca                	sd	s2,96(sp)
 5d6:	ecce                	sd	s3,88(sp)
 5d8:	e8d2                	sd	s4,80(sp)
 5da:	e4d6                	sd	s5,72(sp)
 5dc:	e0da                	sd	s6,64(sp)
 5de:	fc5e                	sd	s7,56(sp)
 5e0:	f862                	sd	s8,48(sp)
 5e2:	f466                	sd	s9,40(sp)
 5e4:	f06a                	sd	s10,32(sp)
 5e6:	ec6e                	sd	s11,24(sp)
 5e8:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5ea:	0005c903          	lbu	s2,0(a1)
 5ee:	18090f63          	beqz	s2,78c <vprintf+0x1c0>
 5f2:	8aaa                	mv	s5,a0
 5f4:	8b32                	mv	s6,a2
 5f6:	00158493          	addi	s1,a1,1
  state = 0;
 5fa:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5fc:	02500a13          	li	s4,37
 600:	4c55                	li	s8,21
 602:	00000c97          	auipc	s9,0x0
 606:	3b6c8c93          	addi	s9,s9,950 # 9b8 <malloc+0x128>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 60a:	02800d93          	li	s11,40
  putc(fd, 'x');
 60e:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 610:	00000b97          	auipc	s7,0x0
 614:	400b8b93          	addi	s7,s7,1024 # a10 <digits>
 618:	a839                	j	636 <vprintf+0x6a>
        putc(fd, c);
 61a:	85ca                	mv	a1,s2
 61c:	8556                	mv	a0,s5
 61e:	00000097          	auipc	ra,0x0
 622:	ee0080e7          	jalr	-288(ra) # 4fe <putc>
 626:	a019                	j	62c <vprintf+0x60>
    } else if(state == '%'){
 628:	01498d63          	beq	s3,s4,642 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 62c:	0485                	addi	s1,s1,1
 62e:	fff4c903          	lbu	s2,-1(s1)
 632:	14090d63          	beqz	s2,78c <vprintf+0x1c0>
    if(state == 0){
 636:	fe0999e3          	bnez	s3,628 <vprintf+0x5c>
      if(c == '%'){
 63a:	ff4910e3          	bne	s2,s4,61a <vprintf+0x4e>
        state = '%';
 63e:	89d2                	mv	s3,s4
 640:	b7f5                	j	62c <vprintf+0x60>
      if(c == 'd'){
 642:	11490c63          	beq	s2,s4,75a <vprintf+0x18e>
 646:	f9d9079b          	addiw	a5,s2,-99
 64a:	0ff7f793          	zext.b	a5,a5
 64e:	10fc6e63          	bltu	s8,a5,76a <vprintf+0x19e>
 652:	f9d9079b          	addiw	a5,s2,-99
 656:	0ff7f713          	zext.b	a4,a5
 65a:	10ec6863          	bltu	s8,a4,76a <vprintf+0x19e>
 65e:	00271793          	slli	a5,a4,0x2
 662:	97e6                	add	a5,a5,s9
 664:	439c                	lw	a5,0(a5)
 666:	97e6                	add	a5,a5,s9
 668:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 66a:	008b0913          	addi	s2,s6,8
 66e:	4685                	li	a3,1
 670:	4629                	li	a2,10
 672:	000b2583          	lw	a1,0(s6)
 676:	8556                	mv	a0,s5
 678:	00000097          	auipc	ra,0x0
 67c:	ea8080e7          	jalr	-344(ra) # 520 <printint>
 680:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 682:	4981                	li	s3,0
 684:	b765                	j	62c <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 686:	008b0913          	addi	s2,s6,8
 68a:	4681                	li	a3,0
 68c:	4629                	li	a2,10
 68e:	000b2583          	lw	a1,0(s6)
 692:	8556                	mv	a0,s5
 694:	00000097          	auipc	ra,0x0
 698:	e8c080e7          	jalr	-372(ra) # 520 <printint>
 69c:	8b4a                	mv	s6,s2
      state = 0;
 69e:	4981                	li	s3,0
 6a0:	b771                	j	62c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 6a2:	008b0913          	addi	s2,s6,8
 6a6:	4681                	li	a3,0
 6a8:	866a                	mv	a2,s10
 6aa:	000b2583          	lw	a1,0(s6)
 6ae:	8556                	mv	a0,s5
 6b0:	00000097          	auipc	ra,0x0
 6b4:	e70080e7          	jalr	-400(ra) # 520 <printint>
 6b8:	8b4a                	mv	s6,s2
      state = 0;
 6ba:	4981                	li	s3,0
 6bc:	bf85                	j	62c <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 6be:	008b0793          	addi	a5,s6,8
 6c2:	f8f43423          	sd	a5,-120(s0)
 6c6:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 6ca:	03000593          	li	a1,48
 6ce:	8556                	mv	a0,s5
 6d0:	00000097          	auipc	ra,0x0
 6d4:	e2e080e7          	jalr	-466(ra) # 4fe <putc>
  putc(fd, 'x');
 6d8:	07800593          	li	a1,120
 6dc:	8556                	mv	a0,s5
 6de:	00000097          	auipc	ra,0x0
 6e2:	e20080e7          	jalr	-480(ra) # 4fe <putc>
 6e6:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6e8:	03c9d793          	srli	a5,s3,0x3c
 6ec:	97de                	add	a5,a5,s7
 6ee:	0007c583          	lbu	a1,0(a5)
 6f2:	8556                	mv	a0,s5
 6f4:	00000097          	auipc	ra,0x0
 6f8:	e0a080e7          	jalr	-502(ra) # 4fe <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6fc:	0992                	slli	s3,s3,0x4
 6fe:	397d                	addiw	s2,s2,-1
 700:	fe0914e3          	bnez	s2,6e8 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 704:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 708:	4981                	li	s3,0
 70a:	b70d                	j	62c <vprintf+0x60>
        s = va_arg(ap, char*);
 70c:	008b0913          	addi	s2,s6,8
 710:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 714:	02098163          	beqz	s3,736 <vprintf+0x16a>
        while(*s != 0){
 718:	0009c583          	lbu	a1,0(s3)
 71c:	c5ad                	beqz	a1,786 <vprintf+0x1ba>
          putc(fd, *s);
 71e:	8556                	mv	a0,s5
 720:	00000097          	auipc	ra,0x0
 724:	dde080e7          	jalr	-546(ra) # 4fe <putc>
          s++;
 728:	0985                	addi	s3,s3,1
        while(*s != 0){
 72a:	0009c583          	lbu	a1,0(s3)
 72e:	f9e5                	bnez	a1,71e <vprintf+0x152>
        s = va_arg(ap, char*);
 730:	8b4a                	mv	s6,s2
      state = 0;
 732:	4981                	li	s3,0
 734:	bde5                	j	62c <vprintf+0x60>
          s = "(null)";
 736:	00000997          	auipc	s3,0x0
 73a:	27a98993          	addi	s3,s3,634 # 9b0 <malloc+0x120>
        while(*s != 0){
 73e:	85ee                	mv	a1,s11
 740:	bff9                	j	71e <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 742:	008b0913          	addi	s2,s6,8
 746:	000b4583          	lbu	a1,0(s6)
 74a:	8556                	mv	a0,s5
 74c:	00000097          	auipc	ra,0x0
 750:	db2080e7          	jalr	-590(ra) # 4fe <putc>
 754:	8b4a                	mv	s6,s2
      state = 0;
 756:	4981                	li	s3,0
 758:	bdd1                	j	62c <vprintf+0x60>
        putc(fd, c);
 75a:	85d2                	mv	a1,s4
 75c:	8556                	mv	a0,s5
 75e:	00000097          	auipc	ra,0x0
 762:	da0080e7          	jalr	-608(ra) # 4fe <putc>
      state = 0;
 766:	4981                	li	s3,0
 768:	b5d1                	j	62c <vprintf+0x60>
        putc(fd, '%');
 76a:	85d2                	mv	a1,s4
 76c:	8556                	mv	a0,s5
 76e:	00000097          	auipc	ra,0x0
 772:	d90080e7          	jalr	-624(ra) # 4fe <putc>
        putc(fd, c);
 776:	85ca                	mv	a1,s2
 778:	8556                	mv	a0,s5
 77a:	00000097          	auipc	ra,0x0
 77e:	d84080e7          	jalr	-636(ra) # 4fe <putc>
      state = 0;
 782:	4981                	li	s3,0
 784:	b565                	j	62c <vprintf+0x60>
        s = va_arg(ap, char*);
 786:	8b4a                	mv	s6,s2
      state = 0;
 788:	4981                	li	s3,0
 78a:	b54d                	j	62c <vprintf+0x60>
    }
  }
}
 78c:	70e6                	ld	ra,120(sp)
 78e:	7446                	ld	s0,112(sp)
 790:	74a6                	ld	s1,104(sp)
 792:	7906                	ld	s2,96(sp)
 794:	69e6                	ld	s3,88(sp)
 796:	6a46                	ld	s4,80(sp)
 798:	6aa6                	ld	s5,72(sp)
 79a:	6b06                	ld	s6,64(sp)
 79c:	7be2                	ld	s7,56(sp)
 79e:	7c42                	ld	s8,48(sp)
 7a0:	7ca2                	ld	s9,40(sp)
 7a2:	7d02                	ld	s10,32(sp)
 7a4:	6de2                	ld	s11,24(sp)
 7a6:	6109                	addi	sp,sp,128
 7a8:	8082                	ret

00000000000007aa <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7aa:	715d                	addi	sp,sp,-80
 7ac:	ec06                	sd	ra,24(sp)
 7ae:	e822                	sd	s0,16(sp)
 7b0:	1000                	addi	s0,sp,32
 7b2:	e010                	sd	a2,0(s0)
 7b4:	e414                	sd	a3,8(s0)
 7b6:	e818                	sd	a4,16(s0)
 7b8:	ec1c                	sd	a5,24(s0)
 7ba:	03043023          	sd	a6,32(s0)
 7be:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7c2:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7c6:	8622                	mv	a2,s0
 7c8:	00000097          	auipc	ra,0x0
 7cc:	e04080e7          	jalr	-508(ra) # 5cc <vprintf>
}
 7d0:	60e2                	ld	ra,24(sp)
 7d2:	6442                	ld	s0,16(sp)
 7d4:	6161                	addi	sp,sp,80
 7d6:	8082                	ret

00000000000007d8 <printf>:

void
printf(const char *fmt, ...)
{
 7d8:	711d                	addi	sp,sp,-96
 7da:	ec06                	sd	ra,24(sp)
 7dc:	e822                	sd	s0,16(sp)
 7de:	1000                	addi	s0,sp,32
 7e0:	e40c                	sd	a1,8(s0)
 7e2:	e810                	sd	a2,16(s0)
 7e4:	ec14                	sd	a3,24(s0)
 7e6:	f018                	sd	a4,32(s0)
 7e8:	f41c                	sd	a5,40(s0)
 7ea:	03043823          	sd	a6,48(s0)
 7ee:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7f2:	00840613          	addi	a2,s0,8
 7f6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7fa:	85aa                	mv	a1,a0
 7fc:	4505                	li	a0,1
 7fe:	00000097          	auipc	ra,0x0
 802:	dce080e7          	jalr	-562(ra) # 5cc <vprintf>
}
 806:	60e2                	ld	ra,24(sp)
 808:	6442                	ld	s0,16(sp)
 80a:	6125                	addi	sp,sp,96
 80c:	8082                	ret

000000000000080e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 80e:	1141                	addi	sp,sp,-16
 810:	e422                	sd	s0,8(sp)
 812:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 814:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 818:	00000797          	auipc	a5,0x0
 81c:	7e87b783          	ld	a5,2024(a5) # 1000 <freep>
 820:	a02d                	j	84a <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 822:	4618                	lw	a4,8(a2)
 824:	9f2d                	addw	a4,a4,a1
 826:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 82a:	6398                	ld	a4,0(a5)
 82c:	6310                	ld	a2,0(a4)
 82e:	a83d                	j	86c <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 830:	ff852703          	lw	a4,-8(a0)
 834:	9f31                	addw	a4,a4,a2
 836:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 838:	ff053683          	ld	a3,-16(a0)
 83c:	a091                	j	880 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 83e:	6398                	ld	a4,0(a5)
 840:	00e7e463          	bltu	a5,a4,848 <free+0x3a>
 844:	00e6ea63          	bltu	a3,a4,858 <free+0x4a>
{
 848:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 84a:	fed7fae3          	bgeu	a5,a3,83e <free+0x30>
 84e:	6398                	ld	a4,0(a5)
 850:	00e6e463          	bltu	a3,a4,858 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 854:	fee7eae3          	bltu	a5,a4,848 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 858:	ff852583          	lw	a1,-8(a0)
 85c:	6390                	ld	a2,0(a5)
 85e:	02059813          	slli	a6,a1,0x20
 862:	01c85713          	srli	a4,a6,0x1c
 866:	9736                	add	a4,a4,a3
 868:	fae60de3          	beq	a2,a4,822 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 86c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 870:	4790                	lw	a2,8(a5)
 872:	02061593          	slli	a1,a2,0x20
 876:	01c5d713          	srli	a4,a1,0x1c
 87a:	973e                	add	a4,a4,a5
 87c:	fae68ae3          	beq	a3,a4,830 <free+0x22>
    p->s.ptr = bp->s.ptr;
 880:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 882:	00000717          	auipc	a4,0x0
 886:	76f73f23          	sd	a5,1918(a4) # 1000 <freep>
}
 88a:	6422                	ld	s0,8(sp)
 88c:	0141                	addi	sp,sp,16
 88e:	8082                	ret

0000000000000890 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 890:	7139                	addi	sp,sp,-64
 892:	fc06                	sd	ra,56(sp)
 894:	f822                	sd	s0,48(sp)
 896:	f426                	sd	s1,40(sp)
 898:	f04a                	sd	s2,32(sp)
 89a:	ec4e                	sd	s3,24(sp)
 89c:	e852                	sd	s4,16(sp)
 89e:	e456                	sd	s5,8(sp)
 8a0:	e05a                	sd	s6,0(sp)
 8a2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8a4:	02051493          	slli	s1,a0,0x20
 8a8:	9081                	srli	s1,s1,0x20
 8aa:	04bd                	addi	s1,s1,15
 8ac:	8091                	srli	s1,s1,0x4
 8ae:	0014899b          	addiw	s3,s1,1
 8b2:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 8b4:	00000517          	auipc	a0,0x0
 8b8:	74c53503          	ld	a0,1868(a0) # 1000 <freep>
 8bc:	c515                	beqz	a0,8e8 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8be:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8c0:	4798                	lw	a4,8(a5)
 8c2:	02977f63          	bgeu	a4,s1,900 <malloc+0x70>
 8c6:	8a4e                	mv	s4,s3
 8c8:	0009871b          	sext.w	a4,s3
 8cc:	6685                	lui	a3,0x1
 8ce:	00d77363          	bgeu	a4,a3,8d4 <malloc+0x44>
 8d2:	6a05                	lui	s4,0x1
 8d4:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8d8:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8dc:	00000917          	auipc	s2,0x0
 8e0:	72490913          	addi	s2,s2,1828 # 1000 <freep>
  if(p == (char*)-1)
 8e4:	5afd                	li	s5,-1
 8e6:	a895                	j	95a <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 8e8:	00000797          	auipc	a5,0x0
 8ec:	72878793          	addi	a5,a5,1832 # 1010 <base>
 8f0:	00000717          	auipc	a4,0x0
 8f4:	70f73823          	sd	a5,1808(a4) # 1000 <freep>
 8f8:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8fa:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8fe:	b7e1                	j	8c6 <malloc+0x36>
      if(p->s.size == nunits)
 900:	02e48c63          	beq	s1,a4,938 <malloc+0xa8>
        p->s.size -= nunits;
 904:	4137073b          	subw	a4,a4,s3
 908:	c798                	sw	a4,8(a5)
        p += p->s.size;
 90a:	02071693          	slli	a3,a4,0x20
 90e:	01c6d713          	srli	a4,a3,0x1c
 912:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 914:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 918:	00000717          	auipc	a4,0x0
 91c:	6ea73423          	sd	a0,1768(a4) # 1000 <freep>
      return (void*)(p + 1);
 920:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 924:	70e2                	ld	ra,56(sp)
 926:	7442                	ld	s0,48(sp)
 928:	74a2                	ld	s1,40(sp)
 92a:	7902                	ld	s2,32(sp)
 92c:	69e2                	ld	s3,24(sp)
 92e:	6a42                	ld	s4,16(sp)
 930:	6aa2                	ld	s5,8(sp)
 932:	6b02                	ld	s6,0(sp)
 934:	6121                	addi	sp,sp,64
 936:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 938:	6398                	ld	a4,0(a5)
 93a:	e118                	sd	a4,0(a0)
 93c:	bff1                	j	918 <malloc+0x88>
  hp->s.size = nu;
 93e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 942:	0541                	addi	a0,a0,16
 944:	00000097          	auipc	ra,0x0
 948:	eca080e7          	jalr	-310(ra) # 80e <free>
  return freep;
 94c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 950:	d971                	beqz	a0,924 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 952:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 954:	4798                	lw	a4,8(a5)
 956:	fa9775e3          	bgeu	a4,s1,900 <malloc+0x70>
    if(p == freep)
 95a:	00093703          	ld	a4,0(s2)
 95e:	853e                	mv	a0,a5
 960:	fef719e3          	bne	a4,a5,952 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 964:	8552                	mv	a0,s4
 966:	00000097          	auipc	ra,0x0
 96a:	b78080e7          	jalr	-1160(ra) # 4de <sbrk>
  if(p == (char*)-1)
 96e:	fd5518e3          	bne	a0,s5,93e <malloc+0xae>
        return 0;
 972:	4501                	li	a0,0
 974:	bf45                	j	924 <malloc+0x94>
