
user/_my_shell:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <readLine>:
    - read in user input 
    - return 1 when it has replaced the newline character with \0
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
    // constantly display command prompt
    write(2, ">>> ", 4);
  10:	4611                	li	a2,4
  12:	00001597          	auipc	a1,0x1
  16:	cbe58593          	addi	a1,a1,-834 # cd0 <malloc+0xea>
  1a:	4509                	li	a0,2
  1c:	00000097          	auipc	ra,0x0
  20:	7b0080e7          	jalr	1968(ra) # 7cc <write>

    // read input from user
    // gets(buffer, bufferSize);
    read(0, buffer, bufferSize);
  24:	864a                	mv	a2,s2
  26:	85a6                	mv	a1,s1
  28:	4501                	li	a0,0
  2a:	00000097          	auipc	ra,0x0
  2e:	79a080e7          	jalr	1946(ra) # 7c4 <read>


    // if the user just presses enter, exit function (this is so it is called again in the while loop so that the command prompt will be printed agaim)
    if (strlen(buffer) == 1)
  32:	8526                	mv	a0,s1
  34:	00000097          	auipc	ra,0x0
  38:	554080e7          	jalr	1364(ra) # 588 <strlen>
  3c:	2501                	sext.w	a0,a0
  3e:	4785                	li	a5,1
  40:	02f50363          	beq	a0,a5,66 <readLine+0x66>
    }

    // if we read in a < or > and \n then checkRedirection will be equal to 1.
    // if we only read in a \n then status = 0
    // initialize to 0 for now
    int checkLineStatus = 0;
  44:	4501                	li	a0,0
    
    
    
    // for loop to replace the newline character and replace it with a null-terminating character
    // once 1 has been returned, this is an indication to the main function that the line has been read and processed, so now it is ready to be formatted to execute
    for (int i=0; i<bufferSize; i++)
  46:	05205c63          	blez	s2,9e <readLine+0x9e>
  4a:	87a6                	mv	a5,s1
  4c:	00148693          	addi	a3,s1,1
  50:	397d                	addiw	s2,s2,-1
  52:	1902                	slli	s2,s2,0x20
  54:	02095913          	srli	s2,s2,0x20
  58:	96ca                	add	a3,a3,s2
    int checkLineStatus = 0;
  5a:	4501                	li	a0,0
    {
        if(buffer[i] == '<' || buffer[i] == '>')
  5c:	03c00813          	li	a6,60
        {
            checkLineStatus = 1;
  60:	4305                	li	t1,1
        }

        if (buffer[i] == '\n')
  62:	45a9                	li	a1,10
  64:	a015                	j	88 <readLine+0x88>
        write(2, "\n", 2);
  66:	4609                	li	a2,2
  68:	00001597          	auipc	a1,0x1
  6c:	c7058593          	addi	a1,a1,-912 # cd8 <malloc+0xf2>
  70:	4509                	li	a0,2
  72:	00000097          	auipc	ra,0x0
  76:	75a080e7          	jalr	1882(ra) # 7cc <write>
        return 0;
  7a:	4501                	li	a0,0
  7c:	a00d                	j	9e <readLine+0x9e>
        if (buffer[i] == '\n')
  7e:	00b70e63          	beq	a4,a1,9a <readLine+0x9a>
    for (int i=0; i<bufferSize; i++)
  82:	0785                	addi	a5,a5,1
  84:	00d78d63          	beq	a5,a3,9e <readLine+0x9e>
        if(buffer[i] == '<' || buffer[i] == '>')
  88:	88be                	mv	a7,a5
  8a:	0007c703          	lbu	a4,0(a5)
  8e:	0fd77613          	andi	a2,a4,253
  92:	ff0616e3          	bne	a2,a6,7e <readLine+0x7e>
            checkLineStatus = 1;
  96:	851a                	mv	a0,t1
  98:	b7dd                	j	7e <readLine+0x7e>
        {
            buffer[i] = '\0';
  9a:	00088023          	sb	zero,0(a7)
            break;
            
        }
    }
    return checkLineStatus;
}
  9e:	60e2                	ld	ra,24(sp)
  a0:	6442                	ld	s0,16(sp)
  a2:	64a2                	ld	s1,8(sp)
  a4:	6902                	ld	s2,0(sp)
  a6:	6105                	addi	sp,sp,32
  a8:	8082                	ret

00000000000000aa <separateRedirection>:
    - if > then set to 2.
    - 
*/
int
separateRedirection(char *buffer, char *args[], char *redirectionFile , const int bufSize, int redirectionStatus)
{
  aa:	1141                	addi	sp,sp,-16
  ac:	e422                	sd	s0,8(sp)
  ae:	0800                	addi	s0,sp,16
    // iterate through buffer and when we reach the < or > characters we set the pointer to this index.
    // replace < or > with null terminating character

    int i;
    for (i=0; i < bufSize; i++)
  b0:	06d05c63          	blez	a3,128 <separateRedirection+0x7e>
  b4:	882a                	mv	a6,a0
  b6:	87aa                	mv	a5,a0
  b8:	4581                	li	a1,0
    {
        if (buffer[i] == ' ')
  ba:	02000513          	li	a0,32
        {
            continue;
        }
        
        if (buffer[i] == '<' || buffer[i] == '>')
  be:	03c00313          	li	t1,60
  c2:	03e00e13          	li	t3,62
  c6:	a0a1                	j	10e <separateRedirection+0x64>
        {
            redirectionStatus = (buffer[i] == '<') ? 1 : 2;
  c8:	4505                	li	a0,1
            buffer[i] = '\0';
  ca:	00088023          	sb	zero,0(a7)
            break; // we have found the index where the < or > operators start, break from loop

        }  
    }

    if (i < bufSize)
  ce:	04d5dd63          	bge	a1,a3,128 <separateRedirection+0x7e>
    {
        int j = 0;
        for (i++; i<bufSize && buffer[i] != '\0'; i++, j++)
  d2:	0015879b          	addiw	a5,a1,1
  d6:	04d7d763          	bge	a5,a3,124 <separateRedirection+0x7a>
  da:	97c2                	add	a5,a5,a6
  dc:	8832                	mv	a6,a2
  de:	36fd                	addiw	a3,a3,-1
  e0:	9e8d                	subw	a3,a3,a1
        int j = 0;
  e2:	4701                	li	a4,0
        for (i++; i<bufSize && buffer[i] != '\0'; i++, j++)
  e4:	0007c583          	lbu	a1,0(a5)
  e8:	c989                	beqz	a1,fa <separateRedirection+0x50>
        {
            redirectionFile[j] = buffer[i];
  ea:	00b80023          	sb	a1,0(a6)
        for (i++; i<bufSize && buffer[i] != '\0'; i++, j++)
  ee:	2705                	addiw	a4,a4,1
  f0:	0785                	addi	a5,a5,1
  f2:	0805                	addi	a6,a6,1
  f4:	fed718e3          	bne	a4,a3,e4 <separateRedirection+0x3a>
  f8:	8736                	mv	a4,a3
        }     
        redirectionFile[j] = '\0';
  fa:	963a                	add	a2,a2,a4
  fc:	00060023          	sb	zero,0(a2)
        redirectionFile[0] = '\0';
        redirectionStatus = 0;
    }

    return redirectionStatus;
}
 100:	6422                	ld	s0,8(sp)
 102:	0141                	addi	sp,sp,16
 104:	8082                	ret
    for (i=0; i < bufSize; i++)
 106:	2585                	addiw	a1,a1,1
 108:	0785                	addi	a5,a5,1
 10a:	00b68f63          	beq	a3,a1,128 <separateRedirection+0x7e>
        if (buffer[i] == ' ')
 10e:	88be                	mv	a7,a5
 110:	0007c703          	lbu	a4,0(a5)
 114:	fea709e3          	beq	a4,a0,106 <separateRedirection+0x5c>
        if (buffer[i] == '<' || buffer[i] == '>')
 118:	fa6708e3          	beq	a4,t1,c8 <separateRedirection+0x1e>
 11c:	ffc715e3          	bne	a4,t3,106 <separateRedirection+0x5c>
            redirectionStatus = (buffer[i] == '<') ? 1 : 2;
 120:	4509                	li	a0,2
 122:	b765                	j	ca <separateRedirection+0x20>
        int j = 0;
 124:	4701                	li	a4,0
 126:	bfd1                	j	fa <separateRedirection+0x50>
        redirectionFile[0] = '\0';
 128:	00060023          	sb	zero,0(a2)
        redirectionStatus = 0;
 12c:	4501                	li	a0,0
 12e:	bfc9                	j	100 <separateRedirection+0x56>

0000000000000130 <handlecd>:
    - file descriptors then have to be restored back to STDIN and STDOUT before we read our next line
*/
// function to change directory
int
handlecd(char *args[])
{
 130:	1141                	addi	sp,sp,-16
 132:	e406                	sd	ra,8(sp)
 134:	e022                	sd	s0,0(sp)
 136:	0800                	addi	s0,sp,16
    int dirCheck  = chdir(args[1]);
 138:	6508                	ld	a0,8(a0)
 13a:	00000097          	auipc	ra,0x0
 13e:	6e2080e7          	jalr	1762(ra) # 81c <chdir>
    
    if(dirCheck < 0)
 142:	00054763          	bltz	a0,150 <handlecd+0x20>
    {   
        printf("cd error : exiting");
        exit(1);
    }
    return 0;
}
 146:	4501                	li	a0,0
 148:	60a2                	ld	ra,8(sp)
 14a:	6402                	ld	s0,0(sp)
 14c:	0141                	addi	sp,sp,16
 14e:	8082                	ret
        printf("cd error : exiting");
 150:	00001517          	auipc	a0,0x1
 154:	b9050513          	addi	a0,a0,-1136 # ce0 <malloc+0xfa>
 158:	00001097          	auipc	ra,0x1
 15c:	9d6080e7          	jalr	-1578(ra) # b2e <printf>
        exit(1);
 160:	4505                	li	a0,1
 162:	00000097          	auipc	ra,0x0
 166:	64a080e7          	jalr	1610(ra) # 7ac <exit>

000000000000016a <formatLine>:

void
formatLine(char *buffer, char *args[], char *redirectionFile, int redirectionStatus)
{
 16a:	7139                	addi	sp,sp,-64
 16c:	fc06                	sd	ra,56(sp)
 16e:	f822                	sd	s0,48(sp)
 170:	f426                	sd	s1,40(sp)
 172:	f04a                	sd	s2,32(sp)
 174:	ec4e                	sd	s3,24(sp)
 176:	e852                	sd	s4,16(sp)
 178:	0080                	addi	s0,sp,64
 17a:	84aa                	mv	s1,a0
 17c:	89ae                	mv	s3,a1
 17e:	8a32                	mv	s4,a2
 180:	8936                	mv	s2,a3

    // create a new process 
    int pid = fork();
 182:	00000097          	auipc	ra,0x0
 186:	622080e7          	jalr	1570(ra) # 7a4 <fork>

    // verify fork has worked
    if (pid < 0)
 18a:	00054d63          	bltz	a0,1a4 <formatLine+0x3a>
    {
        printf("Fork failed");
        exit(1);

    } else if(pid == 0) // verify that we are in the child process
 18e:	22051163          	bnez	a0,3b0 <formatLine+0x246>


        Finally, at the end of the loop we should increment bufferPointer. Once we reach a null-terminating character, we should break out the loop and use exec to run our command 
        */

        while (*bufferPointer != '\0') {
 192:	0004c783          	lbu	a5,0(s1)
 196:	c3b9                	beqz	a5,1dc <formatLine+0x72>
        argumentPointer = &args[0];
 198:	86ce                	mv	a3,s3
        int wordstart = 1;
 19a:	4705                	li	a4,1
            if (*bufferPointer != ' ') 
 19c:	02000813          	li	a6,32

                    *bufferPointer = '\0';

                    argumentPointer++;

                    wordstart = 1;
 1a0:	4605                	li	a2,1
 1a2:	a03d                	j	1d0 <formatLine+0x66>
        printf("Fork failed");
 1a4:	00001517          	auipc	a0,0x1
 1a8:	b5450513          	addi	a0,a0,-1196 # cf8 <malloc+0x112>
 1ac:	00001097          	auipc	ra,0x1
 1b0:	982080e7          	jalr	-1662(ra) # b2e <printf>
        exit(1);
 1b4:	4505                	li	a0,1
 1b6:	00000097          	auipc	ra,0x0
 1ba:	5f6080e7          	jalr	1526(ra) # 7ac <exit>
                if (!wordstart) 
 1be:	e709                	bnez	a4,1c8 <formatLine+0x5e>
                    *bufferPointer = '\0';
 1c0:	00048023          	sb	zero,0(s1)
                    argumentPointer++;
 1c4:	06a1                	addi	a3,a3,8
                    wordstart = 1;
 1c6:	8732                	mv	a4,a2
                }
            }

        bufferPointer++;
 1c8:	0485                	addi	s1,s1,1
        while (*bufferPointer != '\0') {
 1ca:	0004c783          	lbu	a5,0(s1)
 1ce:	c799                	beqz	a5,1dc <formatLine+0x72>
            if (*bufferPointer != ' ') 
 1d0:	ff0787e3          	beq	a5,a6,1be <formatLine+0x54>
                if (wordstart)
 1d4:	db75                	beqz	a4,1c8 <formatLine+0x5e>
                    *argumentPointer = bufferPointer;
 1d6:	e284                	sd	s1,0(a3)
                    wordstart = 0;
 1d8:	872a                	mv	a4,a0
 1da:	b7fd                	j	1c8 <formatLine+0x5e>
        }

        // redirection handling
        if (redirectionStatus > 0)
 1dc:	17205e63          	blez	s2,358 <formatLine+0x1ee>
        {
        
            if (redirectionStatus == 1)
 1e0:	4785                	li	a5,1
 1e2:	08f90163          	beq	s2,a5,264 <formatLine+0xfa>
                // file descriptor 0 is free, so now lets dup our copy that we saved earlier and it will store it in fd 0. we can then close our copy.
                dup(STDIN_fileDescriptor);
                close(STDIN_fileDescriptor);
            
            }
            else if (redirectionStatus == 2)
 1e6:	4789                	li	a5,2
 1e8:	1cf91963          	bne	s2,a5,3ba <formatLine+0x250>
            {
                 // open redirection file in required modes. this will be stored in next avaliable fd.
                int fileDescriptor = open(redirectionFile, O_WRONLY | O_CREATE | O_TRUNC); 
 1ec:	60100593          	li	a1,1537
 1f0:	8552                	mv	a0,s4
 1f2:	00000097          	auipc	ra,0x0
 1f6:	5fa080e7          	jalr	1530(ra) # 7ec <open>
 1fa:	84aa                	mv	s1,a0
                
                if (fileDescriptor == -1)
 1fc:	57fd                	li	a5,-1
 1fe:	10f50663          	beq	a0,a5,30a <formatLine+0x1a0>
                    exit(1);
                }

                // duplicate the standard output file descriptor. this will be stored in the next avaliable fd.
                // this is done so we can restore it later
                int STDOUT_fileDescriptor = dup(1);
 202:	4505                	li	a0,1
 204:	00000097          	auipc	ra,0x0
 208:	620080e7          	jalr	1568(ra) # 824 <dup>
 20c:	892a                	mv	s2,a0

                // close the original STDOUT file descriptor. this will now become free to use. 
                close(1);
 20e:	4505                	li	a0,1
 210:	00000097          	auipc	ra,0x0
 214:	5c4080e7          	jalr	1476(ra) # 7d4 <close>

                // duplicate our file that we have opened. because we closed file descriptor 1, this will be stored there as it is free. 
                int result = dup(fileDescriptor);
 218:	8526                	mv	a0,s1
 21a:	00000097          	auipc	ra,0x0
 21e:	60a080e7          	jalr	1546(ra) # 824 <dup>
 222:	8a2a                	mv	s4,a0

                //close our old copy
                close(fileDescriptor);
 224:	8526                	mv	a0,s1
 226:	00000097          	auipc	ra,0x0
 22a:	5ae080e7          	jalr	1454(ra) # 7d4 <close>

                // verify dup worled
                if (result < 0)
 22e:	0e0a4b63          	bltz	s4,324 <formatLine+0x1ba>

                
                // execute as normal. because we have changed STDOUT to our file, any output should go to our file now 
                

                if(exec(args[0], args) < 0)
 232:	85ce                	mv	a1,s3
 234:	0009b503          	ld	a0,0(s3)
 238:	00000097          	auipc	ra,0x0
 23c:	5ac080e7          	jalr	1452(ra) # 7e4 <exec>
 240:	0e054f63          	bltz	a0,33e <formatLine+0x1d4>
                    printf("Exec error : exiting\n");
                    exit(1);
                }

                // now we can close our file descriptor as we need to restore STDOUT
                close(1);
 244:	4505                	li	a0,1
 246:	00000097          	auipc	ra,0x0
 24a:	58e080e7          	jalr	1422(ra) # 7d4 <close>

                // file descriptor 1 is free, so now lets dup our copy that we saved earlier and it will store it in fd 1. we can then close our copy.
                dup(STDOUT_fileDescriptor);
 24e:	854a                	mv	a0,s2
 250:	00000097          	auipc	ra,0x0
 254:	5d4080e7          	jalr	1492(ra) # 824 <dup>
                close(STDOUT_fileDescriptor);
 258:	854a                	mv	a0,s2
 25a:	00000097          	auipc	ra,0x0
 25e:	57a080e7          	jalr	1402(ra) # 7d4 <close>
 262:	aaa1                	j	3ba <formatLine+0x250>
                int fileDescriptor = open(redirectionFile, O_RDONLY);
 264:	4581                	li	a1,0
 266:	8552                	mv	a0,s4
 268:	00000097          	auipc	ra,0x0
 26c:	584080e7          	jalr	1412(ra) # 7ec <open>
 270:	84aa                	mv	s1,a0
                if (fileDescriptor == -1)
 272:	57fd                	li	a5,-1
 274:	06f50163          	beq	a0,a5,2d6 <formatLine+0x16c>
                int STDIN_fileDescriptor = dup(0);
 278:	4501                	li	a0,0
 27a:	00000097          	auipc	ra,0x0
 27e:	5aa080e7          	jalr	1450(ra) # 824 <dup>
 282:	892a                	mv	s2,a0
                close(0);
 284:	4501                	li	a0,0
 286:	00000097          	auipc	ra,0x0
 28a:	54e080e7          	jalr	1358(ra) # 7d4 <close>
                int result = dup(fileDescriptor);
 28e:	8526                	mv	a0,s1
 290:	00000097          	auipc	ra,0x0
 294:	594080e7          	jalr	1428(ra) # 824 <dup>
 298:	8a2a                	mv	s4,a0
                close(fileDescriptor);
 29a:	8526                	mv	a0,s1
 29c:	00000097          	auipc	ra,0x0
 2a0:	538080e7          	jalr	1336(ra) # 7d4 <close>
                if (result < 0)
 2a4:	040a4663          	bltz	s4,2f0 <formatLine+0x186>
                exec(args[0], args);
 2a8:	85ce                	mv	a1,s3
 2aa:	0009b503          	ld	a0,0(s3)
 2ae:	00000097          	auipc	ra,0x0
 2b2:	536080e7          	jalr	1334(ra) # 7e4 <exec>
                close(0);
 2b6:	4501                	li	a0,0
 2b8:	00000097          	auipc	ra,0x0
 2bc:	51c080e7          	jalr	1308(ra) # 7d4 <close>
                dup(STDIN_fileDescriptor);
 2c0:	854a                	mv	a0,s2
 2c2:	00000097          	auipc	ra,0x0
 2c6:	562080e7          	jalr	1378(ra) # 824 <dup>
                close(STDIN_fileDescriptor);
 2ca:	854a                	mv	a0,s2
 2cc:	00000097          	auipc	ra,0x0
 2d0:	508080e7          	jalr	1288(ra) # 7d4 <close>
 2d4:	a0dd                	j	3ba <formatLine+0x250>
                    printf("File open error : exiting");
 2d6:	00001517          	auipc	a0,0x1
 2da:	a3250513          	addi	a0,a0,-1486 # d08 <malloc+0x122>
 2de:	00001097          	auipc	ra,0x1
 2e2:	850080e7          	jalr	-1968(ra) # b2e <printf>
                    exit(1);
 2e6:	4505                	li	a0,1
 2e8:	00000097          	auipc	ra,0x0
 2ec:	4c4080e7          	jalr	1220(ra) # 7ac <exit>
                    printf("Dup error : exiting");
 2f0:	00001517          	auipc	a0,0x1
 2f4:	a3850513          	addi	a0,a0,-1480 # d28 <malloc+0x142>
 2f8:	00001097          	auipc	ra,0x1
 2fc:	836080e7          	jalr	-1994(ra) # b2e <printf>
                    exit(1);
 300:	4505                	li	a0,1
 302:	00000097          	auipc	ra,0x0
 306:	4aa080e7          	jalr	1194(ra) # 7ac <exit>
                    printf("File open error : exiting");
 30a:	00001517          	auipc	a0,0x1
 30e:	9fe50513          	addi	a0,a0,-1538 # d08 <malloc+0x122>
 312:	00001097          	auipc	ra,0x1
 316:	81c080e7          	jalr	-2020(ra) # b2e <printf>
                    exit(1);
 31a:	4505                	li	a0,1
 31c:	00000097          	auipc	ra,0x0
 320:	490080e7          	jalr	1168(ra) # 7ac <exit>
                    printf("Dup error : exiting");
 324:	00001517          	auipc	a0,0x1
 328:	a0450513          	addi	a0,a0,-1532 # d28 <malloc+0x142>
 32c:	00001097          	auipc	ra,0x1
 330:	802080e7          	jalr	-2046(ra) # b2e <printf>
                    exit(1);
 334:	4505                	li	a0,1
 336:	00000097          	auipc	ra,0x0
 33a:	476080e7          	jalr	1142(ra) # 7ac <exit>
                    printf("Exec error : exiting\n");
 33e:	00001517          	auipc	a0,0x1
 342:	a0250513          	addi	a0,a0,-1534 # d40 <malloc+0x15a>
 346:	00000097          	auipc	ra,0x0
 34a:	7e8080e7          	jalr	2024(ra) # b2e <printf>
                    exit(1);
 34e:	4505                	li	a0,1
 350:	00000097          	auipc	ra,0x0
 354:	45c080e7          	jalr	1116(ra) # 7ac <exit>
            } 
        }
        else 
        {   
            char cd[] = "cd";
 358:	6799                	lui	a5,0x6
 35a:	46378793          	addi	a5,a5,1123 # 6463 <base+0x5453>
 35e:	fcf41423          	sh	a5,-56(s0)
 362:	fc040523          	sb	zero,-54(s0)
            
            if (strcmp(args[0], cd) == 0)
 366:	fc840593          	addi	a1,s0,-56
 36a:	0009b503          	ld	a0,0(s3)
 36e:	00000097          	auipc	ra,0x0
 372:	1ee080e7          	jalr	494(ra) # 55c <strcmp>
 376:	e519                	bnez	a0,384 <formatLine+0x21a>
            {
                handlecd(args);
 378:	854e                	mv	a0,s3
 37a:	00000097          	auipc	ra,0x0
 37e:	db6080e7          	jalr	-586(ra) # 130 <handlecd>
 382:	a825                	j	3ba <formatLine+0x250>
            }
            
            // execute commands 
            else if(exec(args[0], args) < 0)
 384:	85ce                	mv	a1,s3
 386:	0009b503          	ld	a0,0(s3)
 38a:	00000097          	auipc	ra,0x0
 38e:	45a080e7          	jalr	1114(ra) # 7e4 <exec>
 392:	02055463          	bgez	a0,3ba <formatLine+0x250>
            {
                printf("Exec error : exiting\n");
 396:	00001517          	auipc	a0,0x1
 39a:	9aa50513          	addi	a0,a0,-1622 # d40 <malloc+0x15a>
 39e:	00000097          	auipc	ra,0x0
 3a2:	790080e7          	jalr	1936(ra) # b2e <printf>
                exit(1);
 3a6:	4505                	li	a0,1
 3a8:	00000097          	auipc	ra,0x0
 3ac:	404080e7          	jalr	1028(ra) # 7ac <exit>
            }
        }      

    } else // parent waits for child
    {
        wait(0);
 3b0:	4501                	li	a0,0
 3b2:	00000097          	auipc	ra,0x0
 3b6:	402080e7          	jalr	1026(ra) # 7b4 <wait>
    }    
}
 3ba:	70e2                	ld	ra,56(sp)
 3bc:	7442                	ld	s0,48(sp)
 3be:	74a2                	ld	s1,40(sp)
 3c0:	7902                	ld	s2,32(sp)
 3c2:	69e2                	ld	s3,24(sp)
 3c4:	6a42                	ld	s4,16(sp)
 3c6:	6121                	addi	sp,sp,64
 3c8:	8082                	ret

00000000000003ca <removeLeadingSpaces>:

// function to remove leading spaces from extracted fileName
void
removeLeadingSpaces(char *file, char *newFile)
{
 3ca:	1141                	addi	sp,sp,-16
 3cc:	e422                	sd	s0,8(sp)
 3ce:	0800                	addi	s0,sp,16
    int i = 0;

    while (file[i] == ' ' || file[i] == '\t' || file[i] == '\n')
 3d0:	4781                	li	a5,0
 3d2:	02000813          	li	a6,32
 3d6:	4885                	li	a7,1
 3d8:	a011                	j	3dc <removeLeadingSpaces+0x12>
    {
        i++;
 3da:	0785                	addi	a5,a5,1
 3dc:	0007861b          	sext.w	a2,a5
    while (file[i] == ' ' || file[i] == '\t' || file[i] == '\n')
 3e0:	00f50733          	add	a4,a0,a5
 3e4:	00074703          	lbu	a4,0(a4)
 3e8:	ff0709e3          	beq	a4,a6,3da <removeLeadingSpaces+0x10>
 3ec:	ff77069b          	addiw	a3,a4,-9
 3f0:	0ff6f693          	zext.b	a3,a3
 3f4:	fed8f3e3          	bgeu	a7,a3,3da <removeLeadingSpaces+0x10>
    }

    int k = 0;

    for(int j = i; file[j] != '\0'; j++)
 3f8:	c70d                	beqz	a4,422 <removeLeadingSpaces+0x58>
 3fa:	4785                	li	a5,1
    {
        newFile[k] = file[j];
 3fc:	00f586b3          	add	a3,a1,a5
 400:	fee68fa3          	sb	a4,-1(a3)
        k++;
 404:	0007869b          	sext.w	a3,a5
    for(int j = i; file[j] != '\0'; j++)
 408:	0785                	addi	a5,a5,1
 40a:	00f60733          	add	a4,a2,a5
 40e:	972a                	add	a4,a4,a0
 410:	fff74703          	lbu	a4,-1(a4)
 414:	f765                	bnez	a4,3fc <removeLeadingSpaces+0x32>
    }
    newFile[k] = '\0';  
 416:	95b6                	add	a1,a1,a3
 418:	00058023          	sb	zero,0(a1)
}
 41c:	6422                	ld	s0,8(sp)
 41e:	0141                	addi	sp,sp,16
 420:	8082                	ret
    int k = 0;
 422:	4681                	li	a3,0
 424:	bfcd                	j	416 <removeLeadingSpaces+0x4c>

0000000000000426 <main>:

int 
main(int argc, char *argv[]) 
{
 426:	ac010113          	addi	sp,sp,-1344
 42a:	52113c23          	sd	ra,1336(sp)
 42e:	52813823          	sd	s0,1328(sp)
 432:	52913423          	sd	s1,1320(sp)
 436:	53213023          	sd	s2,1312(sp)
 43a:	51313c23          	sd	s3,1304(sp)
 43e:	51413823          	sd	s4,1296(sp)
 442:	51513423          	sd	s5,1288(sp)
 446:	51613023          	sd	s6,1280(sp)
 44a:	54010413          	addi	s0,sp,1344
        {
            formatLine(newBuffer, args, redirectionFile, redirectionStatus);
           
        }
        //redirection needed, extract filename from buffer, remove leading spaces and then format the rest of the buffer ready for execution
        else if (readLineStatus == 1)
 44e:	4a85                	li	s5,1
            formatLine(newBuffer, args, newRedirectionFile, separatedRedirection);
           
        }
        else 
        {
            printf("readLine error");
 450:	00001b17          	auipc	s6,0x1
 454:	908b0b13          	addi	s6,s6,-1784 # d58 <malloc+0x172>
 458:	a809                	j	46a <main+0x44>
        else if (readLineStatus == 1)
 45a:	09548663          	beq	s1,s5,4e6 <main+0xc0>
            printf("readLine error");
 45e:	855a                	mv	a0,s6
 460:	00000097          	auipc	ra,0x0
 464:	6ce080e7          	jalr	1742(ra) # b2e <printf>
 468:	814e                	mv	sp,s3
    {
 46a:	898a                	mv	s3,sp
        char buffer[BUFSIZE];    
 46c:	7101                	addi	sp,sp,-512
 46e:	890a                	mv	s2,sp
        char newBuffer[BUFSIZE];    
 470:	7101                	addi	sp,sp,-512
 472:	8a0a                	mv	s4,sp
        char* args[MAXARG] = { 0 };
 474:	10000613          	li	a2,256
 478:	4581                	li	a1,0
 47a:	ac040513          	addi	a0,s0,-1344
 47e:	00000097          	auipc	ra,0x0
 482:	134080e7          	jalr	308(ra) # 5b2 <memset>
        char redirectionFile[512] = { 0 };
 486:	bc043023          	sd	zero,-1088(s0)
 48a:	1f800613          	li	a2,504
 48e:	4581                	li	a1,0
 490:	bc840513          	addi	a0,s0,-1080
 494:	00000097          	auipc	ra,0x0
 498:	11e080e7          	jalr	286(ra) # 5b2 <memset>
        char newRedirectionFile[512] = { 0 };
 49c:	dc043023          	sd	zero,-576(s0)
 4a0:	1f800613          	li	a2,504
 4a4:	4581                	li	a1,0
 4a6:	dc840513          	addi	a0,s0,-568
 4aa:	00000097          	auipc	ra,0x0
 4ae:	108080e7          	jalr	264(ra) # 5b2 <memset>
        readLineStatus = readLine(buffer, BUFSIZE);
 4b2:	20000593          	li	a1,512
 4b6:	854a                	mv	a0,s2
 4b8:	00000097          	auipc	ra,0x0
 4bc:	b48080e7          	jalr	-1208(ra) # 0 <readLine>
 4c0:	84aa                	mv	s1,a0
        removeLeadingSpaces(buffer, newBuffer);
 4c2:	858a                	mv	a1,sp
 4c4:	854a                	mv	a0,s2
 4c6:	00000097          	auipc	ra,0x0
 4ca:	f04080e7          	jalr	-252(ra) # 3ca <removeLeadingSpaces>
        if (readLineStatus == 0)
 4ce:	f4d1                	bnez	s1,45a <main+0x34>
            formatLine(newBuffer, args, redirectionFile, redirectionStatus);
 4d0:	4681                	li	a3,0
 4d2:	bc040613          	addi	a2,s0,-1088
 4d6:	ac040593          	addi	a1,s0,-1344
 4da:	8552                	mv	a0,s4
 4dc:	00000097          	auipc	ra,0x0
 4e0:	c8e080e7          	jalr	-882(ra) # 16a <formatLine>
 4e4:	b751                	j	468 <main+0x42>
            int separatedRedirection = separateRedirection(newBuffer, args, redirectionFile, BUFSIZE, redirectionStatus);
 4e6:	4701                	li	a4,0
 4e8:	20000693          	li	a3,512
 4ec:	bc040613          	addi	a2,s0,-1088
 4f0:	ac040593          	addi	a1,s0,-1344
 4f4:	8552                	mv	a0,s4
 4f6:	00000097          	auipc	ra,0x0
 4fa:	bb4080e7          	jalr	-1100(ra) # aa <separateRedirection>
 4fe:	84aa                	mv	s1,a0
            removeLeadingSpaces(redirectionFile, newRedirectionFile);
 500:	dc040593          	addi	a1,s0,-576
 504:	bc040513          	addi	a0,s0,-1088
 508:	00000097          	auipc	ra,0x0
 50c:	ec2080e7          	jalr	-318(ra) # 3ca <removeLeadingSpaces>
            formatLine(newBuffer, args, newRedirectionFile, separatedRedirection);
 510:	86a6                	mv	a3,s1
 512:	dc040613          	addi	a2,s0,-576
 516:	ac040593          	addi	a1,s0,-1344
 51a:	8552                	mv	a0,s4
 51c:	00000097          	auipc	ra,0x0
 520:	c4e080e7          	jalr	-946(ra) # 16a <formatLine>
 524:	b791                	j	468 <main+0x42>

0000000000000526 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 526:	1141                	addi	sp,sp,-16
 528:	e406                	sd	ra,8(sp)
 52a:	e022                	sd	s0,0(sp)
 52c:	0800                	addi	s0,sp,16
  extern int main();
  main();
 52e:	00000097          	auipc	ra,0x0
 532:	ef8080e7          	jalr	-264(ra) # 426 <main>
  exit(0);
 536:	4501                	li	a0,0
 538:	00000097          	auipc	ra,0x0
 53c:	274080e7          	jalr	628(ra) # 7ac <exit>

0000000000000540 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 540:	1141                	addi	sp,sp,-16
 542:	e422                	sd	s0,8(sp)
 544:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 546:	87aa                	mv	a5,a0
 548:	0585                	addi	a1,a1,1
 54a:	0785                	addi	a5,a5,1
 54c:	fff5c703          	lbu	a4,-1(a1)
 550:	fee78fa3          	sb	a4,-1(a5)
 554:	fb75                	bnez	a4,548 <strcpy+0x8>
    ;
  return os;
}
 556:	6422                	ld	s0,8(sp)
 558:	0141                	addi	sp,sp,16
 55a:	8082                	ret

000000000000055c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 55c:	1141                	addi	sp,sp,-16
 55e:	e422                	sd	s0,8(sp)
 560:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 562:	00054783          	lbu	a5,0(a0)
 566:	cb91                	beqz	a5,57a <strcmp+0x1e>
 568:	0005c703          	lbu	a4,0(a1)
 56c:	00f71763          	bne	a4,a5,57a <strcmp+0x1e>
    p++, q++;
 570:	0505                	addi	a0,a0,1
 572:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 574:	00054783          	lbu	a5,0(a0)
 578:	fbe5                	bnez	a5,568 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 57a:	0005c503          	lbu	a0,0(a1)
}
 57e:	40a7853b          	subw	a0,a5,a0
 582:	6422                	ld	s0,8(sp)
 584:	0141                	addi	sp,sp,16
 586:	8082                	ret

0000000000000588 <strlen>:

uint
strlen(const char *s)
{
 588:	1141                	addi	sp,sp,-16
 58a:	e422                	sd	s0,8(sp)
 58c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 58e:	00054783          	lbu	a5,0(a0)
 592:	cf91                	beqz	a5,5ae <strlen+0x26>
 594:	0505                	addi	a0,a0,1
 596:	87aa                	mv	a5,a0
 598:	4685                	li	a3,1
 59a:	9e89                	subw	a3,a3,a0
 59c:	00f6853b          	addw	a0,a3,a5
 5a0:	0785                	addi	a5,a5,1
 5a2:	fff7c703          	lbu	a4,-1(a5)
 5a6:	fb7d                	bnez	a4,59c <strlen+0x14>
    ;
  return n;
}
 5a8:	6422                	ld	s0,8(sp)
 5aa:	0141                	addi	sp,sp,16
 5ac:	8082                	ret
  for(n = 0; s[n]; n++)
 5ae:	4501                	li	a0,0
 5b0:	bfe5                	j	5a8 <strlen+0x20>

00000000000005b2 <memset>:

void*
memset(void *dst, int c, uint n)
{
 5b2:	1141                	addi	sp,sp,-16
 5b4:	e422                	sd	s0,8(sp)
 5b6:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 5b8:	ca19                	beqz	a2,5ce <memset+0x1c>
 5ba:	87aa                	mv	a5,a0
 5bc:	1602                	slli	a2,a2,0x20
 5be:	9201                	srli	a2,a2,0x20
 5c0:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 5c4:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 5c8:	0785                	addi	a5,a5,1
 5ca:	fee79de3          	bne	a5,a4,5c4 <memset+0x12>
  }
  return dst;
}
 5ce:	6422                	ld	s0,8(sp)
 5d0:	0141                	addi	sp,sp,16
 5d2:	8082                	ret

00000000000005d4 <strchr>:

char*
strchr(const char *s, char c)
{
 5d4:	1141                	addi	sp,sp,-16
 5d6:	e422                	sd	s0,8(sp)
 5d8:	0800                	addi	s0,sp,16
  for(; *s; s++)
 5da:	00054783          	lbu	a5,0(a0)
 5de:	cb99                	beqz	a5,5f4 <strchr+0x20>
    if(*s == c)
 5e0:	00f58763          	beq	a1,a5,5ee <strchr+0x1a>
  for(; *s; s++)
 5e4:	0505                	addi	a0,a0,1
 5e6:	00054783          	lbu	a5,0(a0)
 5ea:	fbfd                	bnez	a5,5e0 <strchr+0xc>
      return (char*)s;
  return 0;
 5ec:	4501                	li	a0,0
}
 5ee:	6422                	ld	s0,8(sp)
 5f0:	0141                	addi	sp,sp,16
 5f2:	8082                	ret
  return 0;
 5f4:	4501                	li	a0,0
 5f6:	bfe5                	j	5ee <strchr+0x1a>

00000000000005f8 <gets>:

char*
gets(char *buf, int max)
{
 5f8:	711d                	addi	sp,sp,-96
 5fa:	ec86                	sd	ra,88(sp)
 5fc:	e8a2                	sd	s0,80(sp)
 5fe:	e4a6                	sd	s1,72(sp)
 600:	e0ca                	sd	s2,64(sp)
 602:	fc4e                	sd	s3,56(sp)
 604:	f852                	sd	s4,48(sp)
 606:	f456                	sd	s5,40(sp)
 608:	f05a                	sd	s6,32(sp)
 60a:	ec5e                	sd	s7,24(sp)
 60c:	1080                	addi	s0,sp,96
 60e:	8baa                	mv	s7,a0
 610:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 612:	892a                	mv	s2,a0
 614:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 616:	4aa9                	li	s5,10
 618:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 61a:	89a6                	mv	s3,s1
 61c:	2485                	addiw	s1,s1,1
 61e:	0344d863          	bge	s1,s4,64e <gets+0x56>
    cc = read(0, &c, 1);
 622:	4605                	li	a2,1
 624:	faf40593          	addi	a1,s0,-81
 628:	4501                	li	a0,0
 62a:	00000097          	auipc	ra,0x0
 62e:	19a080e7          	jalr	410(ra) # 7c4 <read>
    if(cc < 1)
 632:	00a05e63          	blez	a0,64e <gets+0x56>
    buf[i++] = c;
 636:	faf44783          	lbu	a5,-81(s0)
 63a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 63e:	01578763          	beq	a5,s5,64c <gets+0x54>
 642:	0905                	addi	s2,s2,1
 644:	fd679be3          	bne	a5,s6,61a <gets+0x22>
  for(i=0; i+1 < max; ){
 648:	89a6                	mv	s3,s1
 64a:	a011                	j	64e <gets+0x56>
 64c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 64e:	99de                	add	s3,s3,s7
 650:	00098023          	sb	zero,0(s3)
  return buf;
}
 654:	855e                	mv	a0,s7
 656:	60e6                	ld	ra,88(sp)
 658:	6446                	ld	s0,80(sp)
 65a:	64a6                	ld	s1,72(sp)
 65c:	6906                	ld	s2,64(sp)
 65e:	79e2                	ld	s3,56(sp)
 660:	7a42                	ld	s4,48(sp)
 662:	7aa2                	ld	s5,40(sp)
 664:	7b02                	ld	s6,32(sp)
 666:	6be2                	ld	s7,24(sp)
 668:	6125                	addi	sp,sp,96
 66a:	8082                	ret

000000000000066c <stat>:

int
stat(const char *n, struct stat *st)
{
 66c:	1101                	addi	sp,sp,-32
 66e:	ec06                	sd	ra,24(sp)
 670:	e822                	sd	s0,16(sp)
 672:	e426                	sd	s1,8(sp)
 674:	e04a                	sd	s2,0(sp)
 676:	1000                	addi	s0,sp,32
 678:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 67a:	4581                	li	a1,0
 67c:	00000097          	auipc	ra,0x0
 680:	170080e7          	jalr	368(ra) # 7ec <open>
  if(fd < 0)
 684:	02054563          	bltz	a0,6ae <stat+0x42>
 688:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 68a:	85ca                	mv	a1,s2
 68c:	00000097          	auipc	ra,0x0
 690:	178080e7          	jalr	376(ra) # 804 <fstat>
 694:	892a                	mv	s2,a0
  close(fd);
 696:	8526                	mv	a0,s1
 698:	00000097          	auipc	ra,0x0
 69c:	13c080e7          	jalr	316(ra) # 7d4 <close>
  return r;
}
 6a0:	854a                	mv	a0,s2
 6a2:	60e2                	ld	ra,24(sp)
 6a4:	6442                	ld	s0,16(sp)
 6a6:	64a2                	ld	s1,8(sp)
 6a8:	6902                	ld	s2,0(sp)
 6aa:	6105                	addi	sp,sp,32
 6ac:	8082                	ret
    return -1;
 6ae:	597d                	li	s2,-1
 6b0:	bfc5                	j	6a0 <stat+0x34>

00000000000006b2 <atoi>:

int
atoi(const char *s)
{
 6b2:	1141                	addi	sp,sp,-16
 6b4:	e422                	sd	s0,8(sp)
 6b6:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 6b8:	00054683          	lbu	a3,0(a0)
 6bc:	fd06879b          	addiw	a5,a3,-48
 6c0:	0ff7f793          	zext.b	a5,a5
 6c4:	4625                	li	a2,9
 6c6:	02f66863          	bltu	a2,a5,6f6 <atoi+0x44>
 6ca:	872a                	mv	a4,a0
  n = 0;
 6cc:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 6ce:	0705                	addi	a4,a4,1
 6d0:	0025179b          	slliw	a5,a0,0x2
 6d4:	9fa9                	addw	a5,a5,a0
 6d6:	0017979b          	slliw	a5,a5,0x1
 6da:	9fb5                	addw	a5,a5,a3
 6dc:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 6e0:	00074683          	lbu	a3,0(a4)
 6e4:	fd06879b          	addiw	a5,a3,-48
 6e8:	0ff7f793          	zext.b	a5,a5
 6ec:	fef671e3          	bgeu	a2,a5,6ce <atoi+0x1c>
  return n;
}
 6f0:	6422                	ld	s0,8(sp)
 6f2:	0141                	addi	sp,sp,16
 6f4:	8082                	ret
  n = 0;
 6f6:	4501                	li	a0,0
 6f8:	bfe5                	j	6f0 <atoi+0x3e>

00000000000006fa <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 6fa:	1141                	addi	sp,sp,-16
 6fc:	e422                	sd	s0,8(sp)
 6fe:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 700:	02b57463          	bgeu	a0,a1,728 <memmove+0x2e>
    while(n-- > 0)
 704:	00c05f63          	blez	a2,722 <memmove+0x28>
 708:	1602                	slli	a2,a2,0x20
 70a:	9201                	srli	a2,a2,0x20
 70c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 710:	872a                	mv	a4,a0
      *dst++ = *src++;
 712:	0585                	addi	a1,a1,1
 714:	0705                	addi	a4,a4,1
 716:	fff5c683          	lbu	a3,-1(a1)
 71a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 71e:	fee79ae3          	bne	a5,a4,712 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 722:	6422                	ld	s0,8(sp)
 724:	0141                	addi	sp,sp,16
 726:	8082                	ret
    dst += n;
 728:	00c50733          	add	a4,a0,a2
    src += n;
 72c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 72e:	fec05ae3          	blez	a2,722 <memmove+0x28>
 732:	fff6079b          	addiw	a5,a2,-1
 736:	1782                	slli	a5,a5,0x20
 738:	9381                	srli	a5,a5,0x20
 73a:	fff7c793          	not	a5,a5
 73e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 740:	15fd                	addi	a1,a1,-1
 742:	177d                	addi	a4,a4,-1
 744:	0005c683          	lbu	a3,0(a1)
 748:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 74c:	fee79ae3          	bne	a5,a4,740 <memmove+0x46>
 750:	bfc9                	j	722 <memmove+0x28>

0000000000000752 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 752:	1141                	addi	sp,sp,-16
 754:	e422                	sd	s0,8(sp)
 756:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 758:	ca05                	beqz	a2,788 <memcmp+0x36>
 75a:	fff6069b          	addiw	a3,a2,-1
 75e:	1682                	slli	a3,a3,0x20
 760:	9281                	srli	a3,a3,0x20
 762:	0685                	addi	a3,a3,1
 764:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 766:	00054783          	lbu	a5,0(a0)
 76a:	0005c703          	lbu	a4,0(a1)
 76e:	00e79863          	bne	a5,a4,77e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 772:	0505                	addi	a0,a0,1
    p2++;
 774:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 776:	fed518e3          	bne	a0,a3,766 <memcmp+0x14>
  }
  return 0;
 77a:	4501                	li	a0,0
 77c:	a019                	j	782 <memcmp+0x30>
      return *p1 - *p2;
 77e:	40e7853b          	subw	a0,a5,a4
}
 782:	6422                	ld	s0,8(sp)
 784:	0141                	addi	sp,sp,16
 786:	8082                	ret
  return 0;
 788:	4501                	li	a0,0
 78a:	bfe5                	j	782 <memcmp+0x30>

000000000000078c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 78c:	1141                	addi	sp,sp,-16
 78e:	e406                	sd	ra,8(sp)
 790:	e022                	sd	s0,0(sp)
 792:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 794:	00000097          	auipc	ra,0x0
 798:	f66080e7          	jalr	-154(ra) # 6fa <memmove>
}
 79c:	60a2                	ld	ra,8(sp)
 79e:	6402                	ld	s0,0(sp)
 7a0:	0141                	addi	sp,sp,16
 7a2:	8082                	ret

00000000000007a4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 7a4:	4885                	li	a7,1
 ecall
 7a6:	00000073          	ecall
 ret
 7aa:	8082                	ret

00000000000007ac <exit>:
.global exit
exit:
 li a7, SYS_exit
 7ac:	4889                	li	a7,2
 ecall
 7ae:	00000073          	ecall
 ret
 7b2:	8082                	ret

00000000000007b4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 7b4:	488d                	li	a7,3
 ecall
 7b6:	00000073          	ecall
 ret
 7ba:	8082                	ret

00000000000007bc <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 7bc:	4891                	li	a7,4
 ecall
 7be:	00000073          	ecall
 ret
 7c2:	8082                	ret

00000000000007c4 <read>:
.global read
read:
 li a7, SYS_read
 7c4:	4895                	li	a7,5
 ecall
 7c6:	00000073          	ecall
 ret
 7ca:	8082                	ret

00000000000007cc <write>:
.global write
write:
 li a7, SYS_write
 7cc:	48c1                	li	a7,16
 ecall
 7ce:	00000073          	ecall
 ret
 7d2:	8082                	ret

00000000000007d4 <close>:
.global close
close:
 li a7, SYS_close
 7d4:	48d5                	li	a7,21
 ecall
 7d6:	00000073          	ecall
 ret
 7da:	8082                	ret

00000000000007dc <kill>:
.global kill
kill:
 li a7, SYS_kill
 7dc:	4899                	li	a7,6
 ecall
 7de:	00000073          	ecall
 ret
 7e2:	8082                	ret

00000000000007e4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 7e4:	489d                	li	a7,7
 ecall
 7e6:	00000073          	ecall
 ret
 7ea:	8082                	ret

00000000000007ec <open>:
.global open
open:
 li a7, SYS_open
 7ec:	48bd                	li	a7,15
 ecall
 7ee:	00000073          	ecall
 ret
 7f2:	8082                	ret

00000000000007f4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 7f4:	48c5                	li	a7,17
 ecall
 7f6:	00000073          	ecall
 ret
 7fa:	8082                	ret

00000000000007fc <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 7fc:	48c9                	li	a7,18
 ecall
 7fe:	00000073          	ecall
 ret
 802:	8082                	ret

0000000000000804 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 804:	48a1                	li	a7,8
 ecall
 806:	00000073          	ecall
 ret
 80a:	8082                	ret

000000000000080c <link>:
.global link
link:
 li a7, SYS_link
 80c:	48cd                	li	a7,19
 ecall
 80e:	00000073          	ecall
 ret
 812:	8082                	ret

0000000000000814 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 814:	48d1                	li	a7,20
 ecall
 816:	00000073          	ecall
 ret
 81a:	8082                	ret

000000000000081c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 81c:	48a5                	li	a7,9
 ecall
 81e:	00000073          	ecall
 ret
 822:	8082                	ret

0000000000000824 <dup>:
.global dup
dup:
 li a7, SYS_dup
 824:	48a9                	li	a7,10
 ecall
 826:	00000073          	ecall
 ret
 82a:	8082                	ret

000000000000082c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 82c:	48ad                	li	a7,11
 ecall
 82e:	00000073          	ecall
 ret
 832:	8082                	ret

0000000000000834 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 834:	48b1                	li	a7,12
 ecall
 836:	00000073          	ecall
 ret
 83a:	8082                	ret

000000000000083c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 83c:	48b5                	li	a7,13
 ecall
 83e:	00000073          	ecall
 ret
 842:	8082                	ret

0000000000000844 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 844:	48b9                	li	a7,14
 ecall
 846:	00000073          	ecall
 ret
 84a:	8082                	ret

000000000000084c <getyear>:
.global getyear
getyear:
 li a7, SYS_getyear
 84c:	48d9                	li	a7,22
 ecall
 84e:	00000073          	ecall
 ret
 852:	8082                	ret

0000000000000854 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 854:	1101                	addi	sp,sp,-32
 856:	ec06                	sd	ra,24(sp)
 858:	e822                	sd	s0,16(sp)
 85a:	1000                	addi	s0,sp,32
 85c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 860:	4605                	li	a2,1
 862:	fef40593          	addi	a1,s0,-17
 866:	00000097          	auipc	ra,0x0
 86a:	f66080e7          	jalr	-154(ra) # 7cc <write>
}
 86e:	60e2                	ld	ra,24(sp)
 870:	6442                	ld	s0,16(sp)
 872:	6105                	addi	sp,sp,32
 874:	8082                	ret

0000000000000876 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 876:	7139                	addi	sp,sp,-64
 878:	fc06                	sd	ra,56(sp)
 87a:	f822                	sd	s0,48(sp)
 87c:	f426                	sd	s1,40(sp)
 87e:	f04a                	sd	s2,32(sp)
 880:	ec4e                	sd	s3,24(sp)
 882:	0080                	addi	s0,sp,64
 884:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 886:	c299                	beqz	a3,88c <printint+0x16>
 888:	0805c963          	bltz	a1,91a <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 88c:	2581                	sext.w	a1,a1
  neg = 0;
 88e:	4881                	li	a7,0
 890:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 894:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 896:	2601                	sext.w	a2,a2
 898:	00000517          	auipc	a0,0x0
 89c:	53050513          	addi	a0,a0,1328 # dc8 <digits>
 8a0:	883a                	mv	a6,a4
 8a2:	2705                	addiw	a4,a4,1
 8a4:	02c5f7bb          	remuw	a5,a1,a2
 8a8:	1782                	slli	a5,a5,0x20
 8aa:	9381                	srli	a5,a5,0x20
 8ac:	97aa                	add	a5,a5,a0
 8ae:	0007c783          	lbu	a5,0(a5)
 8b2:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 8b6:	0005879b          	sext.w	a5,a1
 8ba:	02c5d5bb          	divuw	a1,a1,a2
 8be:	0685                	addi	a3,a3,1
 8c0:	fec7f0e3          	bgeu	a5,a2,8a0 <printint+0x2a>
  if(neg)
 8c4:	00088c63          	beqz	a7,8dc <printint+0x66>
    buf[i++] = '-';
 8c8:	fd070793          	addi	a5,a4,-48
 8cc:	00878733          	add	a4,a5,s0
 8d0:	02d00793          	li	a5,45
 8d4:	fef70823          	sb	a5,-16(a4)
 8d8:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 8dc:	02e05863          	blez	a4,90c <printint+0x96>
 8e0:	fc040793          	addi	a5,s0,-64
 8e4:	00e78933          	add	s2,a5,a4
 8e8:	fff78993          	addi	s3,a5,-1
 8ec:	99ba                	add	s3,s3,a4
 8ee:	377d                	addiw	a4,a4,-1
 8f0:	1702                	slli	a4,a4,0x20
 8f2:	9301                	srli	a4,a4,0x20
 8f4:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 8f8:	fff94583          	lbu	a1,-1(s2)
 8fc:	8526                	mv	a0,s1
 8fe:	00000097          	auipc	ra,0x0
 902:	f56080e7          	jalr	-170(ra) # 854 <putc>
  while(--i >= 0)
 906:	197d                	addi	s2,s2,-1
 908:	ff3918e3          	bne	s2,s3,8f8 <printint+0x82>
}
 90c:	70e2                	ld	ra,56(sp)
 90e:	7442                	ld	s0,48(sp)
 910:	74a2                	ld	s1,40(sp)
 912:	7902                	ld	s2,32(sp)
 914:	69e2                	ld	s3,24(sp)
 916:	6121                	addi	sp,sp,64
 918:	8082                	ret
    x = -xx;
 91a:	40b005bb          	negw	a1,a1
    neg = 1;
 91e:	4885                	li	a7,1
    x = -xx;
 920:	bf85                	j	890 <printint+0x1a>

0000000000000922 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 922:	7119                	addi	sp,sp,-128
 924:	fc86                	sd	ra,120(sp)
 926:	f8a2                	sd	s0,112(sp)
 928:	f4a6                	sd	s1,104(sp)
 92a:	f0ca                	sd	s2,96(sp)
 92c:	ecce                	sd	s3,88(sp)
 92e:	e8d2                	sd	s4,80(sp)
 930:	e4d6                	sd	s5,72(sp)
 932:	e0da                	sd	s6,64(sp)
 934:	fc5e                	sd	s7,56(sp)
 936:	f862                	sd	s8,48(sp)
 938:	f466                	sd	s9,40(sp)
 93a:	f06a                	sd	s10,32(sp)
 93c:	ec6e                	sd	s11,24(sp)
 93e:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 940:	0005c903          	lbu	s2,0(a1)
 944:	18090f63          	beqz	s2,ae2 <vprintf+0x1c0>
 948:	8aaa                	mv	s5,a0
 94a:	8b32                	mv	s6,a2
 94c:	00158493          	addi	s1,a1,1
  state = 0;
 950:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 952:	02500a13          	li	s4,37
 956:	4c55                	li	s8,21
 958:	00000c97          	auipc	s9,0x0
 95c:	418c8c93          	addi	s9,s9,1048 # d70 <malloc+0x18a>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 960:	02800d93          	li	s11,40
  putc(fd, 'x');
 964:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 966:	00000b97          	auipc	s7,0x0
 96a:	462b8b93          	addi	s7,s7,1122 # dc8 <digits>
 96e:	a839                	j	98c <vprintf+0x6a>
        putc(fd, c);
 970:	85ca                	mv	a1,s2
 972:	8556                	mv	a0,s5
 974:	00000097          	auipc	ra,0x0
 978:	ee0080e7          	jalr	-288(ra) # 854 <putc>
 97c:	a019                	j	982 <vprintf+0x60>
    } else if(state == '%'){
 97e:	01498d63          	beq	s3,s4,998 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 982:	0485                	addi	s1,s1,1
 984:	fff4c903          	lbu	s2,-1(s1)
 988:	14090d63          	beqz	s2,ae2 <vprintf+0x1c0>
    if(state == 0){
 98c:	fe0999e3          	bnez	s3,97e <vprintf+0x5c>
      if(c == '%'){
 990:	ff4910e3          	bne	s2,s4,970 <vprintf+0x4e>
        state = '%';
 994:	89d2                	mv	s3,s4
 996:	b7f5                	j	982 <vprintf+0x60>
      if(c == 'd'){
 998:	11490c63          	beq	s2,s4,ab0 <vprintf+0x18e>
 99c:	f9d9079b          	addiw	a5,s2,-99
 9a0:	0ff7f793          	zext.b	a5,a5
 9a4:	10fc6e63          	bltu	s8,a5,ac0 <vprintf+0x19e>
 9a8:	f9d9079b          	addiw	a5,s2,-99
 9ac:	0ff7f713          	zext.b	a4,a5
 9b0:	10ec6863          	bltu	s8,a4,ac0 <vprintf+0x19e>
 9b4:	00271793          	slli	a5,a4,0x2
 9b8:	97e6                	add	a5,a5,s9
 9ba:	439c                	lw	a5,0(a5)
 9bc:	97e6                	add	a5,a5,s9
 9be:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 9c0:	008b0913          	addi	s2,s6,8
 9c4:	4685                	li	a3,1
 9c6:	4629                	li	a2,10
 9c8:	000b2583          	lw	a1,0(s6)
 9cc:	8556                	mv	a0,s5
 9ce:	00000097          	auipc	ra,0x0
 9d2:	ea8080e7          	jalr	-344(ra) # 876 <printint>
 9d6:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 9d8:	4981                	li	s3,0
 9da:	b765                	j	982 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9dc:	008b0913          	addi	s2,s6,8
 9e0:	4681                	li	a3,0
 9e2:	4629                	li	a2,10
 9e4:	000b2583          	lw	a1,0(s6)
 9e8:	8556                	mv	a0,s5
 9ea:	00000097          	auipc	ra,0x0
 9ee:	e8c080e7          	jalr	-372(ra) # 876 <printint>
 9f2:	8b4a                	mv	s6,s2
      state = 0;
 9f4:	4981                	li	s3,0
 9f6:	b771                	j	982 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 9f8:	008b0913          	addi	s2,s6,8
 9fc:	4681                	li	a3,0
 9fe:	866a                	mv	a2,s10
 a00:	000b2583          	lw	a1,0(s6)
 a04:	8556                	mv	a0,s5
 a06:	00000097          	auipc	ra,0x0
 a0a:	e70080e7          	jalr	-400(ra) # 876 <printint>
 a0e:	8b4a                	mv	s6,s2
      state = 0;
 a10:	4981                	li	s3,0
 a12:	bf85                	j	982 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 a14:	008b0793          	addi	a5,s6,8
 a18:	f8f43423          	sd	a5,-120(s0)
 a1c:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 a20:	03000593          	li	a1,48
 a24:	8556                	mv	a0,s5
 a26:	00000097          	auipc	ra,0x0
 a2a:	e2e080e7          	jalr	-466(ra) # 854 <putc>
  putc(fd, 'x');
 a2e:	07800593          	li	a1,120
 a32:	8556                	mv	a0,s5
 a34:	00000097          	auipc	ra,0x0
 a38:	e20080e7          	jalr	-480(ra) # 854 <putc>
 a3c:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a3e:	03c9d793          	srli	a5,s3,0x3c
 a42:	97de                	add	a5,a5,s7
 a44:	0007c583          	lbu	a1,0(a5)
 a48:	8556                	mv	a0,s5
 a4a:	00000097          	auipc	ra,0x0
 a4e:	e0a080e7          	jalr	-502(ra) # 854 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a52:	0992                	slli	s3,s3,0x4
 a54:	397d                	addiw	s2,s2,-1
 a56:	fe0914e3          	bnez	s2,a3e <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 a5a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 a5e:	4981                	li	s3,0
 a60:	b70d                	j	982 <vprintf+0x60>
        s = va_arg(ap, char*);
 a62:	008b0913          	addi	s2,s6,8
 a66:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 a6a:	02098163          	beqz	s3,a8c <vprintf+0x16a>
        while(*s != 0){
 a6e:	0009c583          	lbu	a1,0(s3)
 a72:	c5ad                	beqz	a1,adc <vprintf+0x1ba>
          putc(fd, *s);
 a74:	8556                	mv	a0,s5
 a76:	00000097          	auipc	ra,0x0
 a7a:	dde080e7          	jalr	-546(ra) # 854 <putc>
          s++;
 a7e:	0985                	addi	s3,s3,1
        while(*s != 0){
 a80:	0009c583          	lbu	a1,0(s3)
 a84:	f9e5                	bnez	a1,a74 <vprintf+0x152>
        s = va_arg(ap, char*);
 a86:	8b4a                	mv	s6,s2
      state = 0;
 a88:	4981                	li	s3,0
 a8a:	bde5                	j	982 <vprintf+0x60>
          s = "(null)";
 a8c:	00000997          	auipc	s3,0x0
 a90:	2dc98993          	addi	s3,s3,732 # d68 <malloc+0x182>
        while(*s != 0){
 a94:	85ee                	mv	a1,s11
 a96:	bff9                	j	a74 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 a98:	008b0913          	addi	s2,s6,8
 a9c:	000b4583          	lbu	a1,0(s6)
 aa0:	8556                	mv	a0,s5
 aa2:	00000097          	auipc	ra,0x0
 aa6:	db2080e7          	jalr	-590(ra) # 854 <putc>
 aaa:	8b4a                	mv	s6,s2
      state = 0;
 aac:	4981                	li	s3,0
 aae:	bdd1                	j	982 <vprintf+0x60>
        putc(fd, c);
 ab0:	85d2                	mv	a1,s4
 ab2:	8556                	mv	a0,s5
 ab4:	00000097          	auipc	ra,0x0
 ab8:	da0080e7          	jalr	-608(ra) # 854 <putc>
      state = 0;
 abc:	4981                	li	s3,0
 abe:	b5d1                	j	982 <vprintf+0x60>
        putc(fd, '%');
 ac0:	85d2                	mv	a1,s4
 ac2:	8556                	mv	a0,s5
 ac4:	00000097          	auipc	ra,0x0
 ac8:	d90080e7          	jalr	-624(ra) # 854 <putc>
        putc(fd, c);
 acc:	85ca                	mv	a1,s2
 ace:	8556                	mv	a0,s5
 ad0:	00000097          	auipc	ra,0x0
 ad4:	d84080e7          	jalr	-636(ra) # 854 <putc>
      state = 0;
 ad8:	4981                	li	s3,0
 ada:	b565                	j	982 <vprintf+0x60>
        s = va_arg(ap, char*);
 adc:	8b4a                	mv	s6,s2
      state = 0;
 ade:	4981                	li	s3,0
 ae0:	b54d                	j	982 <vprintf+0x60>
    }
  }
}
 ae2:	70e6                	ld	ra,120(sp)
 ae4:	7446                	ld	s0,112(sp)
 ae6:	74a6                	ld	s1,104(sp)
 ae8:	7906                	ld	s2,96(sp)
 aea:	69e6                	ld	s3,88(sp)
 aec:	6a46                	ld	s4,80(sp)
 aee:	6aa6                	ld	s5,72(sp)
 af0:	6b06                	ld	s6,64(sp)
 af2:	7be2                	ld	s7,56(sp)
 af4:	7c42                	ld	s8,48(sp)
 af6:	7ca2                	ld	s9,40(sp)
 af8:	7d02                	ld	s10,32(sp)
 afa:	6de2                	ld	s11,24(sp)
 afc:	6109                	addi	sp,sp,128
 afe:	8082                	ret

0000000000000b00 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b00:	715d                	addi	sp,sp,-80
 b02:	ec06                	sd	ra,24(sp)
 b04:	e822                	sd	s0,16(sp)
 b06:	1000                	addi	s0,sp,32
 b08:	e010                	sd	a2,0(s0)
 b0a:	e414                	sd	a3,8(s0)
 b0c:	e818                	sd	a4,16(s0)
 b0e:	ec1c                	sd	a5,24(s0)
 b10:	03043023          	sd	a6,32(s0)
 b14:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 b18:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 b1c:	8622                	mv	a2,s0
 b1e:	00000097          	auipc	ra,0x0
 b22:	e04080e7          	jalr	-508(ra) # 922 <vprintf>
}
 b26:	60e2                	ld	ra,24(sp)
 b28:	6442                	ld	s0,16(sp)
 b2a:	6161                	addi	sp,sp,80
 b2c:	8082                	ret

0000000000000b2e <printf>:

void
printf(const char *fmt, ...)
{
 b2e:	711d                	addi	sp,sp,-96
 b30:	ec06                	sd	ra,24(sp)
 b32:	e822                	sd	s0,16(sp)
 b34:	1000                	addi	s0,sp,32
 b36:	e40c                	sd	a1,8(s0)
 b38:	e810                	sd	a2,16(s0)
 b3a:	ec14                	sd	a3,24(s0)
 b3c:	f018                	sd	a4,32(s0)
 b3e:	f41c                	sd	a5,40(s0)
 b40:	03043823          	sd	a6,48(s0)
 b44:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b48:	00840613          	addi	a2,s0,8
 b4c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b50:	85aa                	mv	a1,a0
 b52:	4505                	li	a0,1
 b54:	00000097          	auipc	ra,0x0
 b58:	dce080e7          	jalr	-562(ra) # 922 <vprintf>
}
 b5c:	60e2                	ld	ra,24(sp)
 b5e:	6442                	ld	s0,16(sp)
 b60:	6125                	addi	sp,sp,96
 b62:	8082                	ret

0000000000000b64 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b64:	1141                	addi	sp,sp,-16
 b66:	e422                	sd	s0,8(sp)
 b68:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b6a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b6e:	00000797          	auipc	a5,0x0
 b72:	4927b783          	ld	a5,1170(a5) # 1000 <freep>
 b76:	a02d                	j	ba0 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b78:	4618                	lw	a4,8(a2)
 b7a:	9f2d                	addw	a4,a4,a1
 b7c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 b80:	6398                	ld	a4,0(a5)
 b82:	6310                	ld	a2,0(a4)
 b84:	a83d                	j	bc2 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 b86:	ff852703          	lw	a4,-8(a0)
 b8a:	9f31                	addw	a4,a4,a2
 b8c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b8e:	ff053683          	ld	a3,-16(a0)
 b92:	a091                	j	bd6 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b94:	6398                	ld	a4,0(a5)
 b96:	00e7e463          	bltu	a5,a4,b9e <free+0x3a>
 b9a:	00e6ea63          	bltu	a3,a4,bae <free+0x4a>
{
 b9e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ba0:	fed7fae3          	bgeu	a5,a3,b94 <free+0x30>
 ba4:	6398                	ld	a4,0(a5)
 ba6:	00e6e463          	bltu	a3,a4,bae <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 baa:	fee7eae3          	bltu	a5,a4,b9e <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 bae:	ff852583          	lw	a1,-8(a0)
 bb2:	6390                	ld	a2,0(a5)
 bb4:	02059813          	slli	a6,a1,0x20
 bb8:	01c85713          	srli	a4,a6,0x1c
 bbc:	9736                	add	a4,a4,a3
 bbe:	fae60de3          	beq	a2,a4,b78 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 bc2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 bc6:	4790                	lw	a2,8(a5)
 bc8:	02061593          	slli	a1,a2,0x20
 bcc:	01c5d713          	srli	a4,a1,0x1c
 bd0:	973e                	add	a4,a4,a5
 bd2:	fae68ae3          	beq	a3,a4,b86 <free+0x22>
    p->s.ptr = bp->s.ptr;
 bd6:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 bd8:	00000717          	auipc	a4,0x0
 bdc:	42f73423          	sd	a5,1064(a4) # 1000 <freep>
}
 be0:	6422                	ld	s0,8(sp)
 be2:	0141                	addi	sp,sp,16
 be4:	8082                	ret

0000000000000be6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 be6:	7139                	addi	sp,sp,-64
 be8:	fc06                	sd	ra,56(sp)
 bea:	f822                	sd	s0,48(sp)
 bec:	f426                	sd	s1,40(sp)
 bee:	f04a                	sd	s2,32(sp)
 bf0:	ec4e                	sd	s3,24(sp)
 bf2:	e852                	sd	s4,16(sp)
 bf4:	e456                	sd	s5,8(sp)
 bf6:	e05a                	sd	s6,0(sp)
 bf8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bfa:	02051493          	slli	s1,a0,0x20
 bfe:	9081                	srli	s1,s1,0x20
 c00:	04bd                	addi	s1,s1,15
 c02:	8091                	srli	s1,s1,0x4
 c04:	0014899b          	addiw	s3,s1,1
 c08:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 c0a:	00000517          	auipc	a0,0x0
 c0e:	3f653503          	ld	a0,1014(a0) # 1000 <freep>
 c12:	c515                	beqz	a0,c3e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c14:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c16:	4798                	lw	a4,8(a5)
 c18:	02977f63          	bgeu	a4,s1,c56 <malloc+0x70>
 c1c:	8a4e                	mv	s4,s3
 c1e:	0009871b          	sext.w	a4,s3
 c22:	6685                	lui	a3,0x1
 c24:	00d77363          	bgeu	a4,a3,c2a <malloc+0x44>
 c28:	6a05                	lui	s4,0x1
 c2a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 c2e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c32:	00000917          	auipc	s2,0x0
 c36:	3ce90913          	addi	s2,s2,974 # 1000 <freep>
  if(p == (char*)-1)
 c3a:	5afd                	li	s5,-1
 c3c:	a895                	j	cb0 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 c3e:	00000797          	auipc	a5,0x0
 c42:	3d278793          	addi	a5,a5,978 # 1010 <base>
 c46:	00000717          	auipc	a4,0x0
 c4a:	3af73d23          	sd	a5,954(a4) # 1000 <freep>
 c4e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 c50:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 c54:	b7e1                	j	c1c <malloc+0x36>
      if(p->s.size == nunits)
 c56:	02e48c63          	beq	s1,a4,c8e <malloc+0xa8>
        p->s.size -= nunits;
 c5a:	4137073b          	subw	a4,a4,s3
 c5e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 c60:	02071693          	slli	a3,a4,0x20
 c64:	01c6d713          	srli	a4,a3,0x1c
 c68:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c6a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 c6e:	00000717          	auipc	a4,0x0
 c72:	38a73923          	sd	a0,914(a4) # 1000 <freep>
      return (void*)(p + 1);
 c76:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 c7a:	70e2                	ld	ra,56(sp)
 c7c:	7442                	ld	s0,48(sp)
 c7e:	74a2                	ld	s1,40(sp)
 c80:	7902                	ld	s2,32(sp)
 c82:	69e2                	ld	s3,24(sp)
 c84:	6a42                	ld	s4,16(sp)
 c86:	6aa2                	ld	s5,8(sp)
 c88:	6b02                	ld	s6,0(sp)
 c8a:	6121                	addi	sp,sp,64
 c8c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 c8e:	6398                	ld	a4,0(a5)
 c90:	e118                	sd	a4,0(a0)
 c92:	bff1                	j	c6e <malloc+0x88>
  hp->s.size = nu;
 c94:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 c98:	0541                	addi	a0,a0,16
 c9a:	00000097          	auipc	ra,0x0
 c9e:	eca080e7          	jalr	-310(ra) # b64 <free>
  return freep;
 ca2:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 ca6:	d971                	beqz	a0,c7a <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ca8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 caa:	4798                	lw	a4,8(a5)
 cac:	fa9775e3          	bgeu	a4,s1,c56 <malloc+0x70>
    if(p == freep)
 cb0:	00093703          	ld	a4,0(s2)
 cb4:	853e                	mv	a0,a5
 cb6:	fef719e3          	bne	a4,a5,ca8 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 cba:	8552                	mv	a0,s4
 cbc:	00000097          	auipc	ra,0x0
 cc0:	b78080e7          	jalr	-1160(ra) # 834 <sbrk>
  if(p == (char*)-1)
 cc4:	fd5518e3          	bne	a0,s5,c94 <malloc+0xae>
        return 0;
 cc8:	4501                	li	a0,0
 cca:	bf45                	j	c7a <malloc+0x94>
