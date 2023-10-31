
user/_find:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <usage>:
#include "kernel/stat.h"
#include "kernel/fcntl.h"
#include "kernel/fs.h"
#include "user/user.h"

void usage() {
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  fprintf(1, "usage: find path expression\n");
   8:	00001597          	auipc	a1,0x1
   c:	9c858593          	addi	a1,a1,-1592 # 9d0 <malloc+0xf4>
  10:	4505                	li	a0,1
  12:	00000097          	auipc	ra,0x0
  16:	7e4080e7          	jalr	2020(ra) # 7f6 <fprintf>
}
  1a:	60a2                	ld	ra,8(sp)
  1c:	6402                	ld	s0,0(sp)
  1e:	0141                	addi	sp,sp,16
  20:	8082                	ret

0000000000000022 <find>:

void find(char *path, char *expression) {
  22:	d9010113          	addi	sp,sp,-624
  26:	26113423          	sd	ra,616(sp)
  2a:	26813023          	sd	s0,608(sp)
  2e:	24913c23          	sd	s1,600(sp)
  32:	25213823          	sd	s2,592(sp)
  36:	25313423          	sd	s3,584(sp)
  3a:	25413023          	sd	s4,576(sp)
  3e:	23513c23          	sd	s5,568(sp)
  42:	23613823          	sd	s6,560(sp)
  46:	1c80                	addi	s0,sp,624
  48:	892a                	mv	s2,a0
  4a:	89ae                	mv	s3,a1
  // Contents of directory entries, used when
  // the path is a directory.
  struct dirent de;

  // Open the specified path for reading.
  if ((fd = open(path, O_RDONLY)) < 0) {
  4c:	4581                	li	a1,0
  4e:	00000097          	auipc	ra,0x0
  52:	494080e7          	jalr	1172(ra) # 4e2 <open>
  56:	04054563          	bltz	a0,a0 <find+0x7e>
  5a:	84aa                	mv	s1,a0
    fprintf(2, "find: cannot open %s\n", path);
    exit(1);
  }

  // Get the status about the opened path.
  if (fstat(fd, &st) < 0) {
  5c:	da840593          	addi	a1,s0,-600
  60:	00000097          	auipc	ra,0x0
  64:	49a080e7          	jalr	1178(ra) # 4fa <fstat>
  68:	04054b63          	bltz	a0,be <find+0x9c>
    fprintf(2, "find: cannot stat %s\n", path);
    exit(1);
  }

  // Check if the path is a file or a directory.
  switch (st.type) {
  6c:	db041783          	lh	a5,-592(s0)
  70:	0007869b          	sext.w	a3,a5
  74:	4705                	li	a4,1
  76:	0ce68663          	beq	a3,a4,142 <find+0x120>
  7a:	4709                	li	a4,2
  7c:	08e69063          	bne	a3,a4,fc <find+0xda>
  case T_FILE:
    // Pointerers to the first character in the path.
    p = path;
    b = p;
    // Pointer to the end of the path (after the last char).
    e = p + strlen(path);
  80:	854a                	mv	a0,s2
  82:	00000097          	auipc	ra,0x0
  86:	1fc080e7          	jalr	508(ra) # 27e <strlen>
  8a:	02051693          	slli	a3,a0,0x20
  8e:	9281                	srli	a3,a3,0x20
  90:	96ca                	add	a3,a3,s2
    // Loop through each character in the path and find the
    // last slash. Pointer b at the end points to the character
    // after the last slash (start of the file name).
    while (p < e) {
  92:	04d97e63          	bgeu	s2,a3,ee <find+0xcc>
    b = p;
  96:	854a                	mv	a0,s2
    p = path;
  98:	87ca                	mv	a5,s2
      if (*p++ == '/') {
  9a:	02f00613          	li	a2,47
  9e:	a089                	j	e0 <find+0xbe>
    fprintf(2, "find: cannot open %s\n", path);
  a0:	864a                	mv	a2,s2
  a2:	00001597          	auipc	a1,0x1
  a6:	94e58593          	addi	a1,a1,-1714 # 9f0 <malloc+0x114>
  aa:	4509                	li	a0,2
  ac:	00000097          	auipc	ra,0x0
  b0:	74a080e7          	jalr	1866(ra) # 7f6 <fprintf>
    exit(1);
  b4:	4505                	li	a0,1
  b6:	00000097          	auipc	ra,0x0
  ba:	3ec080e7          	jalr	1004(ra) # 4a2 <exit>
    fprintf(2, "find: cannot stat %s\n", path);
  be:	864a                	mv	a2,s2
  c0:	00001597          	auipc	a1,0x1
  c4:	94858593          	addi	a1,a1,-1720 # a08 <malloc+0x12c>
  c8:	4509                	li	a0,2
  ca:	00000097          	auipc	ra,0x0
  ce:	72c080e7          	jalr	1836(ra) # 7f6 <fprintf>
    exit(1);
  d2:	4505                	li	a0,1
  d4:	00000097          	auipc	ra,0x0
  d8:	3ce080e7          	jalr	974(ra) # 4a2 <exit>
    while (p < e) {
  dc:	00f68a63          	beq	a3,a5,f0 <find+0xce>
      if (*p++ == '/') {
  e0:	0785                	addi	a5,a5,1
  e2:	fff7c703          	lbu	a4,-1(a5)
  e6:	fec71be3          	bne	a4,a2,dc <find+0xba>
        b = p;
  ea:	853e                	mv	a0,a5
  ec:	bfc5                	j	dc <find+0xba>
    b = p;
  ee:	854a                	mv	a0,s2
      }
    }

    // Compare the file name at the end of the path to the file
    // name which we are search for. If equil, print the path.
    if (strcmp(b, expression) == 0) {
  f0:	85ce                	mv	a1,s3
  f2:	00000097          	auipc	ra,0x0
  f6:	160080e7          	jalr	352(ra) # 252 <strcmp>
  fa:	c90d                	beqz	a0,12c <find+0x10a>
      // process.
      find(buf, expression);
    }
    break;
  }
  close(fd);
  fc:	8526                	mv	a0,s1
  fe:	00000097          	auipc	ra,0x0
 102:	3cc080e7          	jalr	972(ra) # 4ca <close>
}
 106:	26813083          	ld	ra,616(sp)
 10a:	26013403          	ld	s0,608(sp)
 10e:	25813483          	ld	s1,600(sp)
 112:	25013903          	ld	s2,592(sp)
 116:	24813983          	ld	s3,584(sp)
 11a:	24013a03          	ld	s4,576(sp)
 11e:	23813a83          	ld	s5,568(sp)
 122:	23013b03          	ld	s6,560(sp)
 126:	27010113          	addi	sp,sp,624
 12a:	8082                	ret
      fprintf(1, "%s\n", path);
 12c:	864a                	mv	a2,s2
 12e:	00001597          	auipc	a1,0x1
 132:	8f258593          	addi	a1,a1,-1806 # a20 <malloc+0x144>
 136:	4505                	li	a0,1
 138:	00000097          	auipc	ra,0x0
 13c:	6be080e7          	jalr	1726(ra) # 7f6 <fprintf>
 140:	bf75                	j	fc <find+0xda>
    strcpy(buf, path);
 142:	85ca                	mv	a1,s2
 144:	dc040513          	addi	a0,s0,-576
 148:	00000097          	auipc	ra,0x0
 14c:	0ee080e7          	jalr	238(ra) # 236 <strcpy>
    p = buf + strlen(buf);
 150:	dc040513          	addi	a0,s0,-576
 154:	00000097          	auipc	ra,0x0
 158:	12a080e7          	jalr	298(ra) # 27e <strlen>
 15c:	1502                	slli	a0,a0,0x20
 15e:	9101                	srli	a0,a0,0x20
 160:	dc040793          	addi	a5,s0,-576
 164:	00a78933          	add	s2,a5,a0
    *p++ = '/';
 168:	00190b13          	addi	s6,s2,1
 16c:	02f00793          	li	a5,47
 170:	00f90023          	sb	a5,0(s2)
      if (de.inum == 0 || strcmp(de.name, ".") == 0 || 
 174:	00001a17          	auipc	s4,0x1
 178:	8b4a0a13          	addi	s4,s4,-1868 # a28 <malloc+0x14c>
          strcmp(de.name, "..") == 0) { // ??
 17c:	00001a97          	auipc	s5,0x1
 180:	8b4a8a93          	addi	s5,s5,-1868 # a30 <malloc+0x154>
    while(read(fd, &de, sizeof(de)) == sizeof(de)) {
 184:	4641                	li	a2,16
 186:	d9840593          	addi	a1,s0,-616
 18a:	8526                	mv	a0,s1
 18c:	00000097          	auipc	ra,0x0
 190:	32e080e7          	jalr	814(ra) # 4ba <read>
 194:	47c1                	li	a5,16
 196:	f6f513e3          	bne	a0,a5,fc <find+0xda>
      if (de.inum == 0 || strcmp(de.name, ".") == 0 || 
 19a:	d9845783          	lhu	a5,-616(s0)
 19e:	d3fd                	beqz	a5,184 <find+0x162>
 1a0:	85d2                	mv	a1,s4
 1a2:	d9a40513          	addi	a0,s0,-614
 1a6:	00000097          	auipc	ra,0x0
 1aa:	0ac080e7          	jalr	172(ra) # 252 <strcmp>
 1ae:	d979                	beqz	a0,184 <find+0x162>
          strcmp(de.name, "..") == 0) { // ??
 1b0:	85d6                	mv	a1,s5
 1b2:	d9a40513          	addi	a0,s0,-614
 1b6:	00000097          	auipc	ra,0x0
 1ba:	09c080e7          	jalr	156(ra) # 252 <strcmp>
      if (de.inum == 0 || strcmp(de.name, ".") == 0 || 
 1be:	d179                	beqz	a0,184 <find+0x162>
      memmove(p, de.name, DIRSIZ);
 1c0:	4639                	li	a2,14
 1c2:	d9a40593          	addi	a1,s0,-614
 1c6:	855a                	mv	a0,s6
 1c8:	00000097          	auipc	ra,0x0
 1cc:	228080e7          	jalr	552(ra) # 3f0 <memmove>
      p[DIRSIZ] = 0;
 1d0:	000907a3          	sb	zero,15(s2)
      find(buf, expression);
 1d4:	85ce                	mv	a1,s3
 1d6:	dc040513          	addi	a0,s0,-576
 1da:	00000097          	auipc	ra,0x0
 1de:	e48080e7          	jalr	-440(ra) # 22 <find>
 1e2:	b74d                	j	184 <find+0x162>

00000000000001e4 <main>:

int main(int argc, char *argv[]) {
 1e4:	1141                	addi	sp,sp,-16
 1e6:	e406                	sd	ra,8(sp)
 1e8:	e022                	sd	s0,0(sp)
 1ea:	0800                	addi	s0,sp,16
  
  if (argc < 3) {
 1ec:	4709                	li	a4,2
 1ee:	00a74b63          	blt	a4,a0,204 <main+0x20>
    usage();
 1f2:	00000097          	auipc	ra,0x0
 1f6:	e0e080e7          	jalr	-498(ra) # 0 <usage>
    exit(1);
 1fa:	4505                	li	a0,1
 1fc:	00000097          	auipc	ra,0x0
 200:	2a6080e7          	jalr	678(ra) # 4a2 <exit>
 204:	87ae                	mv	a5,a1
  }

  // Pass the directory name to start the search in and
  // the file name to search for.
  find(argv[1], argv[2]);
 206:	698c                	ld	a1,16(a1)
 208:	6788                	ld	a0,8(a5)
 20a:	00000097          	auipc	ra,0x0
 20e:	e18080e7          	jalr	-488(ra) # 22 <find>
  exit(0);
 212:	4501                	li	a0,0
 214:	00000097          	auipc	ra,0x0
 218:	28e080e7          	jalr	654(ra) # 4a2 <exit>

000000000000021c <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 21c:	1141                	addi	sp,sp,-16
 21e:	e406                	sd	ra,8(sp)
 220:	e022                	sd	s0,0(sp)
 222:	0800                	addi	s0,sp,16
  extern int main();
  main();
 224:	00000097          	auipc	ra,0x0
 228:	fc0080e7          	jalr	-64(ra) # 1e4 <main>
  exit(0);
 22c:	4501                	li	a0,0
 22e:	00000097          	auipc	ra,0x0
 232:	274080e7          	jalr	628(ra) # 4a2 <exit>

0000000000000236 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 236:	1141                	addi	sp,sp,-16
 238:	e422                	sd	s0,8(sp)
 23a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 23c:	87aa                	mv	a5,a0
 23e:	0585                	addi	a1,a1,1
 240:	0785                	addi	a5,a5,1
 242:	fff5c703          	lbu	a4,-1(a1)
 246:	fee78fa3          	sb	a4,-1(a5)
 24a:	fb75                	bnez	a4,23e <strcpy+0x8>
    ;
  return os;
}
 24c:	6422                	ld	s0,8(sp)
 24e:	0141                	addi	sp,sp,16
 250:	8082                	ret

0000000000000252 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 252:	1141                	addi	sp,sp,-16
 254:	e422                	sd	s0,8(sp)
 256:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 258:	00054783          	lbu	a5,0(a0)
 25c:	cb91                	beqz	a5,270 <strcmp+0x1e>
 25e:	0005c703          	lbu	a4,0(a1)
 262:	00f71763          	bne	a4,a5,270 <strcmp+0x1e>
    p++, q++;
 266:	0505                	addi	a0,a0,1
 268:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 26a:	00054783          	lbu	a5,0(a0)
 26e:	fbe5                	bnez	a5,25e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 270:	0005c503          	lbu	a0,0(a1)
}
 274:	40a7853b          	subw	a0,a5,a0
 278:	6422                	ld	s0,8(sp)
 27a:	0141                	addi	sp,sp,16
 27c:	8082                	ret

000000000000027e <strlen>:

uint
strlen(const char *s)
{
 27e:	1141                	addi	sp,sp,-16
 280:	e422                	sd	s0,8(sp)
 282:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 284:	00054783          	lbu	a5,0(a0)
 288:	cf91                	beqz	a5,2a4 <strlen+0x26>
 28a:	0505                	addi	a0,a0,1
 28c:	87aa                	mv	a5,a0
 28e:	4685                	li	a3,1
 290:	9e89                	subw	a3,a3,a0
 292:	00f6853b          	addw	a0,a3,a5
 296:	0785                	addi	a5,a5,1
 298:	fff7c703          	lbu	a4,-1(a5)
 29c:	fb7d                	bnez	a4,292 <strlen+0x14>
    ;
  return n;
}
 29e:	6422                	ld	s0,8(sp)
 2a0:	0141                	addi	sp,sp,16
 2a2:	8082                	ret
  for(n = 0; s[n]; n++)
 2a4:	4501                	li	a0,0
 2a6:	bfe5                	j	29e <strlen+0x20>

00000000000002a8 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2a8:	1141                	addi	sp,sp,-16
 2aa:	e422                	sd	s0,8(sp)
 2ac:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2ae:	ca19                	beqz	a2,2c4 <memset+0x1c>
 2b0:	87aa                	mv	a5,a0
 2b2:	1602                	slli	a2,a2,0x20
 2b4:	9201                	srli	a2,a2,0x20
 2b6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2ba:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2be:	0785                	addi	a5,a5,1
 2c0:	fee79de3          	bne	a5,a4,2ba <memset+0x12>
  }
  return dst;
}
 2c4:	6422                	ld	s0,8(sp)
 2c6:	0141                	addi	sp,sp,16
 2c8:	8082                	ret

00000000000002ca <strchr>:

char*
strchr(const char *s, char c)
{
 2ca:	1141                	addi	sp,sp,-16
 2cc:	e422                	sd	s0,8(sp)
 2ce:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2d0:	00054783          	lbu	a5,0(a0)
 2d4:	cb99                	beqz	a5,2ea <strchr+0x20>
    if(*s == c)
 2d6:	00f58763          	beq	a1,a5,2e4 <strchr+0x1a>
  for(; *s; s++)
 2da:	0505                	addi	a0,a0,1
 2dc:	00054783          	lbu	a5,0(a0)
 2e0:	fbfd                	bnez	a5,2d6 <strchr+0xc>
      return (char*)s;
  return 0;
 2e2:	4501                	li	a0,0
}
 2e4:	6422                	ld	s0,8(sp)
 2e6:	0141                	addi	sp,sp,16
 2e8:	8082                	ret
  return 0;
 2ea:	4501                	li	a0,0
 2ec:	bfe5                	j	2e4 <strchr+0x1a>

00000000000002ee <gets>:

char*
gets(char *buf, int max)
{
 2ee:	711d                	addi	sp,sp,-96
 2f0:	ec86                	sd	ra,88(sp)
 2f2:	e8a2                	sd	s0,80(sp)
 2f4:	e4a6                	sd	s1,72(sp)
 2f6:	e0ca                	sd	s2,64(sp)
 2f8:	fc4e                	sd	s3,56(sp)
 2fa:	f852                	sd	s4,48(sp)
 2fc:	f456                	sd	s5,40(sp)
 2fe:	f05a                	sd	s6,32(sp)
 300:	ec5e                	sd	s7,24(sp)
 302:	1080                	addi	s0,sp,96
 304:	8baa                	mv	s7,a0
 306:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 308:	892a                	mv	s2,a0
 30a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 30c:	4aa9                	li	s5,10
 30e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 310:	89a6                	mv	s3,s1
 312:	2485                	addiw	s1,s1,1
 314:	0344d863          	bge	s1,s4,344 <gets+0x56>
    cc = read(0, &c, 1);
 318:	4605                	li	a2,1
 31a:	faf40593          	addi	a1,s0,-81
 31e:	4501                	li	a0,0
 320:	00000097          	auipc	ra,0x0
 324:	19a080e7          	jalr	410(ra) # 4ba <read>
    if(cc < 1)
 328:	00a05e63          	blez	a0,344 <gets+0x56>
    buf[i++] = c;
 32c:	faf44783          	lbu	a5,-81(s0)
 330:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 334:	01578763          	beq	a5,s5,342 <gets+0x54>
 338:	0905                	addi	s2,s2,1
 33a:	fd679be3          	bne	a5,s6,310 <gets+0x22>
  for(i=0; i+1 < max; ){
 33e:	89a6                	mv	s3,s1
 340:	a011                	j	344 <gets+0x56>
 342:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 344:	99de                	add	s3,s3,s7
 346:	00098023          	sb	zero,0(s3)
  return buf;
}
 34a:	855e                	mv	a0,s7
 34c:	60e6                	ld	ra,88(sp)
 34e:	6446                	ld	s0,80(sp)
 350:	64a6                	ld	s1,72(sp)
 352:	6906                	ld	s2,64(sp)
 354:	79e2                	ld	s3,56(sp)
 356:	7a42                	ld	s4,48(sp)
 358:	7aa2                	ld	s5,40(sp)
 35a:	7b02                	ld	s6,32(sp)
 35c:	6be2                	ld	s7,24(sp)
 35e:	6125                	addi	sp,sp,96
 360:	8082                	ret

0000000000000362 <stat>:

int
stat(const char *n, struct stat *st)
{
 362:	1101                	addi	sp,sp,-32
 364:	ec06                	sd	ra,24(sp)
 366:	e822                	sd	s0,16(sp)
 368:	e426                	sd	s1,8(sp)
 36a:	e04a                	sd	s2,0(sp)
 36c:	1000                	addi	s0,sp,32
 36e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 370:	4581                	li	a1,0
 372:	00000097          	auipc	ra,0x0
 376:	170080e7          	jalr	368(ra) # 4e2 <open>
  if(fd < 0)
 37a:	02054563          	bltz	a0,3a4 <stat+0x42>
 37e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 380:	85ca                	mv	a1,s2
 382:	00000097          	auipc	ra,0x0
 386:	178080e7          	jalr	376(ra) # 4fa <fstat>
 38a:	892a                	mv	s2,a0
  close(fd);
 38c:	8526                	mv	a0,s1
 38e:	00000097          	auipc	ra,0x0
 392:	13c080e7          	jalr	316(ra) # 4ca <close>
  return r;
}
 396:	854a                	mv	a0,s2
 398:	60e2                	ld	ra,24(sp)
 39a:	6442                	ld	s0,16(sp)
 39c:	64a2                	ld	s1,8(sp)
 39e:	6902                	ld	s2,0(sp)
 3a0:	6105                	addi	sp,sp,32
 3a2:	8082                	ret
    return -1;
 3a4:	597d                	li	s2,-1
 3a6:	bfc5                	j	396 <stat+0x34>

00000000000003a8 <atoi>:

int
atoi(const char *s)
{
 3a8:	1141                	addi	sp,sp,-16
 3aa:	e422                	sd	s0,8(sp)
 3ac:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3ae:	00054683          	lbu	a3,0(a0)
 3b2:	fd06879b          	addiw	a5,a3,-48
 3b6:	0ff7f793          	zext.b	a5,a5
 3ba:	4625                	li	a2,9
 3bc:	02f66863          	bltu	a2,a5,3ec <atoi+0x44>
 3c0:	872a                	mv	a4,a0
  n = 0;
 3c2:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 3c4:	0705                	addi	a4,a4,1
 3c6:	0025179b          	slliw	a5,a0,0x2
 3ca:	9fa9                	addw	a5,a5,a0
 3cc:	0017979b          	slliw	a5,a5,0x1
 3d0:	9fb5                	addw	a5,a5,a3
 3d2:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3d6:	00074683          	lbu	a3,0(a4)
 3da:	fd06879b          	addiw	a5,a3,-48
 3de:	0ff7f793          	zext.b	a5,a5
 3e2:	fef671e3          	bgeu	a2,a5,3c4 <atoi+0x1c>
  return n;
}
 3e6:	6422                	ld	s0,8(sp)
 3e8:	0141                	addi	sp,sp,16
 3ea:	8082                	ret
  n = 0;
 3ec:	4501                	li	a0,0
 3ee:	bfe5                	j	3e6 <atoi+0x3e>

00000000000003f0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3f0:	1141                	addi	sp,sp,-16
 3f2:	e422                	sd	s0,8(sp)
 3f4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3f6:	02b57463          	bgeu	a0,a1,41e <memmove+0x2e>
    while(n-- > 0)
 3fa:	00c05f63          	blez	a2,418 <memmove+0x28>
 3fe:	1602                	slli	a2,a2,0x20
 400:	9201                	srli	a2,a2,0x20
 402:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 406:	872a                	mv	a4,a0
      *dst++ = *src++;
 408:	0585                	addi	a1,a1,1
 40a:	0705                	addi	a4,a4,1
 40c:	fff5c683          	lbu	a3,-1(a1)
 410:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 414:	fee79ae3          	bne	a5,a4,408 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 418:	6422                	ld	s0,8(sp)
 41a:	0141                	addi	sp,sp,16
 41c:	8082                	ret
    dst += n;
 41e:	00c50733          	add	a4,a0,a2
    src += n;
 422:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 424:	fec05ae3          	blez	a2,418 <memmove+0x28>
 428:	fff6079b          	addiw	a5,a2,-1
 42c:	1782                	slli	a5,a5,0x20
 42e:	9381                	srli	a5,a5,0x20
 430:	fff7c793          	not	a5,a5
 434:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 436:	15fd                	addi	a1,a1,-1
 438:	177d                	addi	a4,a4,-1
 43a:	0005c683          	lbu	a3,0(a1)
 43e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 442:	fee79ae3          	bne	a5,a4,436 <memmove+0x46>
 446:	bfc9                	j	418 <memmove+0x28>

0000000000000448 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 448:	1141                	addi	sp,sp,-16
 44a:	e422                	sd	s0,8(sp)
 44c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 44e:	ca05                	beqz	a2,47e <memcmp+0x36>
 450:	fff6069b          	addiw	a3,a2,-1
 454:	1682                	slli	a3,a3,0x20
 456:	9281                	srli	a3,a3,0x20
 458:	0685                	addi	a3,a3,1
 45a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 45c:	00054783          	lbu	a5,0(a0)
 460:	0005c703          	lbu	a4,0(a1)
 464:	00e79863          	bne	a5,a4,474 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 468:	0505                	addi	a0,a0,1
    p2++;
 46a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 46c:	fed518e3          	bne	a0,a3,45c <memcmp+0x14>
  }
  return 0;
 470:	4501                	li	a0,0
 472:	a019                	j	478 <memcmp+0x30>
      return *p1 - *p2;
 474:	40e7853b          	subw	a0,a5,a4
}
 478:	6422                	ld	s0,8(sp)
 47a:	0141                	addi	sp,sp,16
 47c:	8082                	ret
  return 0;
 47e:	4501                	li	a0,0
 480:	bfe5                	j	478 <memcmp+0x30>

0000000000000482 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 482:	1141                	addi	sp,sp,-16
 484:	e406                	sd	ra,8(sp)
 486:	e022                	sd	s0,0(sp)
 488:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 48a:	00000097          	auipc	ra,0x0
 48e:	f66080e7          	jalr	-154(ra) # 3f0 <memmove>
}
 492:	60a2                	ld	ra,8(sp)
 494:	6402                	ld	s0,0(sp)
 496:	0141                	addi	sp,sp,16
 498:	8082                	ret

000000000000049a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 49a:	4885                	li	a7,1
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4a2:	4889                	li	a7,2
 ecall
 4a4:	00000073          	ecall
 ret
 4a8:	8082                	ret

00000000000004aa <wait>:
.global wait
wait:
 li a7, SYS_wait
 4aa:	488d                	li	a7,3
 ecall
 4ac:	00000073          	ecall
 ret
 4b0:	8082                	ret

00000000000004b2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4b2:	4891                	li	a7,4
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <read>:
.global read
read:
 li a7, SYS_read
 4ba:	4895                	li	a7,5
 ecall
 4bc:	00000073          	ecall
 ret
 4c0:	8082                	ret

00000000000004c2 <write>:
.global write
write:
 li a7, SYS_write
 4c2:	48c1                	li	a7,16
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <close>:
.global close
close:
 li a7, SYS_close
 4ca:	48d5                	li	a7,21
 ecall
 4cc:	00000073          	ecall
 ret
 4d0:	8082                	ret

00000000000004d2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4d2:	4899                	li	a7,6
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <exec>:
.global exec
exec:
 li a7, SYS_exec
 4da:	489d                	li	a7,7
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <open>:
.global open
open:
 li a7, SYS_open
 4e2:	48bd                	li	a7,15
 ecall
 4e4:	00000073          	ecall
 ret
 4e8:	8082                	ret

00000000000004ea <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4ea:	48c5                	li	a7,17
 ecall
 4ec:	00000073          	ecall
 ret
 4f0:	8082                	ret

00000000000004f2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4f2:	48c9                	li	a7,18
 ecall
 4f4:	00000073          	ecall
 ret
 4f8:	8082                	ret

00000000000004fa <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4fa:	48a1                	li	a7,8
 ecall
 4fc:	00000073          	ecall
 ret
 500:	8082                	ret

0000000000000502 <link>:
.global link
link:
 li a7, SYS_link
 502:	48cd                	li	a7,19
 ecall
 504:	00000073          	ecall
 ret
 508:	8082                	ret

000000000000050a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 50a:	48d1                	li	a7,20
 ecall
 50c:	00000073          	ecall
 ret
 510:	8082                	ret

0000000000000512 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 512:	48a5                	li	a7,9
 ecall
 514:	00000073          	ecall
 ret
 518:	8082                	ret

000000000000051a <dup>:
.global dup
dup:
 li a7, SYS_dup
 51a:	48a9                	li	a7,10
 ecall
 51c:	00000073          	ecall
 ret
 520:	8082                	ret

0000000000000522 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 522:	48ad                	li	a7,11
 ecall
 524:	00000073          	ecall
 ret
 528:	8082                	ret

000000000000052a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 52a:	48b1                	li	a7,12
 ecall
 52c:	00000073          	ecall
 ret
 530:	8082                	ret

0000000000000532 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 532:	48b5                	li	a7,13
 ecall
 534:	00000073          	ecall
 ret
 538:	8082                	ret

000000000000053a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 53a:	48b9                	li	a7,14
 ecall
 53c:	00000073          	ecall
 ret
 540:	8082                	ret

0000000000000542 <getyear>:
.global getyear
getyear:
 li a7, SYS_getyear
 542:	48d9                	li	a7,22
 ecall
 544:	00000073          	ecall
 ret
 548:	8082                	ret

000000000000054a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 54a:	1101                	addi	sp,sp,-32
 54c:	ec06                	sd	ra,24(sp)
 54e:	e822                	sd	s0,16(sp)
 550:	1000                	addi	s0,sp,32
 552:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 556:	4605                	li	a2,1
 558:	fef40593          	addi	a1,s0,-17
 55c:	00000097          	auipc	ra,0x0
 560:	f66080e7          	jalr	-154(ra) # 4c2 <write>
}
 564:	60e2                	ld	ra,24(sp)
 566:	6442                	ld	s0,16(sp)
 568:	6105                	addi	sp,sp,32
 56a:	8082                	ret

000000000000056c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 56c:	7139                	addi	sp,sp,-64
 56e:	fc06                	sd	ra,56(sp)
 570:	f822                	sd	s0,48(sp)
 572:	f426                	sd	s1,40(sp)
 574:	f04a                	sd	s2,32(sp)
 576:	ec4e                	sd	s3,24(sp)
 578:	0080                	addi	s0,sp,64
 57a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 57c:	c299                	beqz	a3,582 <printint+0x16>
 57e:	0805c963          	bltz	a1,610 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 582:	2581                	sext.w	a1,a1
  neg = 0;
 584:	4881                	li	a7,0
 586:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 58a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 58c:	2601                	sext.w	a2,a2
 58e:	00000517          	auipc	a0,0x0
 592:	50a50513          	addi	a0,a0,1290 # a98 <digits>
 596:	883a                	mv	a6,a4
 598:	2705                	addiw	a4,a4,1
 59a:	02c5f7bb          	remuw	a5,a1,a2
 59e:	1782                	slli	a5,a5,0x20
 5a0:	9381                	srli	a5,a5,0x20
 5a2:	97aa                	add	a5,a5,a0
 5a4:	0007c783          	lbu	a5,0(a5)
 5a8:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5ac:	0005879b          	sext.w	a5,a1
 5b0:	02c5d5bb          	divuw	a1,a1,a2
 5b4:	0685                	addi	a3,a3,1
 5b6:	fec7f0e3          	bgeu	a5,a2,596 <printint+0x2a>
  if(neg)
 5ba:	00088c63          	beqz	a7,5d2 <printint+0x66>
    buf[i++] = '-';
 5be:	fd070793          	addi	a5,a4,-48
 5c2:	00878733          	add	a4,a5,s0
 5c6:	02d00793          	li	a5,45
 5ca:	fef70823          	sb	a5,-16(a4)
 5ce:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 5d2:	02e05863          	blez	a4,602 <printint+0x96>
 5d6:	fc040793          	addi	a5,s0,-64
 5da:	00e78933          	add	s2,a5,a4
 5de:	fff78993          	addi	s3,a5,-1
 5e2:	99ba                	add	s3,s3,a4
 5e4:	377d                	addiw	a4,a4,-1
 5e6:	1702                	slli	a4,a4,0x20
 5e8:	9301                	srli	a4,a4,0x20
 5ea:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 5ee:	fff94583          	lbu	a1,-1(s2)
 5f2:	8526                	mv	a0,s1
 5f4:	00000097          	auipc	ra,0x0
 5f8:	f56080e7          	jalr	-170(ra) # 54a <putc>
  while(--i >= 0)
 5fc:	197d                	addi	s2,s2,-1
 5fe:	ff3918e3          	bne	s2,s3,5ee <printint+0x82>
}
 602:	70e2                	ld	ra,56(sp)
 604:	7442                	ld	s0,48(sp)
 606:	74a2                	ld	s1,40(sp)
 608:	7902                	ld	s2,32(sp)
 60a:	69e2                	ld	s3,24(sp)
 60c:	6121                	addi	sp,sp,64
 60e:	8082                	ret
    x = -xx;
 610:	40b005bb          	negw	a1,a1
    neg = 1;
 614:	4885                	li	a7,1
    x = -xx;
 616:	bf85                	j	586 <printint+0x1a>

0000000000000618 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 618:	7119                	addi	sp,sp,-128
 61a:	fc86                	sd	ra,120(sp)
 61c:	f8a2                	sd	s0,112(sp)
 61e:	f4a6                	sd	s1,104(sp)
 620:	f0ca                	sd	s2,96(sp)
 622:	ecce                	sd	s3,88(sp)
 624:	e8d2                	sd	s4,80(sp)
 626:	e4d6                	sd	s5,72(sp)
 628:	e0da                	sd	s6,64(sp)
 62a:	fc5e                	sd	s7,56(sp)
 62c:	f862                	sd	s8,48(sp)
 62e:	f466                	sd	s9,40(sp)
 630:	f06a                	sd	s10,32(sp)
 632:	ec6e                	sd	s11,24(sp)
 634:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 636:	0005c903          	lbu	s2,0(a1)
 63a:	18090f63          	beqz	s2,7d8 <vprintf+0x1c0>
 63e:	8aaa                	mv	s5,a0
 640:	8b32                	mv	s6,a2
 642:	00158493          	addi	s1,a1,1
  state = 0;
 646:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 648:	02500a13          	li	s4,37
 64c:	4c55                	li	s8,21
 64e:	00000c97          	auipc	s9,0x0
 652:	3f2c8c93          	addi	s9,s9,1010 # a40 <malloc+0x164>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 656:	02800d93          	li	s11,40
  putc(fd, 'x');
 65a:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 65c:	00000b97          	auipc	s7,0x0
 660:	43cb8b93          	addi	s7,s7,1084 # a98 <digits>
 664:	a839                	j	682 <vprintf+0x6a>
        putc(fd, c);
 666:	85ca                	mv	a1,s2
 668:	8556                	mv	a0,s5
 66a:	00000097          	auipc	ra,0x0
 66e:	ee0080e7          	jalr	-288(ra) # 54a <putc>
 672:	a019                	j	678 <vprintf+0x60>
    } else if(state == '%'){
 674:	01498d63          	beq	s3,s4,68e <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 678:	0485                	addi	s1,s1,1
 67a:	fff4c903          	lbu	s2,-1(s1)
 67e:	14090d63          	beqz	s2,7d8 <vprintf+0x1c0>
    if(state == 0){
 682:	fe0999e3          	bnez	s3,674 <vprintf+0x5c>
      if(c == '%'){
 686:	ff4910e3          	bne	s2,s4,666 <vprintf+0x4e>
        state = '%';
 68a:	89d2                	mv	s3,s4
 68c:	b7f5                	j	678 <vprintf+0x60>
      if(c == 'd'){
 68e:	11490c63          	beq	s2,s4,7a6 <vprintf+0x18e>
 692:	f9d9079b          	addiw	a5,s2,-99
 696:	0ff7f793          	zext.b	a5,a5
 69a:	10fc6e63          	bltu	s8,a5,7b6 <vprintf+0x19e>
 69e:	f9d9079b          	addiw	a5,s2,-99
 6a2:	0ff7f713          	zext.b	a4,a5
 6a6:	10ec6863          	bltu	s8,a4,7b6 <vprintf+0x19e>
 6aa:	00271793          	slli	a5,a4,0x2
 6ae:	97e6                	add	a5,a5,s9
 6b0:	439c                	lw	a5,0(a5)
 6b2:	97e6                	add	a5,a5,s9
 6b4:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 6b6:	008b0913          	addi	s2,s6,8
 6ba:	4685                	li	a3,1
 6bc:	4629                	li	a2,10
 6be:	000b2583          	lw	a1,0(s6)
 6c2:	8556                	mv	a0,s5
 6c4:	00000097          	auipc	ra,0x0
 6c8:	ea8080e7          	jalr	-344(ra) # 56c <printint>
 6cc:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6ce:	4981                	li	s3,0
 6d0:	b765                	j	678 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6d2:	008b0913          	addi	s2,s6,8
 6d6:	4681                	li	a3,0
 6d8:	4629                	li	a2,10
 6da:	000b2583          	lw	a1,0(s6)
 6de:	8556                	mv	a0,s5
 6e0:	00000097          	auipc	ra,0x0
 6e4:	e8c080e7          	jalr	-372(ra) # 56c <printint>
 6e8:	8b4a                	mv	s6,s2
      state = 0;
 6ea:	4981                	li	s3,0
 6ec:	b771                	j	678 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 6ee:	008b0913          	addi	s2,s6,8
 6f2:	4681                	li	a3,0
 6f4:	866a                	mv	a2,s10
 6f6:	000b2583          	lw	a1,0(s6)
 6fa:	8556                	mv	a0,s5
 6fc:	00000097          	auipc	ra,0x0
 700:	e70080e7          	jalr	-400(ra) # 56c <printint>
 704:	8b4a                	mv	s6,s2
      state = 0;
 706:	4981                	li	s3,0
 708:	bf85                	j	678 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 70a:	008b0793          	addi	a5,s6,8
 70e:	f8f43423          	sd	a5,-120(s0)
 712:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 716:	03000593          	li	a1,48
 71a:	8556                	mv	a0,s5
 71c:	00000097          	auipc	ra,0x0
 720:	e2e080e7          	jalr	-466(ra) # 54a <putc>
  putc(fd, 'x');
 724:	07800593          	li	a1,120
 728:	8556                	mv	a0,s5
 72a:	00000097          	auipc	ra,0x0
 72e:	e20080e7          	jalr	-480(ra) # 54a <putc>
 732:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 734:	03c9d793          	srli	a5,s3,0x3c
 738:	97de                	add	a5,a5,s7
 73a:	0007c583          	lbu	a1,0(a5)
 73e:	8556                	mv	a0,s5
 740:	00000097          	auipc	ra,0x0
 744:	e0a080e7          	jalr	-502(ra) # 54a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 748:	0992                	slli	s3,s3,0x4
 74a:	397d                	addiw	s2,s2,-1
 74c:	fe0914e3          	bnez	s2,734 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 750:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 754:	4981                	li	s3,0
 756:	b70d                	j	678 <vprintf+0x60>
        s = va_arg(ap, char*);
 758:	008b0913          	addi	s2,s6,8
 75c:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 760:	02098163          	beqz	s3,782 <vprintf+0x16a>
        while(*s != 0){
 764:	0009c583          	lbu	a1,0(s3)
 768:	c5ad                	beqz	a1,7d2 <vprintf+0x1ba>
          putc(fd, *s);
 76a:	8556                	mv	a0,s5
 76c:	00000097          	auipc	ra,0x0
 770:	dde080e7          	jalr	-546(ra) # 54a <putc>
          s++;
 774:	0985                	addi	s3,s3,1
        while(*s != 0){
 776:	0009c583          	lbu	a1,0(s3)
 77a:	f9e5                	bnez	a1,76a <vprintf+0x152>
        s = va_arg(ap, char*);
 77c:	8b4a                	mv	s6,s2
      state = 0;
 77e:	4981                	li	s3,0
 780:	bde5                	j	678 <vprintf+0x60>
          s = "(null)";
 782:	00000997          	auipc	s3,0x0
 786:	2b698993          	addi	s3,s3,694 # a38 <malloc+0x15c>
        while(*s != 0){
 78a:	85ee                	mv	a1,s11
 78c:	bff9                	j	76a <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 78e:	008b0913          	addi	s2,s6,8
 792:	000b4583          	lbu	a1,0(s6)
 796:	8556                	mv	a0,s5
 798:	00000097          	auipc	ra,0x0
 79c:	db2080e7          	jalr	-590(ra) # 54a <putc>
 7a0:	8b4a                	mv	s6,s2
      state = 0;
 7a2:	4981                	li	s3,0
 7a4:	bdd1                	j	678 <vprintf+0x60>
        putc(fd, c);
 7a6:	85d2                	mv	a1,s4
 7a8:	8556                	mv	a0,s5
 7aa:	00000097          	auipc	ra,0x0
 7ae:	da0080e7          	jalr	-608(ra) # 54a <putc>
      state = 0;
 7b2:	4981                	li	s3,0
 7b4:	b5d1                	j	678 <vprintf+0x60>
        putc(fd, '%');
 7b6:	85d2                	mv	a1,s4
 7b8:	8556                	mv	a0,s5
 7ba:	00000097          	auipc	ra,0x0
 7be:	d90080e7          	jalr	-624(ra) # 54a <putc>
        putc(fd, c);
 7c2:	85ca                	mv	a1,s2
 7c4:	8556                	mv	a0,s5
 7c6:	00000097          	auipc	ra,0x0
 7ca:	d84080e7          	jalr	-636(ra) # 54a <putc>
      state = 0;
 7ce:	4981                	li	s3,0
 7d0:	b565                	j	678 <vprintf+0x60>
        s = va_arg(ap, char*);
 7d2:	8b4a                	mv	s6,s2
      state = 0;
 7d4:	4981                	li	s3,0
 7d6:	b54d                	j	678 <vprintf+0x60>
    }
  }
}
 7d8:	70e6                	ld	ra,120(sp)
 7da:	7446                	ld	s0,112(sp)
 7dc:	74a6                	ld	s1,104(sp)
 7de:	7906                	ld	s2,96(sp)
 7e0:	69e6                	ld	s3,88(sp)
 7e2:	6a46                	ld	s4,80(sp)
 7e4:	6aa6                	ld	s5,72(sp)
 7e6:	6b06                	ld	s6,64(sp)
 7e8:	7be2                	ld	s7,56(sp)
 7ea:	7c42                	ld	s8,48(sp)
 7ec:	7ca2                	ld	s9,40(sp)
 7ee:	7d02                	ld	s10,32(sp)
 7f0:	6de2                	ld	s11,24(sp)
 7f2:	6109                	addi	sp,sp,128
 7f4:	8082                	ret

00000000000007f6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7f6:	715d                	addi	sp,sp,-80
 7f8:	ec06                	sd	ra,24(sp)
 7fa:	e822                	sd	s0,16(sp)
 7fc:	1000                	addi	s0,sp,32
 7fe:	e010                	sd	a2,0(s0)
 800:	e414                	sd	a3,8(s0)
 802:	e818                	sd	a4,16(s0)
 804:	ec1c                	sd	a5,24(s0)
 806:	03043023          	sd	a6,32(s0)
 80a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 80e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 812:	8622                	mv	a2,s0
 814:	00000097          	auipc	ra,0x0
 818:	e04080e7          	jalr	-508(ra) # 618 <vprintf>
}
 81c:	60e2                	ld	ra,24(sp)
 81e:	6442                	ld	s0,16(sp)
 820:	6161                	addi	sp,sp,80
 822:	8082                	ret

0000000000000824 <printf>:

void
printf(const char *fmt, ...)
{
 824:	711d                	addi	sp,sp,-96
 826:	ec06                	sd	ra,24(sp)
 828:	e822                	sd	s0,16(sp)
 82a:	1000                	addi	s0,sp,32
 82c:	e40c                	sd	a1,8(s0)
 82e:	e810                	sd	a2,16(s0)
 830:	ec14                	sd	a3,24(s0)
 832:	f018                	sd	a4,32(s0)
 834:	f41c                	sd	a5,40(s0)
 836:	03043823          	sd	a6,48(s0)
 83a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 83e:	00840613          	addi	a2,s0,8
 842:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 846:	85aa                	mv	a1,a0
 848:	4505                	li	a0,1
 84a:	00000097          	auipc	ra,0x0
 84e:	dce080e7          	jalr	-562(ra) # 618 <vprintf>
}
 852:	60e2                	ld	ra,24(sp)
 854:	6442                	ld	s0,16(sp)
 856:	6125                	addi	sp,sp,96
 858:	8082                	ret

000000000000085a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 85a:	1141                	addi	sp,sp,-16
 85c:	e422                	sd	s0,8(sp)
 85e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 860:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 864:	00000797          	auipc	a5,0x0
 868:	79c7b783          	ld	a5,1948(a5) # 1000 <freep>
 86c:	a02d                	j	896 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 86e:	4618                	lw	a4,8(a2)
 870:	9f2d                	addw	a4,a4,a1
 872:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 876:	6398                	ld	a4,0(a5)
 878:	6310                	ld	a2,0(a4)
 87a:	a83d                	j	8b8 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 87c:	ff852703          	lw	a4,-8(a0)
 880:	9f31                	addw	a4,a4,a2
 882:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 884:	ff053683          	ld	a3,-16(a0)
 888:	a091                	j	8cc <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 88a:	6398                	ld	a4,0(a5)
 88c:	00e7e463          	bltu	a5,a4,894 <free+0x3a>
 890:	00e6ea63          	bltu	a3,a4,8a4 <free+0x4a>
{
 894:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 896:	fed7fae3          	bgeu	a5,a3,88a <free+0x30>
 89a:	6398                	ld	a4,0(a5)
 89c:	00e6e463          	bltu	a3,a4,8a4 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8a0:	fee7eae3          	bltu	a5,a4,894 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 8a4:	ff852583          	lw	a1,-8(a0)
 8a8:	6390                	ld	a2,0(a5)
 8aa:	02059813          	slli	a6,a1,0x20
 8ae:	01c85713          	srli	a4,a6,0x1c
 8b2:	9736                	add	a4,a4,a3
 8b4:	fae60de3          	beq	a2,a4,86e <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 8b8:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8bc:	4790                	lw	a2,8(a5)
 8be:	02061593          	slli	a1,a2,0x20
 8c2:	01c5d713          	srli	a4,a1,0x1c
 8c6:	973e                	add	a4,a4,a5
 8c8:	fae68ae3          	beq	a3,a4,87c <free+0x22>
    p->s.ptr = bp->s.ptr;
 8cc:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8ce:	00000717          	auipc	a4,0x0
 8d2:	72f73923          	sd	a5,1842(a4) # 1000 <freep>
}
 8d6:	6422                	ld	s0,8(sp)
 8d8:	0141                	addi	sp,sp,16
 8da:	8082                	ret

00000000000008dc <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8dc:	7139                	addi	sp,sp,-64
 8de:	fc06                	sd	ra,56(sp)
 8e0:	f822                	sd	s0,48(sp)
 8e2:	f426                	sd	s1,40(sp)
 8e4:	f04a                	sd	s2,32(sp)
 8e6:	ec4e                	sd	s3,24(sp)
 8e8:	e852                	sd	s4,16(sp)
 8ea:	e456                	sd	s5,8(sp)
 8ec:	e05a                	sd	s6,0(sp)
 8ee:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8f0:	02051493          	slli	s1,a0,0x20
 8f4:	9081                	srli	s1,s1,0x20
 8f6:	04bd                	addi	s1,s1,15
 8f8:	8091                	srli	s1,s1,0x4
 8fa:	0014899b          	addiw	s3,s1,1
 8fe:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 900:	00000517          	auipc	a0,0x0
 904:	70053503          	ld	a0,1792(a0) # 1000 <freep>
 908:	c515                	beqz	a0,934 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 90a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 90c:	4798                	lw	a4,8(a5)
 90e:	02977f63          	bgeu	a4,s1,94c <malloc+0x70>
 912:	8a4e                	mv	s4,s3
 914:	0009871b          	sext.w	a4,s3
 918:	6685                	lui	a3,0x1
 91a:	00d77363          	bgeu	a4,a3,920 <malloc+0x44>
 91e:	6a05                	lui	s4,0x1
 920:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 924:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 928:	00000917          	auipc	s2,0x0
 92c:	6d890913          	addi	s2,s2,1752 # 1000 <freep>
  if(p == (char*)-1)
 930:	5afd                	li	s5,-1
 932:	a895                	j	9a6 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 934:	00000797          	auipc	a5,0x0
 938:	6dc78793          	addi	a5,a5,1756 # 1010 <base>
 93c:	00000717          	auipc	a4,0x0
 940:	6cf73223          	sd	a5,1732(a4) # 1000 <freep>
 944:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 946:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 94a:	b7e1                	j	912 <malloc+0x36>
      if(p->s.size == nunits)
 94c:	02e48c63          	beq	s1,a4,984 <malloc+0xa8>
        p->s.size -= nunits;
 950:	4137073b          	subw	a4,a4,s3
 954:	c798                	sw	a4,8(a5)
        p += p->s.size;
 956:	02071693          	slli	a3,a4,0x20
 95a:	01c6d713          	srli	a4,a3,0x1c
 95e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 960:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 964:	00000717          	auipc	a4,0x0
 968:	68a73e23          	sd	a0,1692(a4) # 1000 <freep>
      return (void*)(p + 1);
 96c:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 970:	70e2                	ld	ra,56(sp)
 972:	7442                	ld	s0,48(sp)
 974:	74a2                	ld	s1,40(sp)
 976:	7902                	ld	s2,32(sp)
 978:	69e2                	ld	s3,24(sp)
 97a:	6a42                	ld	s4,16(sp)
 97c:	6aa2                	ld	s5,8(sp)
 97e:	6b02                	ld	s6,0(sp)
 980:	6121                	addi	sp,sp,64
 982:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 984:	6398                	ld	a4,0(a5)
 986:	e118                	sd	a4,0(a0)
 988:	bff1                	j	964 <malloc+0x88>
  hp->s.size = nu;
 98a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 98e:	0541                	addi	a0,a0,16
 990:	00000097          	auipc	ra,0x0
 994:	eca080e7          	jalr	-310(ra) # 85a <free>
  return freep;
 998:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 99c:	d971                	beqz	a0,970 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 99e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9a0:	4798                	lw	a4,8(a5)
 9a2:	fa9775e3          	bgeu	a4,s1,94c <malloc+0x70>
    if(p == freep)
 9a6:	00093703          	ld	a4,0(s2)
 9aa:	853e                	mv	a0,a5
 9ac:	fef719e3          	bne	a4,a5,99e <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 9b0:	8552                	mv	a0,s4
 9b2:	00000097          	auipc	ra,0x0
 9b6:	b78080e7          	jalr	-1160(ra) # 52a <sbrk>
  if(p == (char*)-1)
 9ba:	fd5518e3          	bne	a0,s5,98a <malloc+0xae>
        return 0;
 9be:	4501                	li	a0,0
 9c0:	bf45                	j	970 <malloc+0x94>
