
user/_pingpong:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"



int main( int argc, char* argv[]) {
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	0080                	addi	s0,sp,64
	
	//check arguments are correct
	if (argc != 2) {
   a:	4789                	li	a5,2
   c:	02f50063          	beq	a0,a5,2c <main+0x2c>
		printf("Argument error");
  10:	00001517          	auipc	a0,0x1
  14:	91050513          	addi	a0,a0,-1776 # 920 <malloc+0xe8>
  18:	00000097          	auipc	ra,0x0
  1c:	768080e7          	jalr	1896(ra) # 780 <printf>
		exit(0);	
		
		
	}
	return 0;
}	
  20:	4505                	li	a0,1
  22:	70e2                	ld	ra,56(sp)
  24:	7442                	ld	s0,48(sp)
  26:	74a2                	ld	s1,40(sp)
  28:	6121                	addi	sp,sp,64
  2a:	8082                	ret
  2c:	84ae                	mv	s1,a1
	pipe(sendPipe);
  2e:	fd840513          	addi	a0,s0,-40
  32:	00000097          	auipc	ra,0x0
  36:	3e4080e7          	jalr	996(ra) # 416 <pipe>
	pipe(returnPipe);
  3a:	fd040513          	addi	a0,s0,-48
  3e:	00000097          	auipc	ra,0x0
  42:	3d8080e7          	jalr	984(ra) # 416 <pipe>
	char byte = argv[1][0];
  46:	649c                	ld	a5,8(s1)
  48:	0007c783          	lbu	a5,0(a5)
  4c:	fcf407a3          	sb	a5,-49(s0)
        int PID = fork();
  50:	00000097          	auipc	ra,0x0
  54:	3ae080e7          	jalr	942(ra) # 3fe <fork>
	if ( PID < 0) {
  58:	06054c63          	bltz	a0,d0 <main+0xd0>
	if ( PID > 0 ) {
  5c:	0aa04b63          	bgtz	a0,112 <main+0x112>
		read(sendPipe[0], &byte, 1);
  60:	4605                	li	a2,1
  62:	fcf40593          	addi	a1,s0,-49
  66:	fd842503          	lw	a0,-40(s0)
  6a:	00000097          	auipc	ra,0x0
  6e:	3b4080e7          	jalr	948(ra) # 41e <read>
		close(sendPipe[0]);	
  72:	fd842503          	lw	a0,-40(s0)
  76:	00000097          	auipc	ra,0x0
  7a:	3b8080e7          	jalr	952(ra) # 42e <close>
		alteredByte = byte >> 2;
  7e:	fcf44783          	lbu	a5,-49(s0)
  82:	0027d79b          	srliw	a5,a5,0x2
  86:	fcf40723          	sb	a5,-50(s0)
	        printf("%d: Received ping, %c\n",getpid(), byte);
  8a:	00000097          	auipc	ra,0x0
  8e:	3fc080e7          	jalr	1020(ra) # 486 <getpid>
  92:	85aa                	mv	a1,a0
  94:	fcf44603          	lbu	a2,-49(s0)
  98:	00001517          	auipc	a0,0x1
  9c:	8c050513          	addi	a0,a0,-1856 # 958 <malloc+0x120>
  a0:	00000097          	auipc	ra,0x0
  a4:	6e0080e7          	jalr	1760(ra) # 780 <printf>
		write(returnPipe[1], &alteredByte, 1);
  a8:	4605                	li	a2,1
  aa:	fce40593          	addi	a1,s0,-50
  ae:	fd442503          	lw	a0,-44(s0)
  b2:	00000097          	auipc	ra,0x0
  b6:	374080e7          	jalr	884(ra) # 426 <write>
		close(returnPipe[1]);
  ba:	fd442503          	lw	a0,-44(s0)
  be:	00000097          	auipc	ra,0x0
  c2:	370080e7          	jalr	880(ra) # 42e <close>
		exit(0);	
  c6:	4501                	li	a0,0
  c8:	00000097          	auipc	ra,0x0
  cc:	33e080e7          	jalr	830(ra) # 406 <exit>
		printf("pipe error");
  d0:	00001517          	auipc	a0,0x1
  d4:	86050513          	addi	a0,a0,-1952 # 930 <malloc+0xf8>
  d8:	00000097          	auipc	ra,0x0
  dc:	6a8080e7          	jalr	1704(ra) # 780 <printf>
		close(sendPipe[0]);
  e0:	fd842503          	lw	a0,-40(s0)
  e4:	00000097          	auipc	ra,0x0
  e8:	34a080e7          	jalr	842(ra) # 42e <close>
		close(sendPipe[1]);
  ec:	fdc42503          	lw	a0,-36(s0)
  f0:	00000097          	auipc	ra,0x0
  f4:	33e080e7          	jalr	830(ra) # 42e <close>
		close(returnPipe[0]);
  f8:	fd042503          	lw	a0,-48(s0)
  fc:	00000097          	auipc	ra,0x0
 100:	332080e7          	jalr	818(ra) # 42e <close>
		close(returnPipe[1]);
 104:	fd442503          	lw	a0,-44(s0)
 108:	00000097          	auipc	ra,0x0
 10c:	326080e7          	jalr	806(ra) # 42e <close>
		return 1;
 110:	bf01                	j	20 <main+0x20>
		write(sendPipe[1], &byte, 1);
 112:	4605                	li	a2,1
 114:	fcf40593          	addi	a1,s0,-49
 118:	fdc42503          	lw	a0,-36(s0)
 11c:	00000097          	auipc	ra,0x0
 120:	30a080e7          	jalr	778(ra) # 426 <write>
		close(sendPipe[1]);
 124:	fdc42503          	lw	a0,-36(s0)
 128:	00000097          	auipc	ra,0x0
 12c:	306080e7          	jalr	774(ra) # 42e <close>
		wait(0);	
 130:	4501                	li	a0,0
 132:	00000097          	auipc	ra,0x0
 136:	2dc080e7          	jalr	732(ra) # 40e <wait>
		read(returnPipe[0], &alteredByte, 1);
 13a:	4605                	li	a2,1
 13c:	fce40593          	addi	a1,s0,-50
 140:	fd042503          	lw	a0,-48(s0)
 144:	00000097          	auipc	ra,0x0
 148:	2da080e7          	jalr	730(ra) # 41e <read>
	        printf("%d: Received Pong ,%c\n",getpid(), alteredByte);
 14c:	00000097          	auipc	ra,0x0
 150:	33a080e7          	jalr	826(ra) # 486 <getpid>
 154:	85aa                	mv	a1,a0
 156:	fce44603          	lbu	a2,-50(s0)
 15a:	00000517          	auipc	a0,0x0
 15e:	7e650513          	addi	a0,a0,2022 # 940 <malloc+0x108>
 162:	00000097          	auipc	ra,0x0
 166:	61e080e7          	jalr	1566(ra) # 780 <printf>
		close(returnPipe[0]);	
 16a:	fd042503          	lw	a0,-48(s0)
 16e:	00000097          	auipc	ra,0x0
 172:	2c0080e7          	jalr	704(ra) # 42e <close>
		exit(0);
 176:	4501                	li	a0,0
 178:	00000097          	auipc	ra,0x0
 17c:	28e080e7          	jalr	654(ra) # 406 <exit>

0000000000000180 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 180:	1141                	addi	sp,sp,-16
 182:	e406                	sd	ra,8(sp)
 184:	e022                	sd	s0,0(sp)
 186:	0800                	addi	s0,sp,16
  extern int main();
  main();
 188:	00000097          	auipc	ra,0x0
 18c:	e78080e7          	jalr	-392(ra) # 0 <main>
  exit(0);
 190:	4501                	li	a0,0
 192:	00000097          	auipc	ra,0x0
 196:	274080e7          	jalr	628(ra) # 406 <exit>

000000000000019a <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 19a:	1141                	addi	sp,sp,-16
 19c:	e422                	sd	s0,8(sp)
 19e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1a0:	87aa                	mv	a5,a0
 1a2:	0585                	addi	a1,a1,1
 1a4:	0785                	addi	a5,a5,1
 1a6:	fff5c703          	lbu	a4,-1(a1)
 1aa:	fee78fa3          	sb	a4,-1(a5)
 1ae:	fb75                	bnez	a4,1a2 <strcpy+0x8>
    ;
  return os;
}
 1b0:	6422                	ld	s0,8(sp)
 1b2:	0141                	addi	sp,sp,16
 1b4:	8082                	ret

00000000000001b6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b6:	1141                	addi	sp,sp,-16
 1b8:	e422                	sd	s0,8(sp)
 1ba:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1bc:	00054783          	lbu	a5,0(a0)
 1c0:	cb91                	beqz	a5,1d4 <strcmp+0x1e>
 1c2:	0005c703          	lbu	a4,0(a1)
 1c6:	00f71763          	bne	a4,a5,1d4 <strcmp+0x1e>
    p++, q++;
 1ca:	0505                	addi	a0,a0,1
 1cc:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1ce:	00054783          	lbu	a5,0(a0)
 1d2:	fbe5                	bnez	a5,1c2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1d4:	0005c503          	lbu	a0,0(a1)
}
 1d8:	40a7853b          	subw	a0,a5,a0
 1dc:	6422                	ld	s0,8(sp)
 1de:	0141                	addi	sp,sp,16
 1e0:	8082                	ret

00000000000001e2 <strlen>:

uint
strlen(const char *s)
{
 1e2:	1141                	addi	sp,sp,-16
 1e4:	e422                	sd	s0,8(sp)
 1e6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1e8:	00054783          	lbu	a5,0(a0)
 1ec:	cf91                	beqz	a5,208 <strlen+0x26>
 1ee:	0505                	addi	a0,a0,1
 1f0:	87aa                	mv	a5,a0
 1f2:	4685                	li	a3,1
 1f4:	9e89                	subw	a3,a3,a0
 1f6:	00f6853b          	addw	a0,a3,a5
 1fa:	0785                	addi	a5,a5,1
 1fc:	fff7c703          	lbu	a4,-1(a5)
 200:	fb7d                	bnez	a4,1f6 <strlen+0x14>
    ;
  return n;
}
 202:	6422                	ld	s0,8(sp)
 204:	0141                	addi	sp,sp,16
 206:	8082                	ret
  for(n = 0; s[n]; n++)
 208:	4501                	li	a0,0
 20a:	bfe5                	j	202 <strlen+0x20>

000000000000020c <memset>:

void*
memset(void *dst, int c, uint n)
{
 20c:	1141                	addi	sp,sp,-16
 20e:	e422                	sd	s0,8(sp)
 210:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 212:	ca19                	beqz	a2,228 <memset+0x1c>
 214:	87aa                	mv	a5,a0
 216:	1602                	slli	a2,a2,0x20
 218:	9201                	srli	a2,a2,0x20
 21a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 21e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 222:	0785                	addi	a5,a5,1
 224:	fee79de3          	bne	a5,a4,21e <memset+0x12>
  }
  return dst;
}
 228:	6422                	ld	s0,8(sp)
 22a:	0141                	addi	sp,sp,16
 22c:	8082                	ret

000000000000022e <strchr>:

char*
strchr(const char *s, char c)
{
 22e:	1141                	addi	sp,sp,-16
 230:	e422                	sd	s0,8(sp)
 232:	0800                	addi	s0,sp,16
  for(; *s; s++)
 234:	00054783          	lbu	a5,0(a0)
 238:	cb99                	beqz	a5,24e <strchr+0x20>
    if(*s == c)
 23a:	00f58763          	beq	a1,a5,248 <strchr+0x1a>
  for(; *s; s++)
 23e:	0505                	addi	a0,a0,1
 240:	00054783          	lbu	a5,0(a0)
 244:	fbfd                	bnez	a5,23a <strchr+0xc>
      return (char*)s;
  return 0;
 246:	4501                	li	a0,0
}
 248:	6422                	ld	s0,8(sp)
 24a:	0141                	addi	sp,sp,16
 24c:	8082                	ret
  return 0;
 24e:	4501                	li	a0,0
 250:	bfe5                	j	248 <strchr+0x1a>

0000000000000252 <gets>:

char*
gets(char *buf, int max)
{
 252:	711d                	addi	sp,sp,-96
 254:	ec86                	sd	ra,88(sp)
 256:	e8a2                	sd	s0,80(sp)
 258:	e4a6                	sd	s1,72(sp)
 25a:	e0ca                	sd	s2,64(sp)
 25c:	fc4e                	sd	s3,56(sp)
 25e:	f852                	sd	s4,48(sp)
 260:	f456                	sd	s5,40(sp)
 262:	f05a                	sd	s6,32(sp)
 264:	ec5e                	sd	s7,24(sp)
 266:	1080                	addi	s0,sp,96
 268:	8baa                	mv	s7,a0
 26a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 26c:	892a                	mv	s2,a0
 26e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 270:	4aa9                	li	s5,10
 272:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 274:	89a6                	mv	s3,s1
 276:	2485                	addiw	s1,s1,1
 278:	0344d863          	bge	s1,s4,2a8 <gets+0x56>
    cc = read(0, &c, 1);
 27c:	4605                	li	a2,1
 27e:	faf40593          	addi	a1,s0,-81
 282:	4501                	li	a0,0
 284:	00000097          	auipc	ra,0x0
 288:	19a080e7          	jalr	410(ra) # 41e <read>
    if(cc < 1)
 28c:	00a05e63          	blez	a0,2a8 <gets+0x56>
    buf[i++] = c;
 290:	faf44783          	lbu	a5,-81(s0)
 294:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 298:	01578763          	beq	a5,s5,2a6 <gets+0x54>
 29c:	0905                	addi	s2,s2,1
 29e:	fd679be3          	bne	a5,s6,274 <gets+0x22>
  for(i=0; i+1 < max; ){
 2a2:	89a6                	mv	s3,s1
 2a4:	a011                	j	2a8 <gets+0x56>
 2a6:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2a8:	99de                	add	s3,s3,s7
 2aa:	00098023          	sb	zero,0(s3)
  return buf;
}
 2ae:	855e                	mv	a0,s7
 2b0:	60e6                	ld	ra,88(sp)
 2b2:	6446                	ld	s0,80(sp)
 2b4:	64a6                	ld	s1,72(sp)
 2b6:	6906                	ld	s2,64(sp)
 2b8:	79e2                	ld	s3,56(sp)
 2ba:	7a42                	ld	s4,48(sp)
 2bc:	7aa2                	ld	s5,40(sp)
 2be:	7b02                	ld	s6,32(sp)
 2c0:	6be2                	ld	s7,24(sp)
 2c2:	6125                	addi	sp,sp,96
 2c4:	8082                	ret

00000000000002c6 <stat>:

int
stat(const char *n, struct stat *st)
{
 2c6:	1101                	addi	sp,sp,-32
 2c8:	ec06                	sd	ra,24(sp)
 2ca:	e822                	sd	s0,16(sp)
 2cc:	e426                	sd	s1,8(sp)
 2ce:	e04a                	sd	s2,0(sp)
 2d0:	1000                	addi	s0,sp,32
 2d2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2d4:	4581                	li	a1,0
 2d6:	00000097          	auipc	ra,0x0
 2da:	170080e7          	jalr	368(ra) # 446 <open>
  if(fd < 0)
 2de:	02054563          	bltz	a0,308 <stat+0x42>
 2e2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2e4:	85ca                	mv	a1,s2
 2e6:	00000097          	auipc	ra,0x0
 2ea:	178080e7          	jalr	376(ra) # 45e <fstat>
 2ee:	892a                	mv	s2,a0
  close(fd);
 2f0:	8526                	mv	a0,s1
 2f2:	00000097          	auipc	ra,0x0
 2f6:	13c080e7          	jalr	316(ra) # 42e <close>
  return r;
}
 2fa:	854a                	mv	a0,s2
 2fc:	60e2                	ld	ra,24(sp)
 2fe:	6442                	ld	s0,16(sp)
 300:	64a2                	ld	s1,8(sp)
 302:	6902                	ld	s2,0(sp)
 304:	6105                	addi	sp,sp,32
 306:	8082                	ret
    return -1;
 308:	597d                	li	s2,-1
 30a:	bfc5                	j	2fa <stat+0x34>

000000000000030c <atoi>:

int
atoi(const char *s)
{
 30c:	1141                	addi	sp,sp,-16
 30e:	e422                	sd	s0,8(sp)
 310:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 312:	00054683          	lbu	a3,0(a0)
 316:	fd06879b          	addiw	a5,a3,-48
 31a:	0ff7f793          	zext.b	a5,a5
 31e:	4625                	li	a2,9
 320:	02f66863          	bltu	a2,a5,350 <atoi+0x44>
 324:	872a                	mv	a4,a0
  n = 0;
 326:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 328:	0705                	addi	a4,a4,1
 32a:	0025179b          	slliw	a5,a0,0x2
 32e:	9fa9                	addw	a5,a5,a0
 330:	0017979b          	slliw	a5,a5,0x1
 334:	9fb5                	addw	a5,a5,a3
 336:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 33a:	00074683          	lbu	a3,0(a4)
 33e:	fd06879b          	addiw	a5,a3,-48
 342:	0ff7f793          	zext.b	a5,a5
 346:	fef671e3          	bgeu	a2,a5,328 <atoi+0x1c>
  return n;
}
 34a:	6422                	ld	s0,8(sp)
 34c:	0141                	addi	sp,sp,16
 34e:	8082                	ret
  n = 0;
 350:	4501                	li	a0,0
 352:	bfe5                	j	34a <atoi+0x3e>

0000000000000354 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 354:	1141                	addi	sp,sp,-16
 356:	e422                	sd	s0,8(sp)
 358:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 35a:	02b57463          	bgeu	a0,a1,382 <memmove+0x2e>
    while(n-- > 0)
 35e:	00c05f63          	blez	a2,37c <memmove+0x28>
 362:	1602                	slli	a2,a2,0x20
 364:	9201                	srli	a2,a2,0x20
 366:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 36a:	872a                	mv	a4,a0
      *dst++ = *src++;
 36c:	0585                	addi	a1,a1,1
 36e:	0705                	addi	a4,a4,1
 370:	fff5c683          	lbu	a3,-1(a1)
 374:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 378:	fee79ae3          	bne	a5,a4,36c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 37c:	6422                	ld	s0,8(sp)
 37e:	0141                	addi	sp,sp,16
 380:	8082                	ret
    dst += n;
 382:	00c50733          	add	a4,a0,a2
    src += n;
 386:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 388:	fec05ae3          	blez	a2,37c <memmove+0x28>
 38c:	fff6079b          	addiw	a5,a2,-1
 390:	1782                	slli	a5,a5,0x20
 392:	9381                	srli	a5,a5,0x20
 394:	fff7c793          	not	a5,a5
 398:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 39a:	15fd                	addi	a1,a1,-1
 39c:	177d                	addi	a4,a4,-1
 39e:	0005c683          	lbu	a3,0(a1)
 3a2:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3a6:	fee79ae3          	bne	a5,a4,39a <memmove+0x46>
 3aa:	bfc9                	j	37c <memmove+0x28>

00000000000003ac <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3ac:	1141                	addi	sp,sp,-16
 3ae:	e422                	sd	s0,8(sp)
 3b0:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3b2:	ca05                	beqz	a2,3e2 <memcmp+0x36>
 3b4:	fff6069b          	addiw	a3,a2,-1
 3b8:	1682                	slli	a3,a3,0x20
 3ba:	9281                	srli	a3,a3,0x20
 3bc:	0685                	addi	a3,a3,1
 3be:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3c0:	00054783          	lbu	a5,0(a0)
 3c4:	0005c703          	lbu	a4,0(a1)
 3c8:	00e79863          	bne	a5,a4,3d8 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3cc:	0505                	addi	a0,a0,1
    p2++;
 3ce:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3d0:	fed518e3          	bne	a0,a3,3c0 <memcmp+0x14>
  }
  return 0;
 3d4:	4501                	li	a0,0
 3d6:	a019                	j	3dc <memcmp+0x30>
      return *p1 - *p2;
 3d8:	40e7853b          	subw	a0,a5,a4
}
 3dc:	6422                	ld	s0,8(sp)
 3de:	0141                	addi	sp,sp,16
 3e0:	8082                	ret
  return 0;
 3e2:	4501                	li	a0,0
 3e4:	bfe5                	j	3dc <memcmp+0x30>

00000000000003e6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3e6:	1141                	addi	sp,sp,-16
 3e8:	e406                	sd	ra,8(sp)
 3ea:	e022                	sd	s0,0(sp)
 3ec:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3ee:	00000097          	auipc	ra,0x0
 3f2:	f66080e7          	jalr	-154(ra) # 354 <memmove>
}
 3f6:	60a2                	ld	ra,8(sp)
 3f8:	6402                	ld	s0,0(sp)
 3fa:	0141                	addi	sp,sp,16
 3fc:	8082                	ret

00000000000003fe <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3fe:	4885                	li	a7,1
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <exit>:
.global exit
exit:
 li a7, SYS_exit
 406:	4889                	li	a7,2
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <wait>:
.global wait
wait:
 li a7, SYS_wait
 40e:	488d                	li	a7,3
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 416:	4891                	li	a7,4
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <read>:
.global read
read:
 li a7, SYS_read
 41e:	4895                	li	a7,5
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <write>:
.global write
write:
 li a7, SYS_write
 426:	48c1                	li	a7,16
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <close>:
.global close
close:
 li a7, SYS_close
 42e:	48d5                	li	a7,21
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <kill>:
.global kill
kill:
 li a7, SYS_kill
 436:	4899                	li	a7,6
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <exec>:
.global exec
exec:
 li a7, SYS_exec
 43e:	489d                	li	a7,7
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <open>:
.global open
open:
 li a7, SYS_open
 446:	48bd                	li	a7,15
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 44e:	48c5                	li	a7,17
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 456:	48c9                	li	a7,18
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 45e:	48a1                	li	a7,8
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <link>:
.global link
link:
 li a7, SYS_link
 466:	48cd                	li	a7,19
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 46e:	48d1                	li	a7,20
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 476:	48a5                	li	a7,9
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <dup>:
.global dup
dup:
 li a7, SYS_dup
 47e:	48a9                	li	a7,10
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 486:	48ad                	li	a7,11
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 48e:	48b1                	li	a7,12
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 496:	48b5                	li	a7,13
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 49e:	48b9                	li	a7,14
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4a6:	1101                	addi	sp,sp,-32
 4a8:	ec06                	sd	ra,24(sp)
 4aa:	e822                	sd	s0,16(sp)
 4ac:	1000                	addi	s0,sp,32
 4ae:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4b2:	4605                	li	a2,1
 4b4:	fef40593          	addi	a1,s0,-17
 4b8:	00000097          	auipc	ra,0x0
 4bc:	f6e080e7          	jalr	-146(ra) # 426 <write>
}
 4c0:	60e2                	ld	ra,24(sp)
 4c2:	6442                	ld	s0,16(sp)
 4c4:	6105                	addi	sp,sp,32
 4c6:	8082                	ret

00000000000004c8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4c8:	7139                	addi	sp,sp,-64
 4ca:	fc06                	sd	ra,56(sp)
 4cc:	f822                	sd	s0,48(sp)
 4ce:	f426                	sd	s1,40(sp)
 4d0:	f04a                	sd	s2,32(sp)
 4d2:	ec4e                	sd	s3,24(sp)
 4d4:	0080                	addi	s0,sp,64
 4d6:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4d8:	c299                	beqz	a3,4de <printint+0x16>
 4da:	0805c963          	bltz	a1,56c <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4de:	2581                	sext.w	a1,a1
  neg = 0;
 4e0:	4881                	li	a7,0
 4e2:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 4e6:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4e8:	2601                	sext.w	a2,a2
 4ea:	00000517          	auipc	a0,0x0
 4ee:	4e650513          	addi	a0,a0,1254 # 9d0 <digits>
 4f2:	883a                	mv	a6,a4
 4f4:	2705                	addiw	a4,a4,1
 4f6:	02c5f7bb          	remuw	a5,a1,a2
 4fa:	1782                	slli	a5,a5,0x20
 4fc:	9381                	srli	a5,a5,0x20
 4fe:	97aa                	add	a5,a5,a0
 500:	0007c783          	lbu	a5,0(a5)
 504:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 508:	0005879b          	sext.w	a5,a1
 50c:	02c5d5bb          	divuw	a1,a1,a2
 510:	0685                	addi	a3,a3,1
 512:	fec7f0e3          	bgeu	a5,a2,4f2 <printint+0x2a>
  if(neg)
 516:	00088c63          	beqz	a7,52e <printint+0x66>
    buf[i++] = '-';
 51a:	fd070793          	addi	a5,a4,-48
 51e:	00878733          	add	a4,a5,s0
 522:	02d00793          	li	a5,45
 526:	fef70823          	sb	a5,-16(a4)
 52a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 52e:	02e05863          	blez	a4,55e <printint+0x96>
 532:	fc040793          	addi	a5,s0,-64
 536:	00e78933          	add	s2,a5,a4
 53a:	fff78993          	addi	s3,a5,-1
 53e:	99ba                	add	s3,s3,a4
 540:	377d                	addiw	a4,a4,-1
 542:	1702                	slli	a4,a4,0x20
 544:	9301                	srli	a4,a4,0x20
 546:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 54a:	fff94583          	lbu	a1,-1(s2)
 54e:	8526                	mv	a0,s1
 550:	00000097          	auipc	ra,0x0
 554:	f56080e7          	jalr	-170(ra) # 4a6 <putc>
  while(--i >= 0)
 558:	197d                	addi	s2,s2,-1
 55a:	ff3918e3          	bne	s2,s3,54a <printint+0x82>
}
 55e:	70e2                	ld	ra,56(sp)
 560:	7442                	ld	s0,48(sp)
 562:	74a2                	ld	s1,40(sp)
 564:	7902                	ld	s2,32(sp)
 566:	69e2                	ld	s3,24(sp)
 568:	6121                	addi	sp,sp,64
 56a:	8082                	ret
    x = -xx;
 56c:	40b005bb          	negw	a1,a1
    neg = 1;
 570:	4885                	li	a7,1
    x = -xx;
 572:	bf85                	j	4e2 <printint+0x1a>

0000000000000574 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 574:	7119                	addi	sp,sp,-128
 576:	fc86                	sd	ra,120(sp)
 578:	f8a2                	sd	s0,112(sp)
 57a:	f4a6                	sd	s1,104(sp)
 57c:	f0ca                	sd	s2,96(sp)
 57e:	ecce                	sd	s3,88(sp)
 580:	e8d2                	sd	s4,80(sp)
 582:	e4d6                	sd	s5,72(sp)
 584:	e0da                	sd	s6,64(sp)
 586:	fc5e                	sd	s7,56(sp)
 588:	f862                	sd	s8,48(sp)
 58a:	f466                	sd	s9,40(sp)
 58c:	f06a                	sd	s10,32(sp)
 58e:	ec6e                	sd	s11,24(sp)
 590:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 592:	0005c903          	lbu	s2,0(a1)
 596:	18090f63          	beqz	s2,734 <vprintf+0x1c0>
 59a:	8aaa                	mv	s5,a0
 59c:	8b32                	mv	s6,a2
 59e:	00158493          	addi	s1,a1,1
  state = 0;
 5a2:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5a4:	02500a13          	li	s4,37
 5a8:	4c55                	li	s8,21
 5aa:	00000c97          	auipc	s9,0x0
 5ae:	3cec8c93          	addi	s9,s9,974 # 978 <malloc+0x140>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5b2:	02800d93          	li	s11,40
  putc(fd, 'x');
 5b6:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5b8:	00000b97          	auipc	s7,0x0
 5bc:	418b8b93          	addi	s7,s7,1048 # 9d0 <digits>
 5c0:	a839                	j	5de <vprintf+0x6a>
        putc(fd, c);
 5c2:	85ca                	mv	a1,s2
 5c4:	8556                	mv	a0,s5
 5c6:	00000097          	auipc	ra,0x0
 5ca:	ee0080e7          	jalr	-288(ra) # 4a6 <putc>
 5ce:	a019                	j	5d4 <vprintf+0x60>
    } else if(state == '%'){
 5d0:	01498d63          	beq	s3,s4,5ea <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 5d4:	0485                	addi	s1,s1,1
 5d6:	fff4c903          	lbu	s2,-1(s1)
 5da:	14090d63          	beqz	s2,734 <vprintf+0x1c0>
    if(state == 0){
 5de:	fe0999e3          	bnez	s3,5d0 <vprintf+0x5c>
      if(c == '%'){
 5e2:	ff4910e3          	bne	s2,s4,5c2 <vprintf+0x4e>
        state = '%';
 5e6:	89d2                	mv	s3,s4
 5e8:	b7f5                	j	5d4 <vprintf+0x60>
      if(c == 'd'){
 5ea:	11490c63          	beq	s2,s4,702 <vprintf+0x18e>
 5ee:	f9d9079b          	addiw	a5,s2,-99
 5f2:	0ff7f793          	zext.b	a5,a5
 5f6:	10fc6e63          	bltu	s8,a5,712 <vprintf+0x19e>
 5fa:	f9d9079b          	addiw	a5,s2,-99
 5fe:	0ff7f713          	zext.b	a4,a5
 602:	10ec6863          	bltu	s8,a4,712 <vprintf+0x19e>
 606:	00271793          	slli	a5,a4,0x2
 60a:	97e6                	add	a5,a5,s9
 60c:	439c                	lw	a5,0(a5)
 60e:	97e6                	add	a5,a5,s9
 610:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 612:	008b0913          	addi	s2,s6,8
 616:	4685                	li	a3,1
 618:	4629                	li	a2,10
 61a:	000b2583          	lw	a1,0(s6)
 61e:	8556                	mv	a0,s5
 620:	00000097          	auipc	ra,0x0
 624:	ea8080e7          	jalr	-344(ra) # 4c8 <printint>
 628:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 62a:	4981                	li	s3,0
 62c:	b765                	j	5d4 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 62e:	008b0913          	addi	s2,s6,8
 632:	4681                	li	a3,0
 634:	4629                	li	a2,10
 636:	000b2583          	lw	a1,0(s6)
 63a:	8556                	mv	a0,s5
 63c:	00000097          	auipc	ra,0x0
 640:	e8c080e7          	jalr	-372(ra) # 4c8 <printint>
 644:	8b4a                	mv	s6,s2
      state = 0;
 646:	4981                	li	s3,0
 648:	b771                	j	5d4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 64a:	008b0913          	addi	s2,s6,8
 64e:	4681                	li	a3,0
 650:	866a                	mv	a2,s10
 652:	000b2583          	lw	a1,0(s6)
 656:	8556                	mv	a0,s5
 658:	00000097          	auipc	ra,0x0
 65c:	e70080e7          	jalr	-400(ra) # 4c8 <printint>
 660:	8b4a                	mv	s6,s2
      state = 0;
 662:	4981                	li	s3,0
 664:	bf85                	j	5d4 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 666:	008b0793          	addi	a5,s6,8
 66a:	f8f43423          	sd	a5,-120(s0)
 66e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 672:	03000593          	li	a1,48
 676:	8556                	mv	a0,s5
 678:	00000097          	auipc	ra,0x0
 67c:	e2e080e7          	jalr	-466(ra) # 4a6 <putc>
  putc(fd, 'x');
 680:	07800593          	li	a1,120
 684:	8556                	mv	a0,s5
 686:	00000097          	auipc	ra,0x0
 68a:	e20080e7          	jalr	-480(ra) # 4a6 <putc>
 68e:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 690:	03c9d793          	srli	a5,s3,0x3c
 694:	97de                	add	a5,a5,s7
 696:	0007c583          	lbu	a1,0(a5)
 69a:	8556                	mv	a0,s5
 69c:	00000097          	auipc	ra,0x0
 6a0:	e0a080e7          	jalr	-502(ra) # 4a6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6a4:	0992                	slli	s3,s3,0x4
 6a6:	397d                	addiw	s2,s2,-1
 6a8:	fe0914e3          	bnez	s2,690 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 6ac:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 6b0:	4981                	li	s3,0
 6b2:	b70d                	j	5d4 <vprintf+0x60>
        s = va_arg(ap, char*);
 6b4:	008b0913          	addi	s2,s6,8
 6b8:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 6bc:	02098163          	beqz	s3,6de <vprintf+0x16a>
        while(*s != 0){
 6c0:	0009c583          	lbu	a1,0(s3)
 6c4:	c5ad                	beqz	a1,72e <vprintf+0x1ba>
          putc(fd, *s);
 6c6:	8556                	mv	a0,s5
 6c8:	00000097          	auipc	ra,0x0
 6cc:	dde080e7          	jalr	-546(ra) # 4a6 <putc>
          s++;
 6d0:	0985                	addi	s3,s3,1
        while(*s != 0){
 6d2:	0009c583          	lbu	a1,0(s3)
 6d6:	f9e5                	bnez	a1,6c6 <vprintf+0x152>
        s = va_arg(ap, char*);
 6d8:	8b4a                	mv	s6,s2
      state = 0;
 6da:	4981                	li	s3,0
 6dc:	bde5                	j	5d4 <vprintf+0x60>
          s = "(null)";
 6de:	00000997          	auipc	s3,0x0
 6e2:	29298993          	addi	s3,s3,658 # 970 <malloc+0x138>
        while(*s != 0){
 6e6:	85ee                	mv	a1,s11
 6e8:	bff9                	j	6c6 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 6ea:	008b0913          	addi	s2,s6,8
 6ee:	000b4583          	lbu	a1,0(s6)
 6f2:	8556                	mv	a0,s5
 6f4:	00000097          	auipc	ra,0x0
 6f8:	db2080e7          	jalr	-590(ra) # 4a6 <putc>
 6fc:	8b4a                	mv	s6,s2
      state = 0;
 6fe:	4981                	li	s3,0
 700:	bdd1                	j	5d4 <vprintf+0x60>
        putc(fd, c);
 702:	85d2                	mv	a1,s4
 704:	8556                	mv	a0,s5
 706:	00000097          	auipc	ra,0x0
 70a:	da0080e7          	jalr	-608(ra) # 4a6 <putc>
      state = 0;
 70e:	4981                	li	s3,0
 710:	b5d1                	j	5d4 <vprintf+0x60>
        putc(fd, '%');
 712:	85d2                	mv	a1,s4
 714:	8556                	mv	a0,s5
 716:	00000097          	auipc	ra,0x0
 71a:	d90080e7          	jalr	-624(ra) # 4a6 <putc>
        putc(fd, c);
 71e:	85ca                	mv	a1,s2
 720:	8556                	mv	a0,s5
 722:	00000097          	auipc	ra,0x0
 726:	d84080e7          	jalr	-636(ra) # 4a6 <putc>
      state = 0;
 72a:	4981                	li	s3,0
 72c:	b565                	j	5d4 <vprintf+0x60>
        s = va_arg(ap, char*);
 72e:	8b4a                	mv	s6,s2
      state = 0;
 730:	4981                	li	s3,0
 732:	b54d                	j	5d4 <vprintf+0x60>
    }
  }
}
 734:	70e6                	ld	ra,120(sp)
 736:	7446                	ld	s0,112(sp)
 738:	74a6                	ld	s1,104(sp)
 73a:	7906                	ld	s2,96(sp)
 73c:	69e6                	ld	s3,88(sp)
 73e:	6a46                	ld	s4,80(sp)
 740:	6aa6                	ld	s5,72(sp)
 742:	6b06                	ld	s6,64(sp)
 744:	7be2                	ld	s7,56(sp)
 746:	7c42                	ld	s8,48(sp)
 748:	7ca2                	ld	s9,40(sp)
 74a:	7d02                	ld	s10,32(sp)
 74c:	6de2                	ld	s11,24(sp)
 74e:	6109                	addi	sp,sp,128
 750:	8082                	ret

0000000000000752 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 752:	715d                	addi	sp,sp,-80
 754:	ec06                	sd	ra,24(sp)
 756:	e822                	sd	s0,16(sp)
 758:	1000                	addi	s0,sp,32
 75a:	e010                	sd	a2,0(s0)
 75c:	e414                	sd	a3,8(s0)
 75e:	e818                	sd	a4,16(s0)
 760:	ec1c                	sd	a5,24(s0)
 762:	03043023          	sd	a6,32(s0)
 766:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 76a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 76e:	8622                	mv	a2,s0
 770:	00000097          	auipc	ra,0x0
 774:	e04080e7          	jalr	-508(ra) # 574 <vprintf>
}
 778:	60e2                	ld	ra,24(sp)
 77a:	6442                	ld	s0,16(sp)
 77c:	6161                	addi	sp,sp,80
 77e:	8082                	ret

0000000000000780 <printf>:

void
printf(const char *fmt, ...)
{
 780:	711d                	addi	sp,sp,-96
 782:	ec06                	sd	ra,24(sp)
 784:	e822                	sd	s0,16(sp)
 786:	1000                	addi	s0,sp,32
 788:	e40c                	sd	a1,8(s0)
 78a:	e810                	sd	a2,16(s0)
 78c:	ec14                	sd	a3,24(s0)
 78e:	f018                	sd	a4,32(s0)
 790:	f41c                	sd	a5,40(s0)
 792:	03043823          	sd	a6,48(s0)
 796:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 79a:	00840613          	addi	a2,s0,8
 79e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7a2:	85aa                	mv	a1,a0
 7a4:	4505                	li	a0,1
 7a6:	00000097          	auipc	ra,0x0
 7aa:	dce080e7          	jalr	-562(ra) # 574 <vprintf>
}
 7ae:	60e2                	ld	ra,24(sp)
 7b0:	6442                	ld	s0,16(sp)
 7b2:	6125                	addi	sp,sp,96
 7b4:	8082                	ret

00000000000007b6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7b6:	1141                	addi	sp,sp,-16
 7b8:	e422                	sd	s0,8(sp)
 7ba:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7bc:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c0:	00001797          	auipc	a5,0x1
 7c4:	8407b783          	ld	a5,-1984(a5) # 1000 <freep>
 7c8:	a02d                	j	7f2 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7ca:	4618                	lw	a4,8(a2)
 7cc:	9f2d                	addw	a4,a4,a1
 7ce:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7d2:	6398                	ld	a4,0(a5)
 7d4:	6310                	ld	a2,0(a4)
 7d6:	a83d                	j	814 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7d8:	ff852703          	lw	a4,-8(a0)
 7dc:	9f31                	addw	a4,a4,a2
 7de:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7e0:	ff053683          	ld	a3,-16(a0)
 7e4:	a091                	j	828 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7e6:	6398                	ld	a4,0(a5)
 7e8:	00e7e463          	bltu	a5,a4,7f0 <free+0x3a>
 7ec:	00e6ea63          	bltu	a3,a4,800 <free+0x4a>
{
 7f0:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7f2:	fed7fae3          	bgeu	a5,a3,7e6 <free+0x30>
 7f6:	6398                	ld	a4,0(a5)
 7f8:	00e6e463          	bltu	a3,a4,800 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7fc:	fee7eae3          	bltu	a5,a4,7f0 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 800:	ff852583          	lw	a1,-8(a0)
 804:	6390                	ld	a2,0(a5)
 806:	02059813          	slli	a6,a1,0x20
 80a:	01c85713          	srli	a4,a6,0x1c
 80e:	9736                	add	a4,a4,a3
 810:	fae60de3          	beq	a2,a4,7ca <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 814:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 818:	4790                	lw	a2,8(a5)
 81a:	02061593          	slli	a1,a2,0x20
 81e:	01c5d713          	srli	a4,a1,0x1c
 822:	973e                	add	a4,a4,a5
 824:	fae68ae3          	beq	a3,a4,7d8 <free+0x22>
    p->s.ptr = bp->s.ptr;
 828:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 82a:	00000717          	auipc	a4,0x0
 82e:	7cf73b23          	sd	a5,2006(a4) # 1000 <freep>
}
 832:	6422                	ld	s0,8(sp)
 834:	0141                	addi	sp,sp,16
 836:	8082                	ret

0000000000000838 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 838:	7139                	addi	sp,sp,-64
 83a:	fc06                	sd	ra,56(sp)
 83c:	f822                	sd	s0,48(sp)
 83e:	f426                	sd	s1,40(sp)
 840:	f04a                	sd	s2,32(sp)
 842:	ec4e                	sd	s3,24(sp)
 844:	e852                	sd	s4,16(sp)
 846:	e456                	sd	s5,8(sp)
 848:	e05a                	sd	s6,0(sp)
 84a:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 84c:	02051493          	slli	s1,a0,0x20
 850:	9081                	srli	s1,s1,0x20
 852:	04bd                	addi	s1,s1,15
 854:	8091                	srli	s1,s1,0x4
 856:	0014899b          	addiw	s3,s1,1
 85a:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 85c:	00000517          	auipc	a0,0x0
 860:	7a453503          	ld	a0,1956(a0) # 1000 <freep>
 864:	c515                	beqz	a0,890 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 866:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 868:	4798                	lw	a4,8(a5)
 86a:	02977f63          	bgeu	a4,s1,8a8 <malloc+0x70>
 86e:	8a4e                	mv	s4,s3
 870:	0009871b          	sext.w	a4,s3
 874:	6685                	lui	a3,0x1
 876:	00d77363          	bgeu	a4,a3,87c <malloc+0x44>
 87a:	6a05                	lui	s4,0x1
 87c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 880:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 884:	00000917          	auipc	s2,0x0
 888:	77c90913          	addi	s2,s2,1916 # 1000 <freep>
  if(p == (char*)-1)
 88c:	5afd                	li	s5,-1
 88e:	a895                	j	902 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 890:	00000797          	auipc	a5,0x0
 894:	78078793          	addi	a5,a5,1920 # 1010 <base>
 898:	00000717          	auipc	a4,0x0
 89c:	76f73423          	sd	a5,1896(a4) # 1000 <freep>
 8a0:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8a2:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8a6:	b7e1                	j	86e <malloc+0x36>
      if(p->s.size == nunits)
 8a8:	02e48c63          	beq	s1,a4,8e0 <malloc+0xa8>
        p->s.size -= nunits;
 8ac:	4137073b          	subw	a4,a4,s3
 8b0:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8b2:	02071693          	slli	a3,a4,0x20
 8b6:	01c6d713          	srli	a4,a3,0x1c
 8ba:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8bc:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8c0:	00000717          	auipc	a4,0x0
 8c4:	74a73023          	sd	a0,1856(a4) # 1000 <freep>
      return (void*)(p + 1);
 8c8:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8cc:	70e2                	ld	ra,56(sp)
 8ce:	7442                	ld	s0,48(sp)
 8d0:	74a2                	ld	s1,40(sp)
 8d2:	7902                	ld	s2,32(sp)
 8d4:	69e2                	ld	s3,24(sp)
 8d6:	6a42                	ld	s4,16(sp)
 8d8:	6aa2                	ld	s5,8(sp)
 8da:	6b02                	ld	s6,0(sp)
 8dc:	6121                	addi	sp,sp,64
 8de:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8e0:	6398                	ld	a4,0(a5)
 8e2:	e118                	sd	a4,0(a0)
 8e4:	bff1                	j	8c0 <malloc+0x88>
  hp->s.size = nu;
 8e6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8ea:	0541                	addi	a0,a0,16
 8ec:	00000097          	auipc	ra,0x0
 8f0:	eca080e7          	jalr	-310(ra) # 7b6 <free>
  return freep;
 8f4:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8f8:	d971                	beqz	a0,8cc <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8fa:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8fc:	4798                	lw	a4,8(a5)
 8fe:	fa9775e3          	bgeu	a4,s1,8a8 <malloc+0x70>
    if(p == freep)
 902:	00093703          	ld	a4,0(s2)
 906:	853e                	mv	a0,a5
 908:	fef719e3          	bne	a4,a5,8fa <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 90c:	8552                	mv	a0,s4
 90e:	00000097          	auipc	ra,0x0
 912:	b80080e7          	jalr	-1152(ra) # 48e <sbrk>
  if(p == (char*)-1)
 916:	fd5518e3          	bne	a0,s5,8e6 <malloc+0xae>
        return 0;
 91a:	4501                	li	a0,0
 91c:	bf45                	j	8cc <malloc+0x94>
