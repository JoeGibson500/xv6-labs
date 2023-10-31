
user/_my_shell:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <readLine>:
    - read in user input 
    - return 1 when 
*/
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
  16:	93e58593          	addi	a1,a1,-1730 # 950 <malloc+0xf0>
  1a:	4509                	li	a0,2
  1c:	00000097          	auipc	ra,0x0
  20:	42a080e7          	jalr	1066(ra) # 446 <write>

    //read input from user
    gets(buffer, bufferSize);
  24:	85ca                	mv	a1,s2
  26:	8526                	mv	a0,s1
  28:	00000097          	auipc	ra,0x0
  2c:	24a080e7          	jalr	586(ra) # 272 <gets>


    //if the user just presses enter, exit function (this is so it is called again in the while loop so that the command prompt will be printed agaim)
    if (strlen(buffer) == 1)
  30:	8526                	mv	a0,s1
  32:	00000097          	auipc	ra,0x0
  36:	1d0080e7          	jalr	464(ra) # 202 <strlen>
  3a:	2501                	sext.w	a0,a0
  3c:	4785                	li	a5,1
  3e:	02f50763          	beq	a0,a5,6c <readLine+0x6c>
            buffer[i] = '\0';
            return 1;

        }
    }
    return 0;
  42:	4501                	li	a0,0
    for (int i=0; i<bufferSize; i++)
  44:	05205363          	blez	s2,8a <readLine+0x8a>
  48:	87a6                	mv	a5,s1
  4a:	00148713          	addi	a4,s1,1
  4e:	397d                	addiw	s2,s2,-1
  50:	1902                	slli	s2,s2,0x20
  52:	02095913          	srli	s2,s2,0x20
  56:	974a                	add	a4,a4,s2
        if (buffer[i] == '\n')
  58:	4629                	li	a2,10
  5a:	0007c683          	lbu	a3,0(a5)
  5e:	02c68363          	beq	a3,a2,84 <readLine+0x84>
    for (int i=0; i<bufferSize; i++)
  62:	0785                	addi	a5,a5,1
  64:	fee79be3          	bne	a5,a4,5a <readLine+0x5a>
    return 0;
  68:	4501                	li	a0,0
  6a:	a005                	j	8a <readLine+0x8a>
        write(2, "\n", 2);
  6c:	4609                	li	a2,2
  6e:	00001597          	auipc	a1,0x1
  72:	8ea58593          	addi	a1,a1,-1814 # 958 <malloc+0xf8>
  76:	4509                	li	a0,2
  78:	00000097          	auipc	ra,0x0
  7c:	3ce080e7          	jalr	974(ra) # 446 <write>
        return 0;
  80:	4501                	li	a0,0
  82:	a021                	j	8a <readLine+0x8a>
            buffer[i] = '\0';
  84:	00078023          	sb	zero,0(a5)
            return 1;
  88:	4505                	li	a0,1
}
  8a:	60e2                	ld	ra,24(sp)
  8c:	6442                	ld	s0,16(sp)
  8e:	64a2                	ld	s1,8(sp)
  90:	6902                	ld	s2,0(sp)
  92:	6105                	addi	sp,sp,32
  94:	8082                	ret

0000000000000096 <formatLine>:

void
formatLine(char *buffer, char *args[])
{
  96:	1101                	addi	sp,sp,-32
  98:	ec06                	sd	ra,24(sp)
  9a:	e822                	sd	s0,16(sp)
  9c:	e426                	sd	s1,8(sp)
  9e:	e04a                	sd	s2,0(sp)
  a0:	1000                	addi	s0,sp,32
  a2:	84aa                	mv	s1,a0
  a4:	892e                	mv	s2,a1

    int pid = fork();
  a6:	00000097          	auipc	ra,0x0
  aa:	378080e7          	jalr	888(ra) # 41e <fork>
    if (pid < 0)
  ae:	00054c63          	bltz	a0,c6 <formatLine+0x30>
    {
        printf("Fork failed");
        exit(1);
    } else if(pid == 0)
  b2:	e13d                	bnez	a0,118 <formatLine+0x82>

        argumentPointer = &args[0];

        //set buffer pointer to start of buffer
        bufferPointer = buffer;
        while (*bufferPointer != '\0') {
  b4:	0004c783          	lbu	a5,0(s1)
  b8:	c3b9                	beqz	a5,fe <formatLine+0x68>
        argumentPointer = &args[0];
  ba:	864a                	mv	a2,s2
        int wordstart = 1;
  bc:	4705                	li	a4,1
            if (*bufferPointer != ' ') 
  be:	02000693          	li	a3,32
                // the pointer a is then incremented to point ot the next element in the args array,
                // preparing it to store the address of the next word. 
                argumentPointer++;

                //ws is set to 1 indicating the whitespace has started, as we're in the space between words.
                wordstart = 1;
  c2:	4585                	li	a1,1
  c4:	a03d                	j	f2 <formatLine+0x5c>
        printf("Fork failed");
  c6:	00001517          	auipc	a0,0x1
  ca:	89a50513          	addi	a0,a0,-1894 # 960 <malloc+0x100>
  ce:	00000097          	auipc	ra,0x0
  d2:	6da080e7          	jalr	1754(ra) # 7a8 <printf>
        exit(1);
  d6:	4505                	li	a0,1
  d8:	00000097          	auipc	ra,0x0
  dc:	34e080e7          	jalr	846(ra) # 426 <exit>
                if (!wordstart) 
  e0:	e709                	bnez	a4,ea <formatLine+0x54>
                *bufferPointer = '\0';
  e2:	00048023          	sb	zero,0(s1)
                argumentPointer++;
  e6:	0621                	addi	a2,a2,8
                wordstart = 1;
  e8:	872e                	mv	a4,a1
                }
            }

        // pointer b is moved to the next character in the line, and the process continues for the next character
        bufferPointer++;
  ea:	0485                	addi	s1,s1,1
        while (*bufferPointer != '\0') {
  ec:	0004c783          	lbu	a5,0(s1)
  f0:	c799                	beqz	a5,fe <formatLine+0x68>
            if (*bufferPointer != ' ') 
  f2:	fed787e3          	beq	a5,a3,e0 <formatLine+0x4a>
                if (wordstart)
  f6:	db75                	beqz	a4,ea <formatLine+0x54>
                    *argumentPointer = bufferPointer;
  f8:	e204                	sd	s1,0(a2)
                    wordstart = 0;
  fa:	872a                	mv	a4,a0
  fc:	b7fd                	j	ea <formatLine+0x54>
        }
        // At this point args stores pointers to the original
        // command passed to xargs plus pointers to any inputs from
        // the standard input. Execute the command.
        exec(args[0], args);
  fe:	85ca                	mv	a1,s2
 100:	00093503          	ld	a0,0(s2)
 104:	00000097          	auipc	ra,0x0
 108:	35a080e7          	jalr	858(ra) # 45e <exec>
        
    } else // parent
        wait(0);
}
 10c:	60e2                	ld	ra,24(sp)
 10e:	6442                	ld	s0,16(sp)
 110:	64a2                	ld	s1,8(sp)
 112:	6902                	ld	s2,0(sp)
 114:	6105                	addi	sp,sp,32
 116:	8082                	ret
        wait(0);
 118:	4501                	li	a0,0
 11a:	00000097          	auipc	ra,0x0
 11e:	314080e7          	jalr	788(ra) # 42e <wait>
}
 122:	b7ed                	j	10c <formatLine+0x76>

0000000000000124 <cd>:

//function to change directory
void
cd(char *path)
{
 124:	1101                	addi	sp,sp,-32
 126:	ec06                	sd	ra,24(sp)
 128:	e822                	sd	s0,16(sp)
 12a:	e426                	sd	s1,8(sp)
 12c:	1000                	addi	s0,sp,32
 12e:	84aa                	mv	s1,a0
    if(chdir(path) < 0)
 130:	00000097          	auipc	ra,0x0
 134:	366080e7          	jalr	870(ra) # 496 <chdir>
 138:	00054763          	bltz	a0,146 <cd+0x22>
    {
        printf("cd: Error. Cannot cd to %s\n", path);
    }

}
 13c:	60e2                	ld	ra,24(sp)
 13e:	6442                	ld	s0,16(sp)
 140:	64a2                	ld	s1,8(sp)
 142:	6105                	addi	sp,sp,32
 144:	8082                	ret
        printf("cd: Error. Cannot cd to %s\n", path);
 146:	85a6                	mv	a1,s1
 148:	00001517          	auipc	a0,0x1
 14c:	82850513          	addi	a0,a0,-2008 # 970 <malloc+0x110>
 150:	00000097          	auipc	ra,0x0
 154:	658080e7          	jalr	1624(ra) # 7a8 <printf>
}
 158:	b7d5                	j	13c <cd+0x18>

000000000000015a <main>:

int 
main(int argc, char *argv[]) 
{
 15a:	712d                	addi	sp,sp,-288
 15c:	ee06                	sd	ra,280(sp)
 15e:	ea22                	sd	s0,272(sp)
 160:	e626                	sd	s1,264(sp)
 162:	e24a                	sd	s2,256(sp)
 164:	1200                	addi	s0,sp,288

    //create a buffer that we will read into and declare a constant size
    const int BUFSIZE = 512;
    char buffer[BUFSIZE];    
 166:	7101                	addi	sp,sp,-512
 168:	848a                	mv	s1,sp

    //initialize argument array that will store arguments after tokenized
    //set all elements to null
    char* args[MAXARG] = { 0 };
 16a:	10000613          	li	a2,256
 16e:	4581                	li	a1,0
 170:	ee040513          	addi	a0,s0,-288
 174:	00000097          	auipc	ra,0x0
 178:	0b8080e7          	jalr	184(ra) # 22c <memset>

    //display command prompt indefinitely 
    while (1)
    {
        //readLine will return 1 when it replaces the newline character with a null terminating character
        if (readLine(buffer, BUFSIZE) == 1)
 17c:	4905                	li	s2,1
 17e:	20000593          	li	a1,512
 182:	8526                	mv	a0,s1
 184:	00000097          	auipc	ra,0x0
 188:	e7c080e7          	jalr	-388(ra) # 0 <readLine>
 18c:	ff2519e3          	bne	a0,s2,17e <main+0x24>
        {

            formatLine(buffer, args);
 190:	ee040593          	addi	a1,s0,-288
 194:	8526                	mv	a0,s1
 196:	00000097          	auipc	ra,0x0
 19a:	f00080e7          	jalr	-256(ra) # 96 <formatLine>
 19e:	b7c5                	j	17e <main+0x24>

00000000000001a0 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 1a0:	1141                	addi	sp,sp,-16
 1a2:	e406                	sd	ra,8(sp)
 1a4:	e022                	sd	s0,0(sp)
 1a6:	0800                	addi	s0,sp,16
  extern int main();
  main();
 1a8:	00000097          	auipc	ra,0x0
 1ac:	fb2080e7          	jalr	-78(ra) # 15a <main>
  exit(0);
 1b0:	4501                	li	a0,0
 1b2:	00000097          	auipc	ra,0x0
 1b6:	274080e7          	jalr	628(ra) # 426 <exit>

00000000000001ba <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 1ba:	1141                	addi	sp,sp,-16
 1bc:	e422                	sd	s0,8(sp)
 1be:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1c0:	87aa                	mv	a5,a0
 1c2:	0585                	addi	a1,a1,1
 1c4:	0785                	addi	a5,a5,1
 1c6:	fff5c703          	lbu	a4,-1(a1)
 1ca:	fee78fa3          	sb	a4,-1(a5)
 1ce:	fb75                	bnez	a4,1c2 <strcpy+0x8>
    ;
  return os;
}
 1d0:	6422                	ld	s0,8(sp)
 1d2:	0141                	addi	sp,sp,16
 1d4:	8082                	ret

00000000000001d6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1d6:	1141                	addi	sp,sp,-16
 1d8:	e422                	sd	s0,8(sp)
 1da:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1dc:	00054783          	lbu	a5,0(a0)
 1e0:	cb91                	beqz	a5,1f4 <strcmp+0x1e>
 1e2:	0005c703          	lbu	a4,0(a1)
 1e6:	00f71763          	bne	a4,a5,1f4 <strcmp+0x1e>
    p++, q++;
 1ea:	0505                	addi	a0,a0,1
 1ec:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1ee:	00054783          	lbu	a5,0(a0)
 1f2:	fbe5                	bnez	a5,1e2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1f4:	0005c503          	lbu	a0,0(a1)
}
 1f8:	40a7853b          	subw	a0,a5,a0
 1fc:	6422                	ld	s0,8(sp)
 1fe:	0141                	addi	sp,sp,16
 200:	8082                	ret

0000000000000202 <strlen>:

uint
strlen(const char *s)
{
 202:	1141                	addi	sp,sp,-16
 204:	e422                	sd	s0,8(sp)
 206:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 208:	00054783          	lbu	a5,0(a0)
 20c:	cf91                	beqz	a5,228 <strlen+0x26>
 20e:	0505                	addi	a0,a0,1
 210:	87aa                	mv	a5,a0
 212:	4685                	li	a3,1
 214:	9e89                	subw	a3,a3,a0
 216:	00f6853b          	addw	a0,a3,a5
 21a:	0785                	addi	a5,a5,1
 21c:	fff7c703          	lbu	a4,-1(a5)
 220:	fb7d                	bnez	a4,216 <strlen+0x14>
    ;
  return n;
}
 222:	6422                	ld	s0,8(sp)
 224:	0141                	addi	sp,sp,16
 226:	8082                	ret
  for(n = 0; s[n]; n++)
 228:	4501                	li	a0,0
 22a:	bfe5                	j	222 <strlen+0x20>

000000000000022c <memset>:

void*
memset(void *dst, int c, uint n)
{
 22c:	1141                	addi	sp,sp,-16
 22e:	e422                	sd	s0,8(sp)
 230:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 232:	ca19                	beqz	a2,248 <memset+0x1c>
 234:	87aa                	mv	a5,a0
 236:	1602                	slli	a2,a2,0x20
 238:	9201                	srli	a2,a2,0x20
 23a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 23e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 242:	0785                	addi	a5,a5,1
 244:	fee79de3          	bne	a5,a4,23e <memset+0x12>
  }
  return dst;
}
 248:	6422                	ld	s0,8(sp)
 24a:	0141                	addi	sp,sp,16
 24c:	8082                	ret

000000000000024e <strchr>:

char*
strchr(const char *s, char c)
{
 24e:	1141                	addi	sp,sp,-16
 250:	e422                	sd	s0,8(sp)
 252:	0800                	addi	s0,sp,16
  for(; *s; s++)
 254:	00054783          	lbu	a5,0(a0)
 258:	cb99                	beqz	a5,26e <strchr+0x20>
    if(*s == c)
 25a:	00f58763          	beq	a1,a5,268 <strchr+0x1a>
  for(; *s; s++)
 25e:	0505                	addi	a0,a0,1
 260:	00054783          	lbu	a5,0(a0)
 264:	fbfd                	bnez	a5,25a <strchr+0xc>
      return (char*)s;
  return 0;
 266:	4501                	li	a0,0
}
 268:	6422                	ld	s0,8(sp)
 26a:	0141                	addi	sp,sp,16
 26c:	8082                	ret
  return 0;
 26e:	4501                	li	a0,0
 270:	bfe5                	j	268 <strchr+0x1a>

0000000000000272 <gets>:

char*
gets(char *buf, int max)
{
 272:	711d                	addi	sp,sp,-96
 274:	ec86                	sd	ra,88(sp)
 276:	e8a2                	sd	s0,80(sp)
 278:	e4a6                	sd	s1,72(sp)
 27a:	e0ca                	sd	s2,64(sp)
 27c:	fc4e                	sd	s3,56(sp)
 27e:	f852                	sd	s4,48(sp)
 280:	f456                	sd	s5,40(sp)
 282:	f05a                	sd	s6,32(sp)
 284:	ec5e                	sd	s7,24(sp)
 286:	1080                	addi	s0,sp,96
 288:	8baa                	mv	s7,a0
 28a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 28c:	892a                	mv	s2,a0
 28e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 290:	4aa9                	li	s5,10
 292:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 294:	89a6                	mv	s3,s1
 296:	2485                	addiw	s1,s1,1
 298:	0344d863          	bge	s1,s4,2c8 <gets+0x56>
    cc = read(0, &c, 1);
 29c:	4605                	li	a2,1
 29e:	faf40593          	addi	a1,s0,-81
 2a2:	4501                	li	a0,0
 2a4:	00000097          	auipc	ra,0x0
 2a8:	19a080e7          	jalr	410(ra) # 43e <read>
    if(cc < 1)
 2ac:	00a05e63          	blez	a0,2c8 <gets+0x56>
    buf[i++] = c;
 2b0:	faf44783          	lbu	a5,-81(s0)
 2b4:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2b8:	01578763          	beq	a5,s5,2c6 <gets+0x54>
 2bc:	0905                	addi	s2,s2,1
 2be:	fd679be3          	bne	a5,s6,294 <gets+0x22>
  for(i=0; i+1 < max; ){
 2c2:	89a6                	mv	s3,s1
 2c4:	a011                	j	2c8 <gets+0x56>
 2c6:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2c8:	99de                	add	s3,s3,s7
 2ca:	00098023          	sb	zero,0(s3)
  return buf;
}
 2ce:	855e                	mv	a0,s7
 2d0:	60e6                	ld	ra,88(sp)
 2d2:	6446                	ld	s0,80(sp)
 2d4:	64a6                	ld	s1,72(sp)
 2d6:	6906                	ld	s2,64(sp)
 2d8:	79e2                	ld	s3,56(sp)
 2da:	7a42                	ld	s4,48(sp)
 2dc:	7aa2                	ld	s5,40(sp)
 2de:	7b02                	ld	s6,32(sp)
 2e0:	6be2                	ld	s7,24(sp)
 2e2:	6125                	addi	sp,sp,96
 2e4:	8082                	ret

00000000000002e6 <stat>:

int
stat(const char *n, struct stat *st)
{
 2e6:	1101                	addi	sp,sp,-32
 2e8:	ec06                	sd	ra,24(sp)
 2ea:	e822                	sd	s0,16(sp)
 2ec:	e426                	sd	s1,8(sp)
 2ee:	e04a                	sd	s2,0(sp)
 2f0:	1000                	addi	s0,sp,32
 2f2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2f4:	4581                	li	a1,0
 2f6:	00000097          	auipc	ra,0x0
 2fa:	170080e7          	jalr	368(ra) # 466 <open>
  if(fd < 0)
 2fe:	02054563          	bltz	a0,328 <stat+0x42>
 302:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 304:	85ca                	mv	a1,s2
 306:	00000097          	auipc	ra,0x0
 30a:	178080e7          	jalr	376(ra) # 47e <fstat>
 30e:	892a                	mv	s2,a0
  close(fd);
 310:	8526                	mv	a0,s1
 312:	00000097          	auipc	ra,0x0
 316:	13c080e7          	jalr	316(ra) # 44e <close>
  return r;
}
 31a:	854a                	mv	a0,s2
 31c:	60e2                	ld	ra,24(sp)
 31e:	6442                	ld	s0,16(sp)
 320:	64a2                	ld	s1,8(sp)
 322:	6902                	ld	s2,0(sp)
 324:	6105                	addi	sp,sp,32
 326:	8082                	ret
    return -1;
 328:	597d                	li	s2,-1
 32a:	bfc5                	j	31a <stat+0x34>

000000000000032c <atoi>:

int
atoi(const char *s)
{
 32c:	1141                	addi	sp,sp,-16
 32e:	e422                	sd	s0,8(sp)
 330:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 332:	00054683          	lbu	a3,0(a0)
 336:	fd06879b          	addiw	a5,a3,-48
 33a:	0ff7f793          	zext.b	a5,a5
 33e:	4625                	li	a2,9
 340:	02f66863          	bltu	a2,a5,370 <atoi+0x44>
 344:	872a                	mv	a4,a0
  n = 0;
 346:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 348:	0705                	addi	a4,a4,1
 34a:	0025179b          	slliw	a5,a0,0x2
 34e:	9fa9                	addw	a5,a5,a0
 350:	0017979b          	slliw	a5,a5,0x1
 354:	9fb5                	addw	a5,a5,a3
 356:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 35a:	00074683          	lbu	a3,0(a4)
 35e:	fd06879b          	addiw	a5,a3,-48
 362:	0ff7f793          	zext.b	a5,a5
 366:	fef671e3          	bgeu	a2,a5,348 <atoi+0x1c>
  return n;
}
 36a:	6422                	ld	s0,8(sp)
 36c:	0141                	addi	sp,sp,16
 36e:	8082                	ret
  n = 0;
 370:	4501                	li	a0,0
 372:	bfe5                	j	36a <atoi+0x3e>

0000000000000374 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 374:	1141                	addi	sp,sp,-16
 376:	e422                	sd	s0,8(sp)
 378:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 37a:	02b57463          	bgeu	a0,a1,3a2 <memmove+0x2e>
    while(n-- > 0)
 37e:	00c05f63          	blez	a2,39c <memmove+0x28>
 382:	1602                	slli	a2,a2,0x20
 384:	9201                	srli	a2,a2,0x20
 386:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 38a:	872a                	mv	a4,a0
      *dst++ = *src++;
 38c:	0585                	addi	a1,a1,1
 38e:	0705                	addi	a4,a4,1
 390:	fff5c683          	lbu	a3,-1(a1)
 394:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 398:	fee79ae3          	bne	a5,a4,38c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 39c:	6422                	ld	s0,8(sp)
 39e:	0141                	addi	sp,sp,16
 3a0:	8082                	ret
    dst += n;
 3a2:	00c50733          	add	a4,a0,a2
    src += n;
 3a6:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3a8:	fec05ae3          	blez	a2,39c <memmove+0x28>
 3ac:	fff6079b          	addiw	a5,a2,-1
 3b0:	1782                	slli	a5,a5,0x20
 3b2:	9381                	srli	a5,a5,0x20
 3b4:	fff7c793          	not	a5,a5
 3b8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3ba:	15fd                	addi	a1,a1,-1
 3bc:	177d                	addi	a4,a4,-1
 3be:	0005c683          	lbu	a3,0(a1)
 3c2:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3c6:	fee79ae3          	bne	a5,a4,3ba <memmove+0x46>
 3ca:	bfc9                	j	39c <memmove+0x28>

00000000000003cc <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3cc:	1141                	addi	sp,sp,-16
 3ce:	e422                	sd	s0,8(sp)
 3d0:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3d2:	ca05                	beqz	a2,402 <memcmp+0x36>
 3d4:	fff6069b          	addiw	a3,a2,-1
 3d8:	1682                	slli	a3,a3,0x20
 3da:	9281                	srli	a3,a3,0x20
 3dc:	0685                	addi	a3,a3,1
 3de:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3e0:	00054783          	lbu	a5,0(a0)
 3e4:	0005c703          	lbu	a4,0(a1)
 3e8:	00e79863          	bne	a5,a4,3f8 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3ec:	0505                	addi	a0,a0,1
    p2++;
 3ee:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3f0:	fed518e3          	bne	a0,a3,3e0 <memcmp+0x14>
  }
  return 0;
 3f4:	4501                	li	a0,0
 3f6:	a019                	j	3fc <memcmp+0x30>
      return *p1 - *p2;
 3f8:	40e7853b          	subw	a0,a5,a4
}
 3fc:	6422                	ld	s0,8(sp)
 3fe:	0141                	addi	sp,sp,16
 400:	8082                	ret
  return 0;
 402:	4501                	li	a0,0
 404:	bfe5                	j	3fc <memcmp+0x30>

0000000000000406 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 406:	1141                	addi	sp,sp,-16
 408:	e406                	sd	ra,8(sp)
 40a:	e022                	sd	s0,0(sp)
 40c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 40e:	00000097          	auipc	ra,0x0
 412:	f66080e7          	jalr	-154(ra) # 374 <memmove>
}
 416:	60a2                	ld	ra,8(sp)
 418:	6402                	ld	s0,0(sp)
 41a:	0141                	addi	sp,sp,16
 41c:	8082                	ret

000000000000041e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 41e:	4885                	li	a7,1
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <exit>:
.global exit
exit:
 li a7, SYS_exit
 426:	4889                	li	a7,2
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <wait>:
.global wait
wait:
 li a7, SYS_wait
 42e:	488d                	li	a7,3
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 436:	4891                	li	a7,4
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <read>:
.global read
read:
 li a7, SYS_read
 43e:	4895                	li	a7,5
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <write>:
.global write
write:
 li a7, SYS_write
 446:	48c1                	li	a7,16
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <close>:
.global close
close:
 li a7, SYS_close
 44e:	48d5                	li	a7,21
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <kill>:
.global kill
kill:
 li a7, SYS_kill
 456:	4899                	li	a7,6
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <exec>:
.global exec
exec:
 li a7, SYS_exec
 45e:	489d                	li	a7,7
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <open>:
.global open
open:
 li a7, SYS_open
 466:	48bd                	li	a7,15
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 46e:	48c5                	li	a7,17
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 476:	48c9                	li	a7,18
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 47e:	48a1                	li	a7,8
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <link>:
.global link
link:
 li a7, SYS_link
 486:	48cd                	li	a7,19
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 48e:	48d1                	li	a7,20
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 496:	48a5                	li	a7,9
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <dup>:
.global dup
dup:
 li a7, SYS_dup
 49e:	48a9                	li	a7,10
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4a6:	48ad                	li	a7,11
 ecall
 4a8:	00000073          	ecall
 ret
 4ac:	8082                	ret

00000000000004ae <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4ae:	48b1                	li	a7,12
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4b6:	48b5                	li	a7,13
 ecall
 4b8:	00000073          	ecall
 ret
 4bc:	8082                	ret

00000000000004be <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4be:	48b9                	li	a7,14
 ecall
 4c0:	00000073          	ecall
 ret
 4c4:	8082                	ret

00000000000004c6 <getyear>:
.global getyear
getyear:
 li a7, SYS_getyear
 4c6:	48d9                	li	a7,22
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4ce:	1101                	addi	sp,sp,-32
 4d0:	ec06                	sd	ra,24(sp)
 4d2:	e822                	sd	s0,16(sp)
 4d4:	1000                	addi	s0,sp,32
 4d6:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4da:	4605                	li	a2,1
 4dc:	fef40593          	addi	a1,s0,-17
 4e0:	00000097          	auipc	ra,0x0
 4e4:	f66080e7          	jalr	-154(ra) # 446 <write>
}
 4e8:	60e2                	ld	ra,24(sp)
 4ea:	6442                	ld	s0,16(sp)
 4ec:	6105                	addi	sp,sp,32
 4ee:	8082                	ret

00000000000004f0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4f0:	7139                	addi	sp,sp,-64
 4f2:	fc06                	sd	ra,56(sp)
 4f4:	f822                	sd	s0,48(sp)
 4f6:	f426                	sd	s1,40(sp)
 4f8:	f04a                	sd	s2,32(sp)
 4fa:	ec4e                	sd	s3,24(sp)
 4fc:	0080                	addi	s0,sp,64
 4fe:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 500:	c299                	beqz	a3,506 <printint+0x16>
 502:	0805c963          	bltz	a1,594 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 506:	2581                	sext.w	a1,a1
  neg = 0;
 508:	4881                	li	a7,0
 50a:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 50e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 510:	2601                	sext.w	a2,a2
 512:	00000517          	auipc	a0,0x0
 516:	4de50513          	addi	a0,a0,1246 # 9f0 <digits>
 51a:	883a                	mv	a6,a4
 51c:	2705                	addiw	a4,a4,1
 51e:	02c5f7bb          	remuw	a5,a1,a2
 522:	1782                	slli	a5,a5,0x20
 524:	9381                	srli	a5,a5,0x20
 526:	97aa                	add	a5,a5,a0
 528:	0007c783          	lbu	a5,0(a5)
 52c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 530:	0005879b          	sext.w	a5,a1
 534:	02c5d5bb          	divuw	a1,a1,a2
 538:	0685                	addi	a3,a3,1
 53a:	fec7f0e3          	bgeu	a5,a2,51a <printint+0x2a>
  if(neg)
 53e:	00088c63          	beqz	a7,556 <printint+0x66>
    buf[i++] = '-';
 542:	fd070793          	addi	a5,a4,-48
 546:	00878733          	add	a4,a5,s0
 54a:	02d00793          	li	a5,45
 54e:	fef70823          	sb	a5,-16(a4)
 552:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 556:	02e05863          	blez	a4,586 <printint+0x96>
 55a:	fc040793          	addi	a5,s0,-64
 55e:	00e78933          	add	s2,a5,a4
 562:	fff78993          	addi	s3,a5,-1
 566:	99ba                	add	s3,s3,a4
 568:	377d                	addiw	a4,a4,-1
 56a:	1702                	slli	a4,a4,0x20
 56c:	9301                	srli	a4,a4,0x20
 56e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 572:	fff94583          	lbu	a1,-1(s2)
 576:	8526                	mv	a0,s1
 578:	00000097          	auipc	ra,0x0
 57c:	f56080e7          	jalr	-170(ra) # 4ce <putc>
  while(--i >= 0)
 580:	197d                	addi	s2,s2,-1
 582:	ff3918e3          	bne	s2,s3,572 <printint+0x82>
}
 586:	70e2                	ld	ra,56(sp)
 588:	7442                	ld	s0,48(sp)
 58a:	74a2                	ld	s1,40(sp)
 58c:	7902                	ld	s2,32(sp)
 58e:	69e2                	ld	s3,24(sp)
 590:	6121                	addi	sp,sp,64
 592:	8082                	ret
    x = -xx;
 594:	40b005bb          	negw	a1,a1
    neg = 1;
 598:	4885                	li	a7,1
    x = -xx;
 59a:	bf85                	j	50a <printint+0x1a>

000000000000059c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 59c:	7119                	addi	sp,sp,-128
 59e:	fc86                	sd	ra,120(sp)
 5a0:	f8a2                	sd	s0,112(sp)
 5a2:	f4a6                	sd	s1,104(sp)
 5a4:	f0ca                	sd	s2,96(sp)
 5a6:	ecce                	sd	s3,88(sp)
 5a8:	e8d2                	sd	s4,80(sp)
 5aa:	e4d6                	sd	s5,72(sp)
 5ac:	e0da                	sd	s6,64(sp)
 5ae:	fc5e                	sd	s7,56(sp)
 5b0:	f862                	sd	s8,48(sp)
 5b2:	f466                	sd	s9,40(sp)
 5b4:	f06a                	sd	s10,32(sp)
 5b6:	ec6e                	sd	s11,24(sp)
 5b8:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5ba:	0005c903          	lbu	s2,0(a1)
 5be:	18090f63          	beqz	s2,75c <vprintf+0x1c0>
 5c2:	8aaa                	mv	s5,a0
 5c4:	8b32                	mv	s6,a2
 5c6:	00158493          	addi	s1,a1,1
  state = 0;
 5ca:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5cc:	02500a13          	li	s4,37
 5d0:	4c55                	li	s8,21
 5d2:	00000c97          	auipc	s9,0x0
 5d6:	3c6c8c93          	addi	s9,s9,966 # 998 <malloc+0x138>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5da:	02800d93          	li	s11,40
  putc(fd, 'x');
 5de:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5e0:	00000b97          	auipc	s7,0x0
 5e4:	410b8b93          	addi	s7,s7,1040 # 9f0 <digits>
 5e8:	a839                	j	606 <vprintf+0x6a>
        putc(fd, c);
 5ea:	85ca                	mv	a1,s2
 5ec:	8556                	mv	a0,s5
 5ee:	00000097          	auipc	ra,0x0
 5f2:	ee0080e7          	jalr	-288(ra) # 4ce <putc>
 5f6:	a019                	j	5fc <vprintf+0x60>
    } else if(state == '%'){
 5f8:	01498d63          	beq	s3,s4,612 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 5fc:	0485                	addi	s1,s1,1
 5fe:	fff4c903          	lbu	s2,-1(s1)
 602:	14090d63          	beqz	s2,75c <vprintf+0x1c0>
    if(state == 0){
 606:	fe0999e3          	bnez	s3,5f8 <vprintf+0x5c>
      if(c == '%'){
 60a:	ff4910e3          	bne	s2,s4,5ea <vprintf+0x4e>
        state = '%';
 60e:	89d2                	mv	s3,s4
 610:	b7f5                	j	5fc <vprintf+0x60>
      if(c == 'd'){
 612:	11490c63          	beq	s2,s4,72a <vprintf+0x18e>
 616:	f9d9079b          	addiw	a5,s2,-99
 61a:	0ff7f793          	zext.b	a5,a5
 61e:	10fc6e63          	bltu	s8,a5,73a <vprintf+0x19e>
 622:	f9d9079b          	addiw	a5,s2,-99
 626:	0ff7f713          	zext.b	a4,a5
 62a:	10ec6863          	bltu	s8,a4,73a <vprintf+0x19e>
 62e:	00271793          	slli	a5,a4,0x2
 632:	97e6                	add	a5,a5,s9
 634:	439c                	lw	a5,0(a5)
 636:	97e6                	add	a5,a5,s9
 638:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 63a:	008b0913          	addi	s2,s6,8
 63e:	4685                	li	a3,1
 640:	4629                	li	a2,10
 642:	000b2583          	lw	a1,0(s6)
 646:	8556                	mv	a0,s5
 648:	00000097          	auipc	ra,0x0
 64c:	ea8080e7          	jalr	-344(ra) # 4f0 <printint>
 650:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 652:	4981                	li	s3,0
 654:	b765                	j	5fc <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 656:	008b0913          	addi	s2,s6,8
 65a:	4681                	li	a3,0
 65c:	4629                	li	a2,10
 65e:	000b2583          	lw	a1,0(s6)
 662:	8556                	mv	a0,s5
 664:	00000097          	auipc	ra,0x0
 668:	e8c080e7          	jalr	-372(ra) # 4f0 <printint>
 66c:	8b4a                	mv	s6,s2
      state = 0;
 66e:	4981                	li	s3,0
 670:	b771                	j	5fc <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 672:	008b0913          	addi	s2,s6,8
 676:	4681                	li	a3,0
 678:	866a                	mv	a2,s10
 67a:	000b2583          	lw	a1,0(s6)
 67e:	8556                	mv	a0,s5
 680:	00000097          	auipc	ra,0x0
 684:	e70080e7          	jalr	-400(ra) # 4f0 <printint>
 688:	8b4a                	mv	s6,s2
      state = 0;
 68a:	4981                	li	s3,0
 68c:	bf85                	j	5fc <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 68e:	008b0793          	addi	a5,s6,8
 692:	f8f43423          	sd	a5,-120(s0)
 696:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 69a:	03000593          	li	a1,48
 69e:	8556                	mv	a0,s5
 6a0:	00000097          	auipc	ra,0x0
 6a4:	e2e080e7          	jalr	-466(ra) # 4ce <putc>
  putc(fd, 'x');
 6a8:	07800593          	li	a1,120
 6ac:	8556                	mv	a0,s5
 6ae:	00000097          	auipc	ra,0x0
 6b2:	e20080e7          	jalr	-480(ra) # 4ce <putc>
 6b6:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6b8:	03c9d793          	srli	a5,s3,0x3c
 6bc:	97de                	add	a5,a5,s7
 6be:	0007c583          	lbu	a1,0(a5)
 6c2:	8556                	mv	a0,s5
 6c4:	00000097          	auipc	ra,0x0
 6c8:	e0a080e7          	jalr	-502(ra) # 4ce <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6cc:	0992                	slli	s3,s3,0x4
 6ce:	397d                	addiw	s2,s2,-1
 6d0:	fe0914e3          	bnez	s2,6b8 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 6d4:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 6d8:	4981                	li	s3,0
 6da:	b70d                	j	5fc <vprintf+0x60>
        s = va_arg(ap, char*);
 6dc:	008b0913          	addi	s2,s6,8
 6e0:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 6e4:	02098163          	beqz	s3,706 <vprintf+0x16a>
        while(*s != 0){
 6e8:	0009c583          	lbu	a1,0(s3)
 6ec:	c5ad                	beqz	a1,756 <vprintf+0x1ba>
          putc(fd, *s);
 6ee:	8556                	mv	a0,s5
 6f0:	00000097          	auipc	ra,0x0
 6f4:	dde080e7          	jalr	-546(ra) # 4ce <putc>
          s++;
 6f8:	0985                	addi	s3,s3,1
        while(*s != 0){
 6fa:	0009c583          	lbu	a1,0(s3)
 6fe:	f9e5                	bnez	a1,6ee <vprintf+0x152>
        s = va_arg(ap, char*);
 700:	8b4a                	mv	s6,s2
      state = 0;
 702:	4981                	li	s3,0
 704:	bde5                	j	5fc <vprintf+0x60>
          s = "(null)";
 706:	00000997          	auipc	s3,0x0
 70a:	28a98993          	addi	s3,s3,650 # 990 <malloc+0x130>
        while(*s != 0){
 70e:	85ee                	mv	a1,s11
 710:	bff9                	j	6ee <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 712:	008b0913          	addi	s2,s6,8
 716:	000b4583          	lbu	a1,0(s6)
 71a:	8556                	mv	a0,s5
 71c:	00000097          	auipc	ra,0x0
 720:	db2080e7          	jalr	-590(ra) # 4ce <putc>
 724:	8b4a                	mv	s6,s2
      state = 0;
 726:	4981                	li	s3,0
 728:	bdd1                	j	5fc <vprintf+0x60>
        putc(fd, c);
 72a:	85d2                	mv	a1,s4
 72c:	8556                	mv	a0,s5
 72e:	00000097          	auipc	ra,0x0
 732:	da0080e7          	jalr	-608(ra) # 4ce <putc>
      state = 0;
 736:	4981                	li	s3,0
 738:	b5d1                	j	5fc <vprintf+0x60>
        putc(fd, '%');
 73a:	85d2                	mv	a1,s4
 73c:	8556                	mv	a0,s5
 73e:	00000097          	auipc	ra,0x0
 742:	d90080e7          	jalr	-624(ra) # 4ce <putc>
        putc(fd, c);
 746:	85ca                	mv	a1,s2
 748:	8556                	mv	a0,s5
 74a:	00000097          	auipc	ra,0x0
 74e:	d84080e7          	jalr	-636(ra) # 4ce <putc>
      state = 0;
 752:	4981                	li	s3,0
 754:	b565                	j	5fc <vprintf+0x60>
        s = va_arg(ap, char*);
 756:	8b4a                	mv	s6,s2
      state = 0;
 758:	4981                	li	s3,0
 75a:	b54d                	j	5fc <vprintf+0x60>
    }
  }
}
 75c:	70e6                	ld	ra,120(sp)
 75e:	7446                	ld	s0,112(sp)
 760:	74a6                	ld	s1,104(sp)
 762:	7906                	ld	s2,96(sp)
 764:	69e6                	ld	s3,88(sp)
 766:	6a46                	ld	s4,80(sp)
 768:	6aa6                	ld	s5,72(sp)
 76a:	6b06                	ld	s6,64(sp)
 76c:	7be2                	ld	s7,56(sp)
 76e:	7c42                	ld	s8,48(sp)
 770:	7ca2                	ld	s9,40(sp)
 772:	7d02                	ld	s10,32(sp)
 774:	6de2                	ld	s11,24(sp)
 776:	6109                	addi	sp,sp,128
 778:	8082                	ret

000000000000077a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 77a:	715d                	addi	sp,sp,-80
 77c:	ec06                	sd	ra,24(sp)
 77e:	e822                	sd	s0,16(sp)
 780:	1000                	addi	s0,sp,32
 782:	e010                	sd	a2,0(s0)
 784:	e414                	sd	a3,8(s0)
 786:	e818                	sd	a4,16(s0)
 788:	ec1c                	sd	a5,24(s0)
 78a:	03043023          	sd	a6,32(s0)
 78e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 792:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 796:	8622                	mv	a2,s0
 798:	00000097          	auipc	ra,0x0
 79c:	e04080e7          	jalr	-508(ra) # 59c <vprintf>
}
 7a0:	60e2                	ld	ra,24(sp)
 7a2:	6442                	ld	s0,16(sp)
 7a4:	6161                	addi	sp,sp,80
 7a6:	8082                	ret

00000000000007a8 <printf>:

void
printf(const char *fmt, ...)
{
 7a8:	711d                	addi	sp,sp,-96
 7aa:	ec06                	sd	ra,24(sp)
 7ac:	e822                	sd	s0,16(sp)
 7ae:	1000                	addi	s0,sp,32
 7b0:	e40c                	sd	a1,8(s0)
 7b2:	e810                	sd	a2,16(s0)
 7b4:	ec14                	sd	a3,24(s0)
 7b6:	f018                	sd	a4,32(s0)
 7b8:	f41c                	sd	a5,40(s0)
 7ba:	03043823          	sd	a6,48(s0)
 7be:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7c2:	00840613          	addi	a2,s0,8
 7c6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7ca:	85aa                	mv	a1,a0
 7cc:	4505                	li	a0,1
 7ce:	00000097          	auipc	ra,0x0
 7d2:	dce080e7          	jalr	-562(ra) # 59c <vprintf>
}
 7d6:	60e2                	ld	ra,24(sp)
 7d8:	6442                	ld	s0,16(sp)
 7da:	6125                	addi	sp,sp,96
 7dc:	8082                	ret

00000000000007de <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7de:	1141                	addi	sp,sp,-16
 7e0:	e422                	sd	s0,8(sp)
 7e2:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7e4:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e8:	00001797          	auipc	a5,0x1
 7ec:	8187b783          	ld	a5,-2024(a5) # 1000 <freep>
 7f0:	a02d                	j	81a <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7f2:	4618                	lw	a4,8(a2)
 7f4:	9f2d                	addw	a4,a4,a1
 7f6:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7fa:	6398                	ld	a4,0(a5)
 7fc:	6310                	ld	a2,0(a4)
 7fe:	a83d                	j	83c <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 800:	ff852703          	lw	a4,-8(a0)
 804:	9f31                	addw	a4,a4,a2
 806:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 808:	ff053683          	ld	a3,-16(a0)
 80c:	a091                	j	850 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 80e:	6398                	ld	a4,0(a5)
 810:	00e7e463          	bltu	a5,a4,818 <free+0x3a>
 814:	00e6ea63          	bltu	a3,a4,828 <free+0x4a>
{
 818:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 81a:	fed7fae3          	bgeu	a5,a3,80e <free+0x30>
 81e:	6398                	ld	a4,0(a5)
 820:	00e6e463          	bltu	a3,a4,828 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 824:	fee7eae3          	bltu	a5,a4,818 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 828:	ff852583          	lw	a1,-8(a0)
 82c:	6390                	ld	a2,0(a5)
 82e:	02059813          	slli	a6,a1,0x20
 832:	01c85713          	srli	a4,a6,0x1c
 836:	9736                	add	a4,a4,a3
 838:	fae60de3          	beq	a2,a4,7f2 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 83c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 840:	4790                	lw	a2,8(a5)
 842:	02061593          	slli	a1,a2,0x20
 846:	01c5d713          	srli	a4,a1,0x1c
 84a:	973e                	add	a4,a4,a5
 84c:	fae68ae3          	beq	a3,a4,800 <free+0x22>
    p->s.ptr = bp->s.ptr;
 850:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 852:	00000717          	auipc	a4,0x0
 856:	7af73723          	sd	a5,1966(a4) # 1000 <freep>
}
 85a:	6422                	ld	s0,8(sp)
 85c:	0141                	addi	sp,sp,16
 85e:	8082                	ret

0000000000000860 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 860:	7139                	addi	sp,sp,-64
 862:	fc06                	sd	ra,56(sp)
 864:	f822                	sd	s0,48(sp)
 866:	f426                	sd	s1,40(sp)
 868:	f04a                	sd	s2,32(sp)
 86a:	ec4e                	sd	s3,24(sp)
 86c:	e852                	sd	s4,16(sp)
 86e:	e456                	sd	s5,8(sp)
 870:	e05a                	sd	s6,0(sp)
 872:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 874:	02051493          	slli	s1,a0,0x20
 878:	9081                	srli	s1,s1,0x20
 87a:	04bd                	addi	s1,s1,15
 87c:	8091                	srli	s1,s1,0x4
 87e:	0014899b          	addiw	s3,s1,1
 882:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 884:	00000517          	auipc	a0,0x0
 888:	77c53503          	ld	a0,1916(a0) # 1000 <freep>
 88c:	c515                	beqz	a0,8b8 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 88e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 890:	4798                	lw	a4,8(a5)
 892:	02977f63          	bgeu	a4,s1,8d0 <malloc+0x70>
 896:	8a4e                	mv	s4,s3
 898:	0009871b          	sext.w	a4,s3
 89c:	6685                	lui	a3,0x1
 89e:	00d77363          	bgeu	a4,a3,8a4 <malloc+0x44>
 8a2:	6a05                	lui	s4,0x1
 8a4:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8a8:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8ac:	00000917          	auipc	s2,0x0
 8b0:	75490913          	addi	s2,s2,1876 # 1000 <freep>
  if(p == (char*)-1)
 8b4:	5afd                	li	s5,-1
 8b6:	a895                	j	92a <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 8b8:	00000797          	auipc	a5,0x0
 8bc:	75878793          	addi	a5,a5,1880 # 1010 <base>
 8c0:	00000717          	auipc	a4,0x0
 8c4:	74f73023          	sd	a5,1856(a4) # 1000 <freep>
 8c8:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8ca:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8ce:	b7e1                	j	896 <malloc+0x36>
      if(p->s.size == nunits)
 8d0:	02e48c63          	beq	s1,a4,908 <malloc+0xa8>
        p->s.size -= nunits;
 8d4:	4137073b          	subw	a4,a4,s3
 8d8:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8da:	02071693          	slli	a3,a4,0x20
 8de:	01c6d713          	srli	a4,a3,0x1c
 8e2:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8e4:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8e8:	00000717          	auipc	a4,0x0
 8ec:	70a73c23          	sd	a0,1816(a4) # 1000 <freep>
      return (void*)(p + 1);
 8f0:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8f4:	70e2                	ld	ra,56(sp)
 8f6:	7442                	ld	s0,48(sp)
 8f8:	74a2                	ld	s1,40(sp)
 8fa:	7902                	ld	s2,32(sp)
 8fc:	69e2                	ld	s3,24(sp)
 8fe:	6a42                	ld	s4,16(sp)
 900:	6aa2                	ld	s5,8(sp)
 902:	6b02                	ld	s6,0(sp)
 904:	6121                	addi	sp,sp,64
 906:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 908:	6398                	ld	a4,0(a5)
 90a:	e118                	sd	a4,0(a0)
 90c:	bff1                	j	8e8 <malloc+0x88>
  hp->s.size = nu;
 90e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 912:	0541                	addi	a0,a0,16
 914:	00000097          	auipc	ra,0x0
 918:	eca080e7          	jalr	-310(ra) # 7de <free>
  return freep;
 91c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 920:	d971                	beqz	a0,8f4 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 922:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 924:	4798                	lw	a4,8(a5)
 926:	fa9775e3          	bgeu	a4,s1,8d0 <malloc+0x70>
    if(p == freep)
 92a:	00093703          	ld	a4,0(s2)
 92e:	853e                	mv	a0,a5
 930:	fef719e3          	bne	a4,a5,922 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 934:	8552                	mv	a0,s4
 936:	00000097          	auipc	ra,0x0
 93a:	b78080e7          	jalr	-1160(ra) # 4ae <sbrk>
  if(p == (char*)-1)
 93e:	fd5518e3          	bne	a0,s5,90e <malloc+0xae>
        return 0;
 942:	4501                	li	a0,0
 944:	bf45                	j	8f4 <malloc+0x94>
