
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
  16:	93e58593          	addi	a1,a1,-1730 # 950 <malloc+0xf2>
  1a:	4509                	li	a0,2
  1c:	00000097          	auipc	ra,0x0
  20:	428080e7          	jalr	1064(ra) # 444 <write>

    // bufferPointer = buffer;

    //read input from user
    // bytesRead = read(0, p, 1);
    gets(buffer, bufferSize);
  24:	85ca                	mv	a1,s2
  26:	8526                	mv	a0,s1
  28:	00000097          	auipc	ra,0x0
  2c:	248080e7          	jalr	584(ra) # 270 <gets>


    if (strlen(buffer) == 1)
  30:	8526                	mv	a0,s1
  32:	00000097          	auipc	ra,0x0
  36:	1ce080e7          	jalr	462(ra) # 200 <strlen>
  3a:	2501                	sext.w	a0,a0
  3c:	4785                	li	a5,1
  3e:	02f50663          	beq	a0,a5,6a <readLine+0x6a>
        {
            continue;
        }
    }

    return 1;
  42:	4505                	li	a0,1
    for (int i=0; i<bufferSize; i++)
  44:	05205263          	blez	s2,88 <readLine+0x88>
  48:	87a6                	mv	a5,s1
  4a:	0485                	addi	s1,s1,1
  4c:	397d                	addiw	s2,s2,-1
  4e:	1902                	slli	s2,s2,0x20
  50:	02095913          	srli	s2,s2,0x20
  54:	94ca                	add	s1,s1,s2
        if (buffer[i] == '\n')
  56:	46a9                	li	a3,10
  58:	0007c703          	lbu	a4,0(a5)
  5c:	02d70363          	beq	a4,a3,82 <readLine+0x82>
    for (int i=0; i<bufferSize; i++)
  60:	0785                	addi	a5,a5,1
  62:	fe979be3          	bne	a5,s1,58 <readLine+0x58>
    return 1;
  66:	4505                	li	a0,1
  68:	a005                	j	88 <readLine+0x88>
        write(2, "\n", 2);
  6a:	4609                	li	a2,2
  6c:	00001597          	auipc	a1,0x1
  70:	8ec58593          	addi	a1,a1,-1812 # 958 <malloc+0xfa>
  74:	4509                	li	a0,2
  76:	00000097          	auipc	ra,0x0
  7a:	3ce080e7          	jalr	974(ra) # 444 <write>
        return 0;
  7e:	4501                	li	a0,0
  80:	a021                	j	88 <readLine+0x88>
            buffer[i] = '\0';
  82:	00078023          	sb	zero,0(a5)
            return 1;
  86:	4505                	li	a0,1
}
  88:	60e2                	ld	ra,24(sp)
  8a:	6442                	ld	s0,16(sp)
  8c:	64a2                	ld	s1,8(sp)
  8e:	6902                	ld	s2,0(sp)
  90:	6105                	addi	sp,sp,32
  92:	8082                	ret

0000000000000094 <formatLine>:

void
formatLine(char *buffer, char *args[])
{
  94:	1101                	addi	sp,sp,-32
  96:	ec06                	sd	ra,24(sp)
  98:	e822                	sd	s0,16(sp)
  9a:	e426                	sd	s1,8(sp)
  9c:	e04a                	sd	s2,0(sp)
  9e:	1000                	addi	s0,sp,32
  a0:	84aa                	mv	s1,a0
  a2:	892e                	mv	s2,a1

    int pid = fork();
  a4:	00000097          	auipc	ra,0x0
  a8:	378080e7          	jalr	888(ra) # 41c <fork>
    if (pid < 0)
  ac:	00054c63          	bltz	a0,c4 <formatLine+0x30>
    {
        printf("Fork failed");
        exit(1);
    } else if(pid == 0)
  b0:	e13d                	bnez	a0,116 <formatLine+0x82>

        argumentPointer = &args[0];

        //set buffer pointer to start of buffer
        bufferPointer = buffer;
        while (*bufferPointer != '\0') {
  b2:	0004c783          	lbu	a5,0(s1)
  b6:	c3b9                	beqz	a5,fc <formatLine+0x68>
        argumentPointer = &args[0];
  b8:	864a                	mv	a2,s2
        int wordstart = 1;
  ba:	4705                	li	a4,1
            if (*bufferPointer != ' ') 
  bc:	02000693          	li	a3,32
                // the pointer a is then incremented to point ot the next element in the args array,
                // preparing it to store the address of the next word. 
                argumentPointer++;

                //ws is set to 1 indicating the whitespace has started, as we're in the space between words.
                wordstart = 1;
  c0:	4585                	li	a1,1
  c2:	a03d                	j	f0 <formatLine+0x5c>
        printf("Fork failed");
  c4:	00001517          	auipc	a0,0x1
  c8:	89c50513          	addi	a0,a0,-1892 # 960 <malloc+0x102>
  cc:	00000097          	auipc	ra,0x0
  d0:	6da080e7          	jalr	1754(ra) # 7a6 <printf>
        exit(1);
  d4:	4505                	li	a0,1
  d6:	00000097          	auipc	ra,0x0
  da:	34e080e7          	jalr	846(ra) # 424 <exit>
                if (!wordstart) 
  de:	e709                	bnez	a4,e8 <formatLine+0x54>
                *bufferPointer = '\0';
  e0:	00048023          	sb	zero,0(s1)
                argumentPointer++;
  e4:	0621                	addi	a2,a2,8
                wordstart = 1;
  e6:	872e                	mv	a4,a1
                }
            }

        // pointer b is moved to the next character in the line, and the process continues for the next character
        bufferPointer++;
  e8:	0485                	addi	s1,s1,1
        while (*bufferPointer != '\0') {
  ea:	0004c783          	lbu	a5,0(s1)
  ee:	c799                	beqz	a5,fc <formatLine+0x68>
            if (*bufferPointer != ' ') 
  f0:	fed787e3          	beq	a5,a3,de <formatLine+0x4a>
                if (wordstart)
  f4:	db75                	beqz	a4,e8 <formatLine+0x54>
                    *argumentPointer = bufferPointer;
  f6:	e204                	sd	s1,0(a2)
                    wordstart = 0;
  f8:	872a                	mv	a4,a0
  fa:	b7fd                	j	e8 <formatLine+0x54>
        }
        // At this point args stores pointers to the original
        // command passed to xargs plus pointers to any inputs from
        // the standard input. Execute the command.
        exec(args[0], args);
  fc:	85ca                	mv	a1,s2
  fe:	00093503          	ld	a0,0(s2)
 102:	00000097          	auipc	ra,0x0
 106:	35a080e7          	jalr	858(ra) # 45c <exec>
        
    } else // parent
        wait(0);
}
 10a:	60e2                	ld	ra,24(sp)
 10c:	6442                	ld	s0,16(sp)
 10e:	64a2                	ld	s1,8(sp)
 110:	6902                	ld	s2,0(sp)
 112:	6105                	addi	sp,sp,32
 114:	8082                	ret
        wait(0);
 116:	4501                	li	a0,0
 118:	00000097          	auipc	ra,0x0
 11c:	314080e7          	jalr	788(ra) # 42c <wait>
}
 120:	b7ed                	j	10a <formatLine+0x76>

0000000000000122 <cd>:

//function to change directory
void
cd(char *path)
{
 122:	1101                	addi	sp,sp,-32
 124:	ec06                	sd	ra,24(sp)
 126:	e822                	sd	s0,16(sp)
 128:	e426                	sd	s1,8(sp)
 12a:	1000                	addi	s0,sp,32
 12c:	84aa                	mv	s1,a0
    if(chdir(path) < 0)
 12e:	00000097          	auipc	ra,0x0
 132:	366080e7          	jalr	870(ra) # 494 <chdir>
 136:	00054763          	bltz	a0,144 <cd+0x22>
    {
        printf("cd: Error. Cannot cd to %s\n", path);
    }

}
 13a:	60e2                	ld	ra,24(sp)
 13c:	6442                	ld	s0,16(sp)
 13e:	64a2                	ld	s1,8(sp)
 140:	6105                	addi	sp,sp,32
 142:	8082                	ret
        printf("cd: Error. Cannot cd to %s\n", path);
 144:	85a6                	mv	a1,s1
 146:	00001517          	auipc	a0,0x1
 14a:	82a50513          	addi	a0,a0,-2006 # 970 <malloc+0x112>
 14e:	00000097          	auipc	ra,0x0
 152:	658080e7          	jalr	1624(ra) # 7a6 <printf>
}
 156:	b7d5                	j	13a <cd+0x18>

0000000000000158 <main>:

int 
main(int argc, char *argv[]) 
{
 158:	712d                	addi	sp,sp,-288
 15a:	ee06                	sd	ra,280(sp)
 15c:	ea22                	sd	s0,272(sp)
 15e:	e626                	sd	s1,264(sp)
 160:	e24a                	sd	s2,256(sp)
 162:	1200                	addi	s0,sp,288
    const int BUFSIZE = 512;
    char buffer[BUFSIZE];    
 164:	7101                	addi	sp,sp,-512
 166:	848a                	mv	s1,sp

    char* args[MAXARG] = { 0 };
 168:	10000613          	li	a2,256
 16c:	4581                	li	a1,0
 16e:	ee040513          	addi	a0,s0,-288
 172:	00000097          	auipc	ra,0x0
 176:	0b8080e7          	jalr	184(ra) # 22a <memset>

    while (1)
    {
        if (readLine(buffer, BUFSIZE) == 1)
 17a:	4905                	li	s2,1
 17c:	20000593          	li	a1,512
 180:	8526                	mv	a0,s1
 182:	00000097          	auipc	ra,0x0
 186:	e7e080e7          	jalr	-386(ra) # 0 <readLine>
 18a:	ff2519e3          	bne	a0,s2,17c <main+0x24>
        {
            formatLine(buffer, args);
 18e:	ee040593          	addi	a1,s0,-288
 192:	8526                	mv	a0,s1
 194:	00000097          	auipc	ra,0x0
 198:	f00080e7          	jalr	-256(ra) # 94 <formatLine>
 19c:	b7c5                	j	17c <main+0x24>

000000000000019e <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 19e:	1141                	addi	sp,sp,-16
 1a0:	e406                	sd	ra,8(sp)
 1a2:	e022                	sd	s0,0(sp)
 1a4:	0800                	addi	s0,sp,16
  extern int main();
  main();
 1a6:	00000097          	auipc	ra,0x0
 1aa:	fb2080e7          	jalr	-78(ra) # 158 <main>
  exit(0);
 1ae:	4501                	li	a0,0
 1b0:	00000097          	auipc	ra,0x0
 1b4:	274080e7          	jalr	628(ra) # 424 <exit>

00000000000001b8 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 1b8:	1141                	addi	sp,sp,-16
 1ba:	e422                	sd	s0,8(sp)
 1bc:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1be:	87aa                	mv	a5,a0
 1c0:	0585                	addi	a1,a1,1
 1c2:	0785                	addi	a5,a5,1
 1c4:	fff5c703          	lbu	a4,-1(a1)
 1c8:	fee78fa3          	sb	a4,-1(a5)
 1cc:	fb75                	bnez	a4,1c0 <strcpy+0x8>
    ;
  return os;
}
 1ce:	6422                	ld	s0,8(sp)
 1d0:	0141                	addi	sp,sp,16
 1d2:	8082                	ret

00000000000001d4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1d4:	1141                	addi	sp,sp,-16
 1d6:	e422                	sd	s0,8(sp)
 1d8:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1da:	00054783          	lbu	a5,0(a0)
 1de:	cb91                	beqz	a5,1f2 <strcmp+0x1e>
 1e0:	0005c703          	lbu	a4,0(a1)
 1e4:	00f71763          	bne	a4,a5,1f2 <strcmp+0x1e>
    p++, q++;
 1e8:	0505                	addi	a0,a0,1
 1ea:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1ec:	00054783          	lbu	a5,0(a0)
 1f0:	fbe5                	bnez	a5,1e0 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1f2:	0005c503          	lbu	a0,0(a1)
}
 1f6:	40a7853b          	subw	a0,a5,a0
 1fa:	6422                	ld	s0,8(sp)
 1fc:	0141                	addi	sp,sp,16
 1fe:	8082                	ret

0000000000000200 <strlen>:

uint
strlen(const char *s)
{
 200:	1141                	addi	sp,sp,-16
 202:	e422                	sd	s0,8(sp)
 204:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 206:	00054783          	lbu	a5,0(a0)
 20a:	cf91                	beqz	a5,226 <strlen+0x26>
 20c:	0505                	addi	a0,a0,1
 20e:	87aa                	mv	a5,a0
 210:	4685                	li	a3,1
 212:	9e89                	subw	a3,a3,a0
 214:	00f6853b          	addw	a0,a3,a5
 218:	0785                	addi	a5,a5,1
 21a:	fff7c703          	lbu	a4,-1(a5)
 21e:	fb7d                	bnez	a4,214 <strlen+0x14>
    ;
  return n;
}
 220:	6422                	ld	s0,8(sp)
 222:	0141                	addi	sp,sp,16
 224:	8082                	ret
  for(n = 0; s[n]; n++)
 226:	4501                	li	a0,0
 228:	bfe5                	j	220 <strlen+0x20>

000000000000022a <memset>:

void*
memset(void *dst, int c, uint n)
{
 22a:	1141                	addi	sp,sp,-16
 22c:	e422                	sd	s0,8(sp)
 22e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 230:	ca19                	beqz	a2,246 <memset+0x1c>
 232:	87aa                	mv	a5,a0
 234:	1602                	slli	a2,a2,0x20
 236:	9201                	srli	a2,a2,0x20
 238:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 23c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 240:	0785                	addi	a5,a5,1
 242:	fee79de3          	bne	a5,a4,23c <memset+0x12>
  }
  return dst;
}
 246:	6422                	ld	s0,8(sp)
 248:	0141                	addi	sp,sp,16
 24a:	8082                	ret

000000000000024c <strchr>:

char*
strchr(const char *s, char c)
{
 24c:	1141                	addi	sp,sp,-16
 24e:	e422                	sd	s0,8(sp)
 250:	0800                	addi	s0,sp,16
  for(; *s; s++)
 252:	00054783          	lbu	a5,0(a0)
 256:	cb99                	beqz	a5,26c <strchr+0x20>
    if(*s == c)
 258:	00f58763          	beq	a1,a5,266 <strchr+0x1a>
  for(; *s; s++)
 25c:	0505                	addi	a0,a0,1
 25e:	00054783          	lbu	a5,0(a0)
 262:	fbfd                	bnez	a5,258 <strchr+0xc>
      return (char*)s;
  return 0;
 264:	4501                	li	a0,0
}
 266:	6422                	ld	s0,8(sp)
 268:	0141                	addi	sp,sp,16
 26a:	8082                	ret
  return 0;
 26c:	4501                	li	a0,0
 26e:	bfe5                	j	266 <strchr+0x1a>

0000000000000270 <gets>:

char*
gets(char *buf, int max)
{
 270:	711d                	addi	sp,sp,-96
 272:	ec86                	sd	ra,88(sp)
 274:	e8a2                	sd	s0,80(sp)
 276:	e4a6                	sd	s1,72(sp)
 278:	e0ca                	sd	s2,64(sp)
 27a:	fc4e                	sd	s3,56(sp)
 27c:	f852                	sd	s4,48(sp)
 27e:	f456                	sd	s5,40(sp)
 280:	f05a                	sd	s6,32(sp)
 282:	ec5e                	sd	s7,24(sp)
 284:	1080                	addi	s0,sp,96
 286:	8baa                	mv	s7,a0
 288:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 28a:	892a                	mv	s2,a0
 28c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 28e:	4aa9                	li	s5,10
 290:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 292:	89a6                	mv	s3,s1
 294:	2485                	addiw	s1,s1,1
 296:	0344d863          	bge	s1,s4,2c6 <gets+0x56>
    cc = read(0, &c, 1);
 29a:	4605                	li	a2,1
 29c:	faf40593          	addi	a1,s0,-81
 2a0:	4501                	li	a0,0
 2a2:	00000097          	auipc	ra,0x0
 2a6:	19a080e7          	jalr	410(ra) # 43c <read>
    if(cc < 1)
 2aa:	00a05e63          	blez	a0,2c6 <gets+0x56>
    buf[i++] = c;
 2ae:	faf44783          	lbu	a5,-81(s0)
 2b2:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2b6:	01578763          	beq	a5,s5,2c4 <gets+0x54>
 2ba:	0905                	addi	s2,s2,1
 2bc:	fd679be3          	bne	a5,s6,292 <gets+0x22>
  for(i=0; i+1 < max; ){
 2c0:	89a6                	mv	s3,s1
 2c2:	a011                	j	2c6 <gets+0x56>
 2c4:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2c6:	99de                	add	s3,s3,s7
 2c8:	00098023          	sb	zero,0(s3)
  return buf;
}
 2cc:	855e                	mv	a0,s7
 2ce:	60e6                	ld	ra,88(sp)
 2d0:	6446                	ld	s0,80(sp)
 2d2:	64a6                	ld	s1,72(sp)
 2d4:	6906                	ld	s2,64(sp)
 2d6:	79e2                	ld	s3,56(sp)
 2d8:	7a42                	ld	s4,48(sp)
 2da:	7aa2                	ld	s5,40(sp)
 2dc:	7b02                	ld	s6,32(sp)
 2de:	6be2                	ld	s7,24(sp)
 2e0:	6125                	addi	sp,sp,96
 2e2:	8082                	ret

00000000000002e4 <stat>:

int
stat(const char *n, struct stat *st)
{
 2e4:	1101                	addi	sp,sp,-32
 2e6:	ec06                	sd	ra,24(sp)
 2e8:	e822                	sd	s0,16(sp)
 2ea:	e426                	sd	s1,8(sp)
 2ec:	e04a                	sd	s2,0(sp)
 2ee:	1000                	addi	s0,sp,32
 2f0:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2f2:	4581                	li	a1,0
 2f4:	00000097          	auipc	ra,0x0
 2f8:	170080e7          	jalr	368(ra) # 464 <open>
  if(fd < 0)
 2fc:	02054563          	bltz	a0,326 <stat+0x42>
 300:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 302:	85ca                	mv	a1,s2
 304:	00000097          	auipc	ra,0x0
 308:	178080e7          	jalr	376(ra) # 47c <fstat>
 30c:	892a                	mv	s2,a0
  close(fd);
 30e:	8526                	mv	a0,s1
 310:	00000097          	auipc	ra,0x0
 314:	13c080e7          	jalr	316(ra) # 44c <close>
  return r;
}
 318:	854a                	mv	a0,s2
 31a:	60e2                	ld	ra,24(sp)
 31c:	6442                	ld	s0,16(sp)
 31e:	64a2                	ld	s1,8(sp)
 320:	6902                	ld	s2,0(sp)
 322:	6105                	addi	sp,sp,32
 324:	8082                	ret
    return -1;
 326:	597d                	li	s2,-1
 328:	bfc5                	j	318 <stat+0x34>

000000000000032a <atoi>:

int
atoi(const char *s)
{
 32a:	1141                	addi	sp,sp,-16
 32c:	e422                	sd	s0,8(sp)
 32e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 330:	00054683          	lbu	a3,0(a0)
 334:	fd06879b          	addiw	a5,a3,-48
 338:	0ff7f793          	zext.b	a5,a5
 33c:	4625                	li	a2,9
 33e:	02f66863          	bltu	a2,a5,36e <atoi+0x44>
 342:	872a                	mv	a4,a0
  n = 0;
 344:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 346:	0705                	addi	a4,a4,1
 348:	0025179b          	slliw	a5,a0,0x2
 34c:	9fa9                	addw	a5,a5,a0
 34e:	0017979b          	slliw	a5,a5,0x1
 352:	9fb5                	addw	a5,a5,a3
 354:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 358:	00074683          	lbu	a3,0(a4)
 35c:	fd06879b          	addiw	a5,a3,-48
 360:	0ff7f793          	zext.b	a5,a5
 364:	fef671e3          	bgeu	a2,a5,346 <atoi+0x1c>
  return n;
}
 368:	6422                	ld	s0,8(sp)
 36a:	0141                	addi	sp,sp,16
 36c:	8082                	ret
  n = 0;
 36e:	4501                	li	a0,0
 370:	bfe5                	j	368 <atoi+0x3e>

0000000000000372 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 372:	1141                	addi	sp,sp,-16
 374:	e422                	sd	s0,8(sp)
 376:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 378:	02b57463          	bgeu	a0,a1,3a0 <memmove+0x2e>
    while(n-- > 0)
 37c:	00c05f63          	blez	a2,39a <memmove+0x28>
 380:	1602                	slli	a2,a2,0x20
 382:	9201                	srli	a2,a2,0x20
 384:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 388:	872a                	mv	a4,a0
      *dst++ = *src++;
 38a:	0585                	addi	a1,a1,1
 38c:	0705                	addi	a4,a4,1
 38e:	fff5c683          	lbu	a3,-1(a1)
 392:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 396:	fee79ae3          	bne	a5,a4,38a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 39a:	6422                	ld	s0,8(sp)
 39c:	0141                	addi	sp,sp,16
 39e:	8082                	ret
    dst += n;
 3a0:	00c50733          	add	a4,a0,a2
    src += n;
 3a4:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3a6:	fec05ae3          	blez	a2,39a <memmove+0x28>
 3aa:	fff6079b          	addiw	a5,a2,-1
 3ae:	1782                	slli	a5,a5,0x20
 3b0:	9381                	srli	a5,a5,0x20
 3b2:	fff7c793          	not	a5,a5
 3b6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3b8:	15fd                	addi	a1,a1,-1
 3ba:	177d                	addi	a4,a4,-1
 3bc:	0005c683          	lbu	a3,0(a1)
 3c0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3c4:	fee79ae3          	bne	a5,a4,3b8 <memmove+0x46>
 3c8:	bfc9                	j	39a <memmove+0x28>

00000000000003ca <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3ca:	1141                	addi	sp,sp,-16
 3cc:	e422                	sd	s0,8(sp)
 3ce:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3d0:	ca05                	beqz	a2,400 <memcmp+0x36>
 3d2:	fff6069b          	addiw	a3,a2,-1
 3d6:	1682                	slli	a3,a3,0x20
 3d8:	9281                	srli	a3,a3,0x20
 3da:	0685                	addi	a3,a3,1
 3dc:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3de:	00054783          	lbu	a5,0(a0)
 3e2:	0005c703          	lbu	a4,0(a1)
 3e6:	00e79863          	bne	a5,a4,3f6 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3ea:	0505                	addi	a0,a0,1
    p2++;
 3ec:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3ee:	fed518e3          	bne	a0,a3,3de <memcmp+0x14>
  }
  return 0;
 3f2:	4501                	li	a0,0
 3f4:	a019                	j	3fa <memcmp+0x30>
      return *p1 - *p2;
 3f6:	40e7853b          	subw	a0,a5,a4
}
 3fa:	6422                	ld	s0,8(sp)
 3fc:	0141                	addi	sp,sp,16
 3fe:	8082                	ret
  return 0;
 400:	4501                	li	a0,0
 402:	bfe5                	j	3fa <memcmp+0x30>

0000000000000404 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 404:	1141                	addi	sp,sp,-16
 406:	e406                	sd	ra,8(sp)
 408:	e022                	sd	s0,0(sp)
 40a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 40c:	00000097          	auipc	ra,0x0
 410:	f66080e7          	jalr	-154(ra) # 372 <memmove>
}
 414:	60a2                	ld	ra,8(sp)
 416:	6402                	ld	s0,0(sp)
 418:	0141                	addi	sp,sp,16
 41a:	8082                	ret

000000000000041c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 41c:	4885                	li	a7,1
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <exit>:
.global exit
exit:
 li a7, SYS_exit
 424:	4889                	li	a7,2
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <wait>:
.global wait
wait:
 li a7, SYS_wait
 42c:	488d                	li	a7,3
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 434:	4891                	li	a7,4
 ecall
 436:	00000073          	ecall
 ret
 43a:	8082                	ret

000000000000043c <read>:
.global read
read:
 li a7, SYS_read
 43c:	4895                	li	a7,5
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <write>:
.global write
write:
 li a7, SYS_write
 444:	48c1                	li	a7,16
 ecall
 446:	00000073          	ecall
 ret
 44a:	8082                	ret

000000000000044c <close>:
.global close
close:
 li a7, SYS_close
 44c:	48d5                	li	a7,21
 ecall
 44e:	00000073          	ecall
 ret
 452:	8082                	ret

0000000000000454 <kill>:
.global kill
kill:
 li a7, SYS_kill
 454:	4899                	li	a7,6
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <exec>:
.global exec
exec:
 li a7, SYS_exec
 45c:	489d                	li	a7,7
 ecall
 45e:	00000073          	ecall
 ret
 462:	8082                	ret

0000000000000464 <open>:
.global open
open:
 li a7, SYS_open
 464:	48bd                	li	a7,15
 ecall
 466:	00000073          	ecall
 ret
 46a:	8082                	ret

000000000000046c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 46c:	48c5                	li	a7,17
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 474:	48c9                	li	a7,18
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 47c:	48a1                	li	a7,8
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <link>:
.global link
link:
 li a7, SYS_link
 484:	48cd                	li	a7,19
 ecall
 486:	00000073          	ecall
 ret
 48a:	8082                	ret

000000000000048c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 48c:	48d1                	li	a7,20
 ecall
 48e:	00000073          	ecall
 ret
 492:	8082                	ret

0000000000000494 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 494:	48a5                	li	a7,9
 ecall
 496:	00000073          	ecall
 ret
 49a:	8082                	ret

000000000000049c <dup>:
.global dup
dup:
 li a7, SYS_dup
 49c:	48a9                	li	a7,10
 ecall
 49e:	00000073          	ecall
 ret
 4a2:	8082                	ret

00000000000004a4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4a4:	48ad                	li	a7,11
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4ac:	48b1                	li	a7,12
 ecall
 4ae:	00000073          	ecall
 ret
 4b2:	8082                	ret

00000000000004b4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4b4:	48b5                	li	a7,13
 ecall
 4b6:	00000073          	ecall
 ret
 4ba:	8082                	ret

00000000000004bc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4bc:	48b9                	li	a7,14
 ecall
 4be:	00000073          	ecall
 ret
 4c2:	8082                	ret

00000000000004c4 <getyear>:
.global getyear
getyear:
 li a7, SYS_getyear
 4c4:	48d9                	li	a7,22
 ecall
 4c6:	00000073          	ecall
 ret
 4ca:	8082                	ret

00000000000004cc <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4cc:	1101                	addi	sp,sp,-32
 4ce:	ec06                	sd	ra,24(sp)
 4d0:	e822                	sd	s0,16(sp)
 4d2:	1000                	addi	s0,sp,32
 4d4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4d8:	4605                	li	a2,1
 4da:	fef40593          	addi	a1,s0,-17
 4de:	00000097          	auipc	ra,0x0
 4e2:	f66080e7          	jalr	-154(ra) # 444 <write>
}
 4e6:	60e2                	ld	ra,24(sp)
 4e8:	6442                	ld	s0,16(sp)
 4ea:	6105                	addi	sp,sp,32
 4ec:	8082                	ret

00000000000004ee <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4ee:	7139                	addi	sp,sp,-64
 4f0:	fc06                	sd	ra,56(sp)
 4f2:	f822                	sd	s0,48(sp)
 4f4:	f426                	sd	s1,40(sp)
 4f6:	f04a                	sd	s2,32(sp)
 4f8:	ec4e                	sd	s3,24(sp)
 4fa:	0080                	addi	s0,sp,64
 4fc:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4fe:	c299                	beqz	a3,504 <printint+0x16>
 500:	0805c963          	bltz	a1,592 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 504:	2581                	sext.w	a1,a1
  neg = 0;
 506:	4881                	li	a7,0
 508:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 50c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 50e:	2601                	sext.w	a2,a2
 510:	00000517          	auipc	a0,0x0
 514:	4e050513          	addi	a0,a0,1248 # 9f0 <digits>
 518:	883a                	mv	a6,a4
 51a:	2705                	addiw	a4,a4,1
 51c:	02c5f7bb          	remuw	a5,a1,a2
 520:	1782                	slli	a5,a5,0x20
 522:	9381                	srli	a5,a5,0x20
 524:	97aa                	add	a5,a5,a0
 526:	0007c783          	lbu	a5,0(a5)
 52a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 52e:	0005879b          	sext.w	a5,a1
 532:	02c5d5bb          	divuw	a1,a1,a2
 536:	0685                	addi	a3,a3,1
 538:	fec7f0e3          	bgeu	a5,a2,518 <printint+0x2a>
  if(neg)
 53c:	00088c63          	beqz	a7,554 <printint+0x66>
    buf[i++] = '-';
 540:	fd070793          	addi	a5,a4,-48
 544:	00878733          	add	a4,a5,s0
 548:	02d00793          	li	a5,45
 54c:	fef70823          	sb	a5,-16(a4)
 550:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 554:	02e05863          	blez	a4,584 <printint+0x96>
 558:	fc040793          	addi	a5,s0,-64
 55c:	00e78933          	add	s2,a5,a4
 560:	fff78993          	addi	s3,a5,-1
 564:	99ba                	add	s3,s3,a4
 566:	377d                	addiw	a4,a4,-1
 568:	1702                	slli	a4,a4,0x20
 56a:	9301                	srli	a4,a4,0x20
 56c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 570:	fff94583          	lbu	a1,-1(s2)
 574:	8526                	mv	a0,s1
 576:	00000097          	auipc	ra,0x0
 57a:	f56080e7          	jalr	-170(ra) # 4cc <putc>
  while(--i >= 0)
 57e:	197d                	addi	s2,s2,-1
 580:	ff3918e3          	bne	s2,s3,570 <printint+0x82>
}
 584:	70e2                	ld	ra,56(sp)
 586:	7442                	ld	s0,48(sp)
 588:	74a2                	ld	s1,40(sp)
 58a:	7902                	ld	s2,32(sp)
 58c:	69e2                	ld	s3,24(sp)
 58e:	6121                	addi	sp,sp,64
 590:	8082                	ret
    x = -xx;
 592:	40b005bb          	negw	a1,a1
    neg = 1;
 596:	4885                	li	a7,1
    x = -xx;
 598:	bf85                	j	508 <printint+0x1a>

000000000000059a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 59a:	7119                	addi	sp,sp,-128
 59c:	fc86                	sd	ra,120(sp)
 59e:	f8a2                	sd	s0,112(sp)
 5a0:	f4a6                	sd	s1,104(sp)
 5a2:	f0ca                	sd	s2,96(sp)
 5a4:	ecce                	sd	s3,88(sp)
 5a6:	e8d2                	sd	s4,80(sp)
 5a8:	e4d6                	sd	s5,72(sp)
 5aa:	e0da                	sd	s6,64(sp)
 5ac:	fc5e                	sd	s7,56(sp)
 5ae:	f862                	sd	s8,48(sp)
 5b0:	f466                	sd	s9,40(sp)
 5b2:	f06a                	sd	s10,32(sp)
 5b4:	ec6e                	sd	s11,24(sp)
 5b6:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5b8:	0005c903          	lbu	s2,0(a1)
 5bc:	18090f63          	beqz	s2,75a <vprintf+0x1c0>
 5c0:	8aaa                	mv	s5,a0
 5c2:	8b32                	mv	s6,a2
 5c4:	00158493          	addi	s1,a1,1
  state = 0;
 5c8:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5ca:	02500a13          	li	s4,37
 5ce:	4c55                	li	s8,21
 5d0:	00000c97          	auipc	s9,0x0
 5d4:	3c8c8c93          	addi	s9,s9,968 # 998 <malloc+0x13a>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5d8:	02800d93          	li	s11,40
  putc(fd, 'x');
 5dc:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5de:	00000b97          	auipc	s7,0x0
 5e2:	412b8b93          	addi	s7,s7,1042 # 9f0 <digits>
 5e6:	a839                	j	604 <vprintf+0x6a>
        putc(fd, c);
 5e8:	85ca                	mv	a1,s2
 5ea:	8556                	mv	a0,s5
 5ec:	00000097          	auipc	ra,0x0
 5f0:	ee0080e7          	jalr	-288(ra) # 4cc <putc>
 5f4:	a019                	j	5fa <vprintf+0x60>
    } else if(state == '%'){
 5f6:	01498d63          	beq	s3,s4,610 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 5fa:	0485                	addi	s1,s1,1
 5fc:	fff4c903          	lbu	s2,-1(s1)
 600:	14090d63          	beqz	s2,75a <vprintf+0x1c0>
    if(state == 0){
 604:	fe0999e3          	bnez	s3,5f6 <vprintf+0x5c>
      if(c == '%'){
 608:	ff4910e3          	bne	s2,s4,5e8 <vprintf+0x4e>
        state = '%';
 60c:	89d2                	mv	s3,s4
 60e:	b7f5                	j	5fa <vprintf+0x60>
      if(c == 'd'){
 610:	11490c63          	beq	s2,s4,728 <vprintf+0x18e>
 614:	f9d9079b          	addiw	a5,s2,-99
 618:	0ff7f793          	zext.b	a5,a5
 61c:	10fc6e63          	bltu	s8,a5,738 <vprintf+0x19e>
 620:	f9d9079b          	addiw	a5,s2,-99
 624:	0ff7f713          	zext.b	a4,a5
 628:	10ec6863          	bltu	s8,a4,738 <vprintf+0x19e>
 62c:	00271793          	slli	a5,a4,0x2
 630:	97e6                	add	a5,a5,s9
 632:	439c                	lw	a5,0(a5)
 634:	97e6                	add	a5,a5,s9
 636:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 638:	008b0913          	addi	s2,s6,8
 63c:	4685                	li	a3,1
 63e:	4629                	li	a2,10
 640:	000b2583          	lw	a1,0(s6)
 644:	8556                	mv	a0,s5
 646:	00000097          	auipc	ra,0x0
 64a:	ea8080e7          	jalr	-344(ra) # 4ee <printint>
 64e:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 650:	4981                	li	s3,0
 652:	b765                	j	5fa <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 654:	008b0913          	addi	s2,s6,8
 658:	4681                	li	a3,0
 65a:	4629                	li	a2,10
 65c:	000b2583          	lw	a1,0(s6)
 660:	8556                	mv	a0,s5
 662:	00000097          	auipc	ra,0x0
 666:	e8c080e7          	jalr	-372(ra) # 4ee <printint>
 66a:	8b4a                	mv	s6,s2
      state = 0;
 66c:	4981                	li	s3,0
 66e:	b771                	j	5fa <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 670:	008b0913          	addi	s2,s6,8
 674:	4681                	li	a3,0
 676:	866a                	mv	a2,s10
 678:	000b2583          	lw	a1,0(s6)
 67c:	8556                	mv	a0,s5
 67e:	00000097          	auipc	ra,0x0
 682:	e70080e7          	jalr	-400(ra) # 4ee <printint>
 686:	8b4a                	mv	s6,s2
      state = 0;
 688:	4981                	li	s3,0
 68a:	bf85                	j	5fa <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 68c:	008b0793          	addi	a5,s6,8
 690:	f8f43423          	sd	a5,-120(s0)
 694:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 698:	03000593          	li	a1,48
 69c:	8556                	mv	a0,s5
 69e:	00000097          	auipc	ra,0x0
 6a2:	e2e080e7          	jalr	-466(ra) # 4cc <putc>
  putc(fd, 'x');
 6a6:	07800593          	li	a1,120
 6aa:	8556                	mv	a0,s5
 6ac:	00000097          	auipc	ra,0x0
 6b0:	e20080e7          	jalr	-480(ra) # 4cc <putc>
 6b4:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6b6:	03c9d793          	srli	a5,s3,0x3c
 6ba:	97de                	add	a5,a5,s7
 6bc:	0007c583          	lbu	a1,0(a5)
 6c0:	8556                	mv	a0,s5
 6c2:	00000097          	auipc	ra,0x0
 6c6:	e0a080e7          	jalr	-502(ra) # 4cc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6ca:	0992                	slli	s3,s3,0x4
 6cc:	397d                	addiw	s2,s2,-1
 6ce:	fe0914e3          	bnez	s2,6b6 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 6d2:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 6d6:	4981                	li	s3,0
 6d8:	b70d                	j	5fa <vprintf+0x60>
        s = va_arg(ap, char*);
 6da:	008b0913          	addi	s2,s6,8
 6de:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 6e2:	02098163          	beqz	s3,704 <vprintf+0x16a>
        while(*s != 0){
 6e6:	0009c583          	lbu	a1,0(s3)
 6ea:	c5ad                	beqz	a1,754 <vprintf+0x1ba>
          putc(fd, *s);
 6ec:	8556                	mv	a0,s5
 6ee:	00000097          	auipc	ra,0x0
 6f2:	dde080e7          	jalr	-546(ra) # 4cc <putc>
          s++;
 6f6:	0985                	addi	s3,s3,1
        while(*s != 0){
 6f8:	0009c583          	lbu	a1,0(s3)
 6fc:	f9e5                	bnez	a1,6ec <vprintf+0x152>
        s = va_arg(ap, char*);
 6fe:	8b4a                	mv	s6,s2
      state = 0;
 700:	4981                	li	s3,0
 702:	bde5                	j	5fa <vprintf+0x60>
          s = "(null)";
 704:	00000997          	auipc	s3,0x0
 708:	28c98993          	addi	s3,s3,652 # 990 <malloc+0x132>
        while(*s != 0){
 70c:	85ee                	mv	a1,s11
 70e:	bff9                	j	6ec <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 710:	008b0913          	addi	s2,s6,8
 714:	000b4583          	lbu	a1,0(s6)
 718:	8556                	mv	a0,s5
 71a:	00000097          	auipc	ra,0x0
 71e:	db2080e7          	jalr	-590(ra) # 4cc <putc>
 722:	8b4a                	mv	s6,s2
      state = 0;
 724:	4981                	li	s3,0
 726:	bdd1                	j	5fa <vprintf+0x60>
        putc(fd, c);
 728:	85d2                	mv	a1,s4
 72a:	8556                	mv	a0,s5
 72c:	00000097          	auipc	ra,0x0
 730:	da0080e7          	jalr	-608(ra) # 4cc <putc>
      state = 0;
 734:	4981                	li	s3,0
 736:	b5d1                	j	5fa <vprintf+0x60>
        putc(fd, '%');
 738:	85d2                	mv	a1,s4
 73a:	8556                	mv	a0,s5
 73c:	00000097          	auipc	ra,0x0
 740:	d90080e7          	jalr	-624(ra) # 4cc <putc>
        putc(fd, c);
 744:	85ca                	mv	a1,s2
 746:	8556                	mv	a0,s5
 748:	00000097          	auipc	ra,0x0
 74c:	d84080e7          	jalr	-636(ra) # 4cc <putc>
      state = 0;
 750:	4981                	li	s3,0
 752:	b565                	j	5fa <vprintf+0x60>
        s = va_arg(ap, char*);
 754:	8b4a                	mv	s6,s2
      state = 0;
 756:	4981                	li	s3,0
 758:	b54d                	j	5fa <vprintf+0x60>
    }
  }
}
 75a:	70e6                	ld	ra,120(sp)
 75c:	7446                	ld	s0,112(sp)
 75e:	74a6                	ld	s1,104(sp)
 760:	7906                	ld	s2,96(sp)
 762:	69e6                	ld	s3,88(sp)
 764:	6a46                	ld	s4,80(sp)
 766:	6aa6                	ld	s5,72(sp)
 768:	6b06                	ld	s6,64(sp)
 76a:	7be2                	ld	s7,56(sp)
 76c:	7c42                	ld	s8,48(sp)
 76e:	7ca2                	ld	s9,40(sp)
 770:	7d02                	ld	s10,32(sp)
 772:	6de2                	ld	s11,24(sp)
 774:	6109                	addi	sp,sp,128
 776:	8082                	ret

0000000000000778 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 778:	715d                	addi	sp,sp,-80
 77a:	ec06                	sd	ra,24(sp)
 77c:	e822                	sd	s0,16(sp)
 77e:	1000                	addi	s0,sp,32
 780:	e010                	sd	a2,0(s0)
 782:	e414                	sd	a3,8(s0)
 784:	e818                	sd	a4,16(s0)
 786:	ec1c                	sd	a5,24(s0)
 788:	03043023          	sd	a6,32(s0)
 78c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 790:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 794:	8622                	mv	a2,s0
 796:	00000097          	auipc	ra,0x0
 79a:	e04080e7          	jalr	-508(ra) # 59a <vprintf>
}
 79e:	60e2                	ld	ra,24(sp)
 7a0:	6442                	ld	s0,16(sp)
 7a2:	6161                	addi	sp,sp,80
 7a4:	8082                	ret

00000000000007a6 <printf>:

void
printf(const char *fmt, ...)
{
 7a6:	711d                	addi	sp,sp,-96
 7a8:	ec06                	sd	ra,24(sp)
 7aa:	e822                	sd	s0,16(sp)
 7ac:	1000                	addi	s0,sp,32
 7ae:	e40c                	sd	a1,8(s0)
 7b0:	e810                	sd	a2,16(s0)
 7b2:	ec14                	sd	a3,24(s0)
 7b4:	f018                	sd	a4,32(s0)
 7b6:	f41c                	sd	a5,40(s0)
 7b8:	03043823          	sd	a6,48(s0)
 7bc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7c0:	00840613          	addi	a2,s0,8
 7c4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7c8:	85aa                	mv	a1,a0
 7ca:	4505                	li	a0,1
 7cc:	00000097          	auipc	ra,0x0
 7d0:	dce080e7          	jalr	-562(ra) # 59a <vprintf>
}
 7d4:	60e2                	ld	ra,24(sp)
 7d6:	6442                	ld	s0,16(sp)
 7d8:	6125                	addi	sp,sp,96
 7da:	8082                	ret

00000000000007dc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7dc:	1141                	addi	sp,sp,-16
 7de:	e422                	sd	s0,8(sp)
 7e0:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7e2:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e6:	00001797          	auipc	a5,0x1
 7ea:	81a7b783          	ld	a5,-2022(a5) # 1000 <freep>
 7ee:	a02d                	j	818 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7f0:	4618                	lw	a4,8(a2)
 7f2:	9f2d                	addw	a4,a4,a1
 7f4:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7f8:	6398                	ld	a4,0(a5)
 7fa:	6310                	ld	a2,0(a4)
 7fc:	a83d                	j	83a <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7fe:	ff852703          	lw	a4,-8(a0)
 802:	9f31                	addw	a4,a4,a2
 804:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 806:	ff053683          	ld	a3,-16(a0)
 80a:	a091                	j	84e <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 80c:	6398                	ld	a4,0(a5)
 80e:	00e7e463          	bltu	a5,a4,816 <free+0x3a>
 812:	00e6ea63          	bltu	a3,a4,826 <free+0x4a>
{
 816:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 818:	fed7fae3          	bgeu	a5,a3,80c <free+0x30>
 81c:	6398                	ld	a4,0(a5)
 81e:	00e6e463          	bltu	a3,a4,826 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 822:	fee7eae3          	bltu	a5,a4,816 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 826:	ff852583          	lw	a1,-8(a0)
 82a:	6390                	ld	a2,0(a5)
 82c:	02059813          	slli	a6,a1,0x20
 830:	01c85713          	srli	a4,a6,0x1c
 834:	9736                	add	a4,a4,a3
 836:	fae60de3          	beq	a2,a4,7f0 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 83a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 83e:	4790                	lw	a2,8(a5)
 840:	02061593          	slli	a1,a2,0x20
 844:	01c5d713          	srli	a4,a1,0x1c
 848:	973e                	add	a4,a4,a5
 84a:	fae68ae3          	beq	a3,a4,7fe <free+0x22>
    p->s.ptr = bp->s.ptr;
 84e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 850:	00000717          	auipc	a4,0x0
 854:	7af73823          	sd	a5,1968(a4) # 1000 <freep>
}
 858:	6422                	ld	s0,8(sp)
 85a:	0141                	addi	sp,sp,16
 85c:	8082                	ret

000000000000085e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 85e:	7139                	addi	sp,sp,-64
 860:	fc06                	sd	ra,56(sp)
 862:	f822                	sd	s0,48(sp)
 864:	f426                	sd	s1,40(sp)
 866:	f04a                	sd	s2,32(sp)
 868:	ec4e                	sd	s3,24(sp)
 86a:	e852                	sd	s4,16(sp)
 86c:	e456                	sd	s5,8(sp)
 86e:	e05a                	sd	s6,0(sp)
 870:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 872:	02051493          	slli	s1,a0,0x20
 876:	9081                	srli	s1,s1,0x20
 878:	04bd                	addi	s1,s1,15
 87a:	8091                	srli	s1,s1,0x4
 87c:	0014899b          	addiw	s3,s1,1
 880:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 882:	00000517          	auipc	a0,0x0
 886:	77e53503          	ld	a0,1918(a0) # 1000 <freep>
 88a:	c515                	beqz	a0,8b6 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 88c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 88e:	4798                	lw	a4,8(a5)
 890:	02977f63          	bgeu	a4,s1,8ce <malloc+0x70>
 894:	8a4e                	mv	s4,s3
 896:	0009871b          	sext.w	a4,s3
 89a:	6685                	lui	a3,0x1
 89c:	00d77363          	bgeu	a4,a3,8a2 <malloc+0x44>
 8a0:	6a05                	lui	s4,0x1
 8a2:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8a6:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8aa:	00000917          	auipc	s2,0x0
 8ae:	75690913          	addi	s2,s2,1878 # 1000 <freep>
  if(p == (char*)-1)
 8b2:	5afd                	li	s5,-1
 8b4:	a895                	j	928 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 8b6:	00000797          	auipc	a5,0x0
 8ba:	75a78793          	addi	a5,a5,1882 # 1010 <base>
 8be:	00000717          	auipc	a4,0x0
 8c2:	74f73123          	sd	a5,1858(a4) # 1000 <freep>
 8c6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8c8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8cc:	b7e1                	j	894 <malloc+0x36>
      if(p->s.size == nunits)
 8ce:	02e48c63          	beq	s1,a4,906 <malloc+0xa8>
        p->s.size -= nunits;
 8d2:	4137073b          	subw	a4,a4,s3
 8d6:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8d8:	02071693          	slli	a3,a4,0x20
 8dc:	01c6d713          	srli	a4,a3,0x1c
 8e0:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8e2:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8e6:	00000717          	auipc	a4,0x0
 8ea:	70a73d23          	sd	a0,1818(a4) # 1000 <freep>
      return (void*)(p + 1);
 8ee:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8f2:	70e2                	ld	ra,56(sp)
 8f4:	7442                	ld	s0,48(sp)
 8f6:	74a2                	ld	s1,40(sp)
 8f8:	7902                	ld	s2,32(sp)
 8fa:	69e2                	ld	s3,24(sp)
 8fc:	6a42                	ld	s4,16(sp)
 8fe:	6aa2                	ld	s5,8(sp)
 900:	6b02                	ld	s6,0(sp)
 902:	6121                	addi	sp,sp,64
 904:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 906:	6398                	ld	a4,0(a5)
 908:	e118                	sd	a4,0(a0)
 90a:	bff1                	j	8e6 <malloc+0x88>
  hp->s.size = nu;
 90c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 910:	0541                	addi	a0,a0,16
 912:	00000097          	auipc	ra,0x0
 916:	eca080e7          	jalr	-310(ra) # 7dc <free>
  return freep;
 91a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 91e:	d971                	beqz	a0,8f2 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 920:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 922:	4798                	lw	a4,8(a5)
 924:	fa9775e3          	bgeu	a4,s1,8ce <malloc+0x70>
    if(p == freep)
 928:	00093703          	ld	a4,0(s2)
 92c:	853e                	mv	a0,a5
 92e:	fef719e3          	bne	a4,a5,920 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 932:	8552                	mv	a0,s4
 934:	00000097          	auipc	ra,0x0
 938:	b78080e7          	jalr	-1160(ra) # 4ac <sbrk>
  if(p == (char*)-1)
 93c:	fd5518e3          	bne	a0,s5,90c <malloc+0xae>
        return 0;
 940:	4501                	li	a0,0
 942:	bf45                	j	8f2 <malloc+0x94>
