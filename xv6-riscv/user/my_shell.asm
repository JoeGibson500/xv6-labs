
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
  16:	c8e58593          	addi	a1,a1,-882 # ca0 <malloc+0xe8>
  1a:	4509                	li	a0,2
  1c:	00000097          	auipc	ra,0x0
  20:	782080e7          	jalr	1922(ra) # 79e <write>

    // read input from user
    // gets(buffer, bufferSize);
    read(0, buffer, bufferSize);
  24:	864a                	mv	a2,s2
  26:	85a6                	mv	a1,s1
  28:	4501                	li	a0,0
  2a:	00000097          	auipc	ra,0x0
  2e:	76c080e7          	jalr	1900(ra) # 796 <read>


    // if the user just presses enter, exit function (this is so it is called again in the while loop so that the command prompt will be printed agaim)
    if (strlen(buffer) == 1)
  32:	8526                	mv	a0,s1
  34:	00000097          	auipc	ra,0x0
  38:	526080e7          	jalr	1318(ra) # 55a <strlen>
  3c:	2501                	sext.w	a0,a0
  3e:	4785                	li	a5,1
  40:	02f50363          	beq	a0,a5,66 <readLine+0x66>
    }

    // if we read in a < or > and \n then checkRedirection will be equal to 1.
    // if we only read in a \n then status = 0
    // initialize to 0 for now
    int checkRedirection = 0;
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
    int checkRedirection = 0;
  5a:	4501                	li	a0,0
    {
        if(buffer[i] == '<' || buffer[i] == '>')
  5c:	03c00813          	li	a6,60
        {
            checkRedirection = 1;
  60:	4305                	li	t1,1
        }

        if (buffer[i] == '\n')
  62:	45a9                	li	a1,10
  64:	a015                	j	88 <readLine+0x88>
        write(2, "\n", 2);
  66:	4609                	li	a2,2
  68:	00001597          	auipc	a1,0x1
  6c:	c4058593          	addi	a1,a1,-960 # ca8 <malloc+0xf0>
  70:	4509                	li	a0,2
  72:	00000097          	auipc	ra,0x0
  76:	72c080e7          	jalr	1836(ra) # 79e <write>
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
            checkRedirection = 1;
  96:	851a                	mv	a0,t1
  98:	b7dd                	j	7e <readLine+0x7e>
        {
            buffer[i] = '\0';
  9a:	00088023          	sb	zero,0(a7)
            break;
            
        }
    }
    return checkRedirection;
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
    // while (i < bufSize && buffer[i] == ' ') {
    //     i++;
    // }


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

0000000000000130 <formatLine>:
    - file descriptors then have to be restored back to STDIN and STDOUT before we read our next line
*/

void
formatLine(char *buffer, char *args[], char *redirectionFile, int redirectionStatus)
{
 130:	7179                	addi	sp,sp,-48
 132:	f406                	sd	ra,40(sp)
 134:	f022                	sd	s0,32(sp)
 136:	ec26                	sd	s1,24(sp)
 138:	e84a                	sd	s2,16(sp)
 13a:	e44e                	sd	s3,8(sp)
 13c:	e052                	sd	s4,0(sp)
 13e:	1800                	addi	s0,sp,48
 140:	84aa                	mv	s1,a0
 142:	89ae                	mv	s3,a1
 144:	8a32                	mv	s4,a2
 146:	8936                	mv	s2,a3

    // create a new process 
    int pid = fork();
 148:	00000097          	auipc	ra,0x0
 14c:	62e080e7          	jalr	1582(ra) # 776 <fork>

    // verify fork has worked
    if (pid < 0)
 150:	00054d63          	bltz	a0,16a <formatLine+0x3a>
    {
        printf("Fork failed");
        exit(1);

    } else if(pid == 0) // verify that we are in the child process
 154:	1c051c63          	bnez	a0,32c <formatLine+0x1fc>


        Finally, at the end of the loop we should increment bufferPointer. Once we reach a null-terminating character, we should break out the loop and use exec to run our command 
        */

        while (*bufferPointer != '\0') {
 158:	0004c783          	lbu	a5,0(s1)
 15c:	c3b9                	beqz	a5,1a2 <formatLine+0x72>
        argumentPointer = &args[0];
 15e:	86ce                	mv	a3,s3
        int wordstart = 1;
 160:	4705                	li	a4,1
            if (*bufferPointer != ' ') 
 162:	02000813          	li	a6,32

                    *bufferPointer = '\0';

                    argumentPointer++;

                    wordstart = 1;
 166:	4605                	li	a2,1
 168:	a03d                	j	196 <formatLine+0x66>
        printf("Fork failed");
 16a:	00001517          	auipc	a0,0x1
 16e:	b4650513          	addi	a0,a0,-1210 # cb0 <malloc+0xf8>
 172:	00001097          	auipc	ra,0x1
 176:	98e080e7          	jalr	-1650(ra) # b00 <printf>
        exit(1);
 17a:	4505                	li	a0,1
 17c:	00000097          	auipc	ra,0x0
 180:	602080e7          	jalr	1538(ra) # 77e <exit>
                if (!wordstart) 
 184:	e709                	bnez	a4,18e <formatLine+0x5e>
                    *bufferPointer = '\0';
 186:	00048023          	sb	zero,0(s1)
                    argumentPointer++;
 18a:	06a1                	addi	a3,a3,8
                    wordstart = 1;
 18c:	8732                	mv	a4,a2
                }
            }

        bufferPointer++;
 18e:	0485                	addi	s1,s1,1
        while (*bufferPointer != '\0') {
 190:	0004c783          	lbu	a5,0(s1)
 194:	c799                	beqz	a5,1a2 <formatLine+0x72>
            if (*bufferPointer != ' ') 
 196:	ff0787e3          	beq	a5,a6,184 <formatLine+0x54>
                if (wordstart)
 19a:	db75                	beqz	a4,18e <formatLine+0x5e>
                    *argumentPointer = bufferPointer;
 19c:	e284                	sd	s1,0(a3)
                    wordstart = 0;
 19e:	872a                	mv	a4,a0
 1a0:	b7fd                	j	18e <formatLine+0x5e>
        }

        // redirection handling
        if (redirectionStatus > 0)
 1a2:	15205f63          	blez	s2,300 <formatLine+0x1d0>
        {
        
            if (redirectionStatus == 1)
 1a6:	4785                	li	a5,1
 1a8:	06f90f63          	beq	s2,a5,226 <formatLine+0xf6>
                // file descriptor 0 is free, so now lets dup our copy that we saved earlier and it will store it in fd 0. we can then close our copy.
                dup(STDIN_fileDescriptor);
                close(STDIN_fileDescriptor);
            
            }
            else if (redirectionStatus == 2)
 1ac:	4789                	li	a5,2
 1ae:	18f91463          	bne	s2,a5,336 <formatLine+0x206>
            {
                 // open redirection file in required modes. this will be stored in next avaliable fd.
                int fileDescriptor = open(redirectionFile, O_WRONLY | O_CREATE | O_TRUNC); 
 1b2:	60100593          	li	a1,1537
 1b6:	8552                	mv	a0,s4
 1b8:	00000097          	auipc	ra,0x0
 1bc:	606080e7          	jalr	1542(ra) # 7be <open>
 1c0:	84aa                	mv	s1,a0
                
                if (fileDescriptor == -1)
 1c2:	57fd                	li	a5,-1
 1c4:	10f50463          	beq	a0,a5,2cc <formatLine+0x19c>
                    exit(1);
                }

                // duplicate the standard output file descriptor. this will be stored in the next avaliable fd.
                // this is done so we can restore it later
                int STDOUT_fileDescriptor = dup(1);
 1c8:	4505                	li	a0,1
 1ca:	00000097          	auipc	ra,0x0
 1ce:	62c080e7          	jalr	1580(ra) # 7f6 <dup>
 1d2:	892a                	mv	s2,a0

                // close the original STDOUT file descriptor. this will now become free to use. 
                close(1);
 1d4:	4505                	li	a0,1
 1d6:	00000097          	auipc	ra,0x0
 1da:	5d0080e7          	jalr	1488(ra) # 7a6 <close>

                // duplicate our file that we have opened. because we closed file descriptor 1, this will be stored there as it is free. 
                int result = dup(fileDescriptor);
 1de:	8526                	mv	a0,s1
 1e0:	00000097          	auipc	ra,0x0
 1e4:	616080e7          	jalr	1558(ra) # 7f6 <dup>
 1e8:	8a2a                	mv	s4,a0

                //close our old copy
                close(fileDescriptor);
 1ea:	8526                	mv	a0,s1
 1ec:	00000097          	auipc	ra,0x0
 1f0:	5ba080e7          	jalr	1466(ra) # 7a6 <close>

                // verify dup worled
                if (result < 0)
 1f4:	0e0a4963          	bltz	s4,2e6 <formatLine+0x1b6>
                    printf("Dup error : exiting");
                    exit(1);
                }

                // execute as normal. because we have changed STDOUT to our file, any output should go to our file now 
                exec(args[0], args);
 1f8:	85ce                	mv	a1,s3
 1fa:	0009b503          	ld	a0,0(s3)
 1fe:	00000097          	auipc	ra,0x0
 202:	5b8080e7          	jalr	1464(ra) # 7b6 <exec>

                // now we can close our file descriptor as we need to restore STDOUT
                close(1);
 206:	4505                	li	a0,1
 208:	00000097          	auipc	ra,0x0
 20c:	59e080e7          	jalr	1438(ra) # 7a6 <close>

                // file descriptor 1 is free, so now lets dup our copy that we saved earlier and it will store it in fd 1. we can then close our copy.
                dup(STDOUT_fileDescriptor);
 210:	854a                	mv	a0,s2
 212:	00000097          	auipc	ra,0x0
 216:	5e4080e7          	jalr	1508(ra) # 7f6 <dup>
                close(STDOUT_fileDescriptor);
 21a:	854a                	mv	a0,s2
 21c:	00000097          	auipc	ra,0x0
 220:	58a080e7          	jalr	1418(ra) # 7a6 <close>
 224:	aa09                	j	336 <formatLine+0x206>
                int fileDescriptor = open(redirectionFile, O_RDONLY);
 226:	4581                	li	a1,0
 228:	8552                	mv	a0,s4
 22a:	00000097          	auipc	ra,0x0
 22e:	594080e7          	jalr	1428(ra) # 7be <open>
 232:	84aa                	mv	s1,a0
                if (fileDescriptor == -1)
 234:	57fd                	li	a5,-1
 236:	06f50163          	beq	a0,a5,298 <formatLine+0x168>
                int STDIN_fileDescriptor = dup(0);
 23a:	4501                	li	a0,0
 23c:	00000097          	auipc	ra,0x0
 240:	5ba080e7          	jalr	1466(ra) # 7f6 <dup>
 244:	892a                	mv	s2,a0
                close(0);
 246:	4501                	li	a0,0
 248:	00000097          	auipc	ra,0x0
 24c:	55e080e7          	jalr	1374(ra) # 7a6 <close>
                int result = dup(fileDescriptor);
 250:	8526                	mv	a0,s1
 252:	00000097          	auipc	ra,0x0
 256:	5a4080e7          	jalr	1444(ra) # 7f6 <dup>
 25a:	8a2a                	mv	s4,a0
                close(fileDescriptor);
 25c:	8526                	mv	a0,s1
 25e:	00000097          	auipc	ra,0x0
 262:	548080e7          	jalr	1352(ra) # 7a6 <close>
                if (result < 0)
 266:	040a4663          	bltz	s4,2b2 <formatLine+0x182>
                exec(args[0], args);
 26a:	85ce                	mv	a1,s3
 26c:	0009b503          	ld	a0,0(s3)
 270:	00000097          	auipc	ra,0x0
 274:	546080e7          	jalr	1350(ra) # 7b6 <exec>
                close(0);
 278:	4501                	li	a0,0
 27a:	00000097          	auipc	ra,0x0
 27e:	52c080e7          	jalr	1324(ra) # 7a6 <close>
                dup(STDIN_fileDescriptor);
 282:	854a                	mv	a0,s2
 284:	00000097          	auipc	ra,0x0
 288:	572080e7          	jalr	1394(ra) # 7f6 <dup>
                close(STDIN_fileDescriptor);
 28c:	854a                	mv	a0,s2
 28e:	00000097          	auipc	ra,0x0
 292:	518080e7          	jalr	1304(ra) # 7a6 <close>
 296:	a045                	j	336 <formatLine+0x206>
                    printf("File open error : exiting");
 298:	00001517          	auipc	a0,0x1
 29c:	a2850513          	addi	a0,a0,-1496 # cc0 <malloc+0x108>
 2a0:	00001097          	auipc	ra,0x1
 2a4:	860080e7          	jalr	-1952(ra) # b00 <printf>
                    exit(1);
 2a8:	4505                	li	a0,1
 2aa:	00000097          	auipc	ra,0x0
 2ae:	4d4080e7          	jalr	1236(ra) # 77e <exit>
                    printf("Dup error : exiting");
 2b2:	00001517          	auipc	a0,0x1
 2b6:	a2e50513          	addi	a0,a0,-1490 # ce0 <malloc+0x128>
 2ba:	00001097          	auipc	ra,0x1
 2be:	846080e7          	jalr	-1978(ra) # b00 <printf>
                    exit(1);
 2c2:	4505                	li	a0,1
 2c4:	00000097          	auipc	ra,0x0
 2c8:	4ba080e7          	jalr	1210(ra) # 77e <exit>
                    printf("File open error : exiting");
 2cc:	00001517          	auipc	a0,0x1
 2d0:	9f450513          	addi	a0,a0,-1548 # cc0 <malloc+0x108>
 2d4:	00001097          	auipc	ra,0x1
 2d8:	82c080e7          	jalr	-2004(ra) # b00 <printf>
                    exit(1);
 2dc:	4505                	li	a0,1
 2de:	00000097          	auipc	ra,0x0
 2e2:	4a0080e7          	jalr	1184(ra) # 77e <exit>
                    printf("Dup error : exiting");
 2e6:	00001517          	auipc	a0,0x1
 2ea:	9fa50513          	addi	a0,a0,-1542 # ce0 <malloc+0x128>
 2ee:	00001097          	auipc	ra,0x1
 2f2:	812080e7          	jalr	-2030(ra) # b00 <printf>
                    exit(1);
 2f6:	4505                	li	a0,1
 2f8:	00000097          	auipc	ra,0x0
 2fc:	486080e7          	jalr	1158(ra) # 77e <exit>
            } 
        }
        else 
        {
            // execute commands 
            if(exec(args[0], args) < 0)
 300:	85ce                	mv	a1,s3
 302:	0009b503          	ld	a0,0(s3)
 306:	00000097          	auipc	ra,0x0
 30a:	4b0080e7          	jalr	1200(ra) # 7b6 <exec>
 30e:	02055463          	bgez	a0,336 <formatLine+0x206>
            {
                printf("Exec error : exiting\n");
 312:	00001517          	auipc	a0,0x1
 316:	9e650513          	addi	a0,a0,-1562 # cf8 <malloc+0x140>
 31a:	00000097          	auipc	ra,0x0
 31e:	7e6080e7          	jalr	2022(ra) # b00 <printf>
                exit(1);
 322:	4505                	li	a0,1
 324:	00000097          	auipc	ra,0x0
 328:	45a080e7          	jalr	1114(ra) # 77e <exit>
            }
        }      

    } else // parent waits for child
    {
        wait(0);
 32c:	4501                	li	a0,0
 32e:	00000097          	auipc	ra,0x0
 332:	458080e7          	jalr	1112(ra) # 786 <wait>
    }    
}
 336:	70a2                	ld	ra,40(sp)
 338:	7402                	ld	s0,32(sp)
 33a:	64e2                	ld	s1,24(sp)
 33c:	6942                	ld	s2,16(sp)
 33e:	69a2                	ld	s3,8(sp)
 340:	6a02                	ld	s4,0(sp)
 342:	6145                	addi	sp,sp,48
 344:	8082                	ret

0000000000000346 <cd>:


// function to change directory
void
cd(char *path)
{
 346:	1141                	addi	sp,sp,-16
 348:	e406                	sd	ra,8(sp)
 34a:	e022                	sd	s0,0(sp)
 34c:	0800                	addi	s0,sp,16
    if(chdir(path) < 0)
 34e:	00000097          	auipc	ra,0x0
 352:	4a0080e7          	jalr	1184(ra) # 7ee <chdir>
 356:	00054663          	bltz	a0,362 <cd+0x1c>
    {   
        printf("cd error : exiting");
        exit(1);
    }
}
 35a:	60a2                	ld	ra,8(sp)
 35c:	6402                	ld	s0,0(sp)
 35e:	0141                	addi	sp,sp,16
 360:	8082                	ret
        printf("cd error : exiting");
 362:	00001517          	auipc	a0,0x1
 366:	9ae50513          	addi	a0,a0,-1618 # d10 <malloc+0x158>
 36a:	00000097          	auipc	ra,0x0
 36e:	796080e7          	jalr	1942(ra) # b00 <printf>
        exit(1);
 372:	4505                	li	a0,1
 374:	00000097          	auipc	ra,0x0
 378:	40a080e7          	jalr	1034(ra) # 77e <exit>

000000000000037c <removeLeadingSpaces>:

//function to remove leading spaces from extracted fileName
void
removeLeadingSpaces(char *file, char *newFile)
{
 37c:	1141                	addi	sp,sp,-16
 37e:	e422                	sd	s0,8(sp)
 380:	0800                	addi	s0,sp,16
    int i = 0;

    while (file[i] == ' ' || file[i] == '\t' || file[i] == '\n')
 382:	4781                	li	a5,0
 384:	02000813          	li	a6,32
 388:	4885                	li	a7,1
 38a:	a011                	j	38e <removeLeadingSpaces+0x12>
    {
        i++;
 38c:	0785                	addi	a5,a5,1
 38e:	0007861b          	sext.w	a2,a5
    while (file[i] == ' ' || file[i] == '\t' || file[i] == '\n')
 392:	00f50733          	add	a4,a0,a5
 396:	00074703          	lbu	a4,0(a4)
 39a:	ff0709e3          	beq	a4,a6,38c <removeLeadingSpaces+0x10>
 39e:	ff77069b          	addiw	a3,a4,-9
 3a2:	0ff6f693          	zext.b	a3,a3
 3a6:	fed8f3e3          	bgeu	a7,a3,38c <removeLeadingSpaces+0x10>
    }

    int k = 0;

    for(int j = i; file[j] != '\0'; j++)
 3aa:	c70d                	beqz	a4,3d4 <removeLeadingSpaces+0x58>
 3ac:	4785                	li	a5,1
    {
        newFile[k] = file[j];
 3ae:	00f586b3          	add	a3,a1,a5
 3b2:	fee68fa3          	sb	a4,-1(a3)
        k++;
 3b6:	0007869b          	sext.w	a3,a5
    for(int j = i; file[j] != '\0'; j++)
 3ba:	0785                	addi	a5,a5,1
 3bc:	00f60733          	add	a4,a2,a5
 3c0:	972a                	add	a4,a4,a0
 3c2:	fff74703          	lbu	a4,-1(a4)
 3c6:	f765                	bnez	a4,3ae <removeLeadingSpaces+0x32>
    }
    newFile[k] = '\0';  
 3c8:	95b6                	add	a1,a1,a3
 3ca:	00058023          	sb	zero,0(a1)
}
 3ce:	6422                	ld	s0,8(sp)
 3d0:	0141                	addi	sp,sp,16
 3d2:	8082                	ret
    int k = 0;
 3d4:	4681                	li	a3,0
 3d6:	bfcd                	j	3c8 <removeLeadingSpaces+0x4c>

00000000000003d8 <main>:



int 
main(int argc, char *argv[]) 
{
 3d8:	ac010113          	addi	sp,sp,-1344
 3dc:	52113c23          	sd	ra,1336(sp)
 3e0:	52813823          	sd	s0,1328(sp)
 3e4:	52913423          	sd	s1,1320(sp)
 3e8:	53213023          	sd	s2,1312(sp)
 3ec:	51313c23          	sd	s3,1304(sp)
 3f0:	51413823          	sd	s4,1296(sp)
 3f4:	51513423          	sd	s5,1288(sp)
 3f8:	51613023          	sd	s6,1280(sp)
 3fc:	54010413          	addi	s0,sp,1344
        // readLine will return 2 when it replaces \n AND it has a < or > operator 
        int readLineStatus = 0;
        readLineStatus = readLine(buffer, BUFSIZE);

        // special case for cd.
        if(buffer[0] == 'c' && buffer[1] == 'd' && buffer[2] == ' ')
 400:	06300a13          	li	s4,99
 404:	06400a93          	li	s5,100
 408:	02000b13          	li	s6,32
 40c:	a825                	j	444 <main+0x6c>
 40e:	00194783          	lbu	a5,1(s2)
 412:	09579763          	bne	a5,s5,4a0 <main+0xc8>
 416:	00294783          	lbu	a5,2(s2)
 41a:	09679363          	bne	a5,s6,4a0 <main+0xc8>
        {
            char *path = buffer + 3; // skip cd and get the directory path
            cd(path);
 41e:	00390513          	addi	a0,s2,3
 422:	00000097          	auipc	ra,0x0
 426:	f24080e7          	jalr	-220(ra) # 346 <cd>
 42a:	a89d                	j	4a0 <main+0xc8>
        {
            formatLine(buffer, args, redirectionFile, redirectionStatus);
           
        }
        //redirection needed, extract filename from buffer, remove leading spaces and then format the rest of the buffer ready for execution
        else if (readLineStatus == 1)
 42c:	4785                	li	a5,1
 42e:	08f48563          	beq	s1,a5,4b8 <main+0xe0>
            formatLine(buffer, args, newRedirectionFile, separatedRedirection);
           
        }
        else 
        {
            printf("readLine error");
 432:	00001517          	auipc	a0,0x1
 436:	8f650513          	addi	a0,a0,-1802 # d28 <malloc+0x170>
 43a:	00000097          	auipc	ra,0x0
 43e:	6c6080e7          	jalr	1734(ra) # b00 <printf>
 442:	814e                	mv	sp,s3
    {
 444:	898a                	mv	s3,sp
        char buffer[BUFSIZE];    
 446:	7101                	addi	sp,sp,-512
 448:	890a                	mv	s2,sp
        char* args[MAXARG] = { 0 };
 44a:	10000613          	li	a2,256
 44e:	4581                	li	a1,0
 450:	ac040513          	addi	a0,s0,-1344
 454:	00000097          	auipc	ra,0x0
 458:	130080e7          	jalr	304(ra) # 584 <memset>
        char redirectionFile[512] = { 0 };
 45c:	bc043023          	sd	zero,-1088(s0)
 460:	1f800613          	li	a2,504
 464:	4581                	li	a1,0
 466:	bc840513          	addi	a0,s0,-1080
 46a:	00000097          	auipc	ra,0x0
 46e:	11a080e7          	jalr	282(ra) # 584 <memset>
        char newRedirectionFile[512] = { 0 };
 472:	dc043023          	sd	zero,-576(s0)
 476:	1f800613          	li	a2,504
 47a:	4581                	li	a1,0
 47c:	dc840513          	addi	a0,s0,-568
 480:	00000097          	auipc	ra,0x0
 484:	104080e7          	jalr	260(ra) # 584 <memset>
        readLineStatus = readLine(buffer, BUFSIZE);
 488:	20000593          	li	a1,512
 48c:	850a                	mv	a0,sp
 48e:	00000097          	auipc	ra,0x0
 492:	b72080e7          	jalr	-1166(ra) # 0 <readLine>
 496:	84aa                	mv	s1,a0
        if(buffer[0] == 'c' && buffer[1] == 'd' && buffer[2] == ' ')
 498:	00014783          	lbu	a5,0(sp)
 49c:	f74789e3          	beq	a5,s4,40e <main+0x36>
        if (readLineStatus == 0)
 4a0:	f4d1                	bnez	s1,42c <main+0x54>
            formatLine(buffer, args, redirectionFile, redirectionStatus);
 4a2:	4681                	li	a3,0
 4a4:	bc040613          	addi	a2,s0,-1088
 4a8:	ac040593          	addi	a1,s0,-1344
 4ac:	854a                	mv	a0,s2
 4ae:	00000097          	auipc	ra,0x0
 4b2:	c82080e7          	jalr	-894(ra) # 130 <formatLine>
 4b6:	b771                	j	442 <main+0x6a>
            int separatedRedirection = separateRedirection(buffer, args, redirectionFile, BUFSIZE, redirectionStatus);
 4b8:	4701                	li	a4,0
 4ba:	20000693          	li	a3,512
 4be:	bc040613          	addi	a2,s0,-1088
 4c2:	ac040593          	addi	a1,s0,-1344
 4c6:	854a                	mv	a0,s2
 4c8:	00000097          	auipc	ra,0x0
 4cc:	be2080e7          	jalr	-1054(ra) # aa <separateRedirection>
 4d0:	84aa                	mv	s1,a0
            removeLeadingSpaces(redirectionFile, newRedirectionFile);
 4d2:	dc040593          	addi	a1,s0,-576
 4d6:	bc040513          	addi	a0,s0,-1088
 4da:	00000097          	auipc	ra,0x0
 4de:	ea2080e7          	jalr	-350(ra) # 37c <removeLeadingSpaces>
            formatLine(buffer, args, newRedirectionFile, separatedRedirection);
 4e2:	86a6                	mv	a3,s1
 4e4:	dc040613          	addi	a2,s0,-576
 4e8:	ac040593          	addi	a1,s0,-1344
 4ec:	854a                	mv	a0,s2
 4ee:	00000097          	auipc	ra,0x0
 4f2:	c42080e7          	jalr	-958(ra) # 130 <formatLine>
 4f6:	b7b1                	j	442 <main+0x6a>

00000000000004f8 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 4f8:	1141                	addi	sp,sp,-16
 4fa:	e406                	sd	ra,8(sp)
 4fc:	e022                	sd	s0,0(sp)
 4fe:	0800                	addi	s0,sp,16
  extern int main();
  main();
 500:	00000097          	auipc	ra,0x0
 504:	ed8080e7          	jalr	-296(ra) # 3d8 <main>
  exit(0);
 508:	4501                	li	a0,0
 50a:	00000097          	auipc	ra,0x0
 50e:	274080e7          	jalr	628(ra) # 77e <exit>

0000000000000512 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 512:	1141                	addi	sp,sp,-16
 514:	e422                	sd	s0,8(sp)
 516:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 518:	87aa                	mv	a5,a0
 51a:	0585                	addi	a1,a1,1
 51c:	0785                	addi	a5,a5,1
 51e:	fff5c703          	lbu	a4,-1(a1)
 522:	fee78fa3          	sb	a4,-1(a5)
 526:	fb75                	bnez	a4,51a <strcpy+0x8>
    ;
  return os;
}
 528:	6422                	ld	s0,8(sp)
 52a:	0141                	addi	sp,sp,16
 52c:	8082                	ret

000000000000052e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 52e:	1141                	addi	sp,sp,-16
 530:	e422                	sd	s0,8(sp)
 532:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 534:	00054783          	lbu	a5,0(a0)
 538:	cb91                	beqz	a5,54c <strcmp+0x1e>
 53a:	0005c703          	lbu	a4,0(a1)
 53e:	00f71763          	bne	a4,a5,54c <strcmp+0x1e>
    p++, q++;
 542:	0505                	addi	a0,a0,1
 544:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 546:	00054783          	lbu	a5,0(a0)
 54a:	fbe5                	bnez	a5,53a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 54c:	0005c503          	lbu	a0,0(a1)
}
 550:	40a7853b          	subw	a0,a5,a0
 554:	6422                	ld	s0,8(sp)
 556:	0141                	addi	sp,sp,16
 558:	8082                	ret

000000000000055a <strlen>:

uint
strlen(const char *s)
{
 55a:	1141                	addi	sp,sp,-16
 55c:	e422                	sd	s0,8(sp)
 55e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 560:	00054783          	lbu	a5,0(a0)
 564:	cf91                	beqz	a5,580 <strlen+0x26>
 566:	0505                	addi	a0,a0,1
 568:	87aa                	mv	a5,a0
 56a:	4685                	li	a3,1
 56c:	9e89                	subw	a3,a3,a0
 56e:	00f6853b          	addw	a0,a3,a5
 572:	0785                	addi	a5,a5,1
 574:	fff7c703          	lbu	a4,-1(a5)
 578:	fb7d                	bnez	a4,56e <strlen+0x14>
    ;
  return n;
}
 57a:	6422                	ld	s0,8(sp)
 57c:	0141                	addi	sp,sp,16
 57e:	8082                	ret
  for(n = 0; s[n]; n++)
 580:	4501                	li	a0,0
 582:	bfe5                	j	57a <strlen+0x20>

0000000000000584 <memset>:

void*
memset(void *dst, int c, uint n)
{
 584:	1141                	addi	sp,sp,-16
 586:	e422                	sd	s0,8(sp)
 588:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 58a:	ca19                	beqz	a2,5a0 <memset+0x1c>
 58c:	87aa                	mv	a5,a0
 58e:	1602                	slli	a2,a2,0x20
 590:	9201                	srli	a2,a2,0x20
 592:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 596:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 59a:	0785                	addi	a5,a5,1
 59c:	fee79de3          	bne	a5,a4,596 <memset+0x12>
  }
  return dst;
}
 5a0:	6422                	ld	s0,8(sp)
 5a2:	0141                	addi	sp,sp,16
 5a4:	8082                	ret

00000000000005a6 <strchr>:

char*
strchr(const char *s, char c)
{
 5a6:	1141                	addi	sp,sp,-16
 5a8:	e422                	sd	s0,8(sp)
 5aa:	0800                	addi	s0,sp,16
  for(; *s; s++)
 5ac:	00054783          	lbu	a5,0(a0)
 5b0:	cb99                	beqz	a5,5c6 <strchr+0x20>
    if(*s == c)
 5b2:	00f58763          	beq	a1,a5,5c0 <strchr+0x1a>
  for(; *s; s++)
 5b6:	0505                	addi	a0,a0,1
 5b8:	00054783          	lbu	a5,0(a0)
 5bc:	fbfd                	bnez	a5,5b2 <strchr+0xc>
      return (char*)s;
  return 0;
 5be:	4501                	li	a0,0
}
 5c0:	6422                	ld	s0,8(sp)
 5c2:	0141                	addi	sp,sp,16
 5c4:	8082                	ret
  return 0;
 5c6:	4501                	li	a0,0
 5c8:	bfe5                	j	5c0 <strchr+0x1a>

00000000000005ca <gets>:

char*
gets(char *buf, int max)
{
 5ca:	711d                	addi	sp,sp,-96
 5cc:	ec86                	sd	ra,88(sp)
 5ce:	e8a2                	sd	s0,80(sp)
 5d0:	e4a6                	sd	s1,72(sp)
 5d2:	e0ca                	sd	s2,64(sp)
 5d4:	fc4e                	sd	s3,56(sp)
 5d6:	f852                	sd	s4,48(sp)
 5d8:	f456                	sd	s5,40(sp)
 5da:	f05a                	sd	s6,32(sp)
 5dc:	ec5e                	sd	s7,24(sp)
 5de:	1080                	addi	s0,sp,96
 5e0:	8baa                	mv	s7,a0
 5e2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 5e4:	892a                	mv	s2,a0
 5e6:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 5e8:	4aa9                	li	s5,10
 5ea:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 5ec:	89a6                	mv	s3,s1
 5ee:	2485                	addiw	s1,s1,1
 5f0:	0344d863          	bge	s1,s4,620 <gets+0x56>
    cc = read(0, &c, 1);
 5f4:	4605                	li	a2,1
 5f6:	faf40593          	addi	a1,s0,-81
 5fa:	4501                	li	a0,0
 5fc:	00000097          	auipc	ra,0x0
 600:	19a080e7          	jalr	410(ra) # 796 <read>
    if(cc < 1)
 604:	00a05e63          	blez	a0,620 <gets+0x56>
    buf[i++] = c;
 608:	faf44783          	lbu	a5,-81(s0)
 60c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 610:	01578763          	beq	a5,s5,61e <gets+0x54>
 614:	0905                	addi	s2,s2,1
 616:	fd679be3          	bne	a5,s6,5ec <gets+0x22>
  for(i=0; i+1 < max; ){
 61a:	89a6                	mv	s3,s1
 61c:	a011                	j	620 <gets+0x56>
 61e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 620:	99de                	add	s3,s3,s7
 622:	00098023          	sb	zero,0(s3)
  return buf;
}
 626:	855e                	mv	a0,s7
 628:	60e6                	ld	ra,88(sp)
 62a:	6446                	ld	s0,80(sp)
 62c:	64a6                	ld	s1,72(sp)
 62e:	6906                	ld	s2,64(sp)
 630:	79e2                	ld	s3,56(sp)
 632:	7a42                	ld	s4,48(sp)
 634:	7aa2                	ld	s5,40(sp)
 636:	7b02                	ld	s6,32(sp)
 638:	6be2                	ld	s7,24(sp)
 63a:	6125                	addi	sp,sp,96
 63c:	8082                	ret

000000000000063e <stat>:

int
stat(const char *n, struct stat *st)
{
 63e:	1101                	addi	sp,sp,-32
 640:	ec06                	sd	ra,24(sp)
 642:	e822                	sd	s0,16(sp)
 644:	e426                	sd	s1,8(sp)
 646:	e04a                	sd	s2,0(sp)
 648:	1000                	addi	s0,sp,32
 64a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 64c:	4581                	li	a1,0
 64e:	00000097          	auipc	ra,0x0
 652:	170080e7          	jalr	368(ra) # 7be <open>
  if(fd < 0)
 656:	02054563          	bltz	a0,680 <stat+0x42>
 65a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 65c:	85ca                	mv	a1,s2
 65e:	00000097          	auipc	ra,0x0
 662:	178080e7          	jalr	376(ra) # 7d6 <fstat>
 666:	892a                	mv	s2,a0
  close(fd);
 668:	8526                	mv	a0,s1
 66a:	00000097          	auipc	ra,0x0
 66e:	13c080e7          	jalr	316(ra) # 7a6 <close>
  return r;
}
 672:	854a                	mv	a0,s2
 674:	60e2                	ld	ra,24(sp)
 676:	6442                	ld	s0,16(sp)
 678:	64a2                	ld	s1,8(sp)
 67a:	6902                	ld	s2,0(sp)
 67c:	6105                	addi	sp,sp,32
 67e:	8082                	ret
    return -1;
 680:	597d                	li	s2,-1
 682:	bfc5                	j	672 <stat+0x34>

0000000000000684 <atoi>:

int
atoi(const char *s)
{
 684:	1141                	addi	sp,sp,-16
 686:	e422                	sd	s0,8(sp)
 688:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 68a:	00054683          	lbu	a3,0(a0)
 68e:	fd06879b          	addiw	a5,a3,-48
 692:	0ff7f793          	zext.b	a5,a5
 696:	4625                	li	a2,9
 698:	02f66863          	bltu	a2,a5,6c8 <atoi+0x44>
 69c:	872a                	mv	a4,a0
  n = 0;
 69e:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 6a0:	0705                	addi	a4,a4,1
 6a2:	0025179b          	slliw	a5,a0,0x2
 6a6:	9fa9                	addw	a5,a5,a0
 6a8:	0017979b          	slliw	a5,a5,0x1
 6ac:	9fb5                	addw	a5,a5,a3
 6ae:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 6b2:	00074683          	lbu	a3,0(a4)
 6b6:	fd06879b          	addiw	a5,a3,-48
 6ba:	0ff7f793          	zext.b	a5,a5
 6be:	fef671e3          	bgeu	a2,a5,6a0 <atoi+0x1c>
  return n;
}
 6c2:	6422                	ld	s0,8(sp)
 6c4:	0141                	addi	sp,sp,16
 6c6:	8082                	ret
  n = 0;
 6c8:	4501                	li	a0,0
 6ca:	bfe5                	j	6c2 <atoi+0x3e>

00000000000006cc <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 6cc:	1141                	addi	sp,sp,-16
 6ce:	e422                	sd	s0,8(sp)
 6d0:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 6d2:	02b57463          	bgeu	a0,a1,6fa <memmove+0x2e>
    while(n-- > 0)
 6d6:	00c05f63          	blez	a2,6f4 <memmove+0x28>
 6da:	1602                	slli	a2,a2,0x20
 6dc:	9201                	srli	a2,a2,0x20
 6de:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 6e2:	872a                	mv	a4,a0
      *dst++ = *src++;
 6e4:	0585                	addi	a1,a1,1
 6e6:	0705                	addi	a4,a4,1
 6e8:	fff5c683          	lbu	a3,-1(a1)
 6ec:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 6f0:	fee79ae3          	bne	a5,a4,6e4 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 6f4:	6422                	ld	s0,8(sp)
 6f6:	0141                	addi	sp,sp,16
 6f8:	8082                	ret
    dst += n;
 6fa:	00c50733          	add	a4,a0,a2
    src += n;
 6fe:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 700:	fec05ae3          	blez	a2,6f4 <memmove+0x28>
 704:	fff6079b          	addiw	a5,a2,-1
 708:	1782                	slli	a5,a5,0x20
 70a:	9381                	srli	a5,a5,0x20
 70c:	fff7c793          	not	a5,a5
 710:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 712:	15fd                	addi	a1,a1,-1
 714:	177d                	addi	a4,a4,-1
 716:	0005c683          	lbu	a3,0(a1)
 71a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 71e:	fee79ae3          	bne	a5,a4,712 <memmove+0x46>
 722:	bfc9                	j	6f4 <memmove+0x28>

0000000000000724 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 724:	1141                	addi	sp,sp,-16
 726:	e422                	sd	s0,8(sp)
 728:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 72a:	ca05                	beqz	a2,75a <memcmp+0x36>
 72c:	fff6069b          	addiw	a3,a2,-1
 730:	1682                	slli	a3,a3,0x20
 732:	9281                	srli	a3,a3,0x20
 734:	0685                	addi	a3,a3,1
 736:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 738:	00054783          	lbu	a5,0(a0)
 73c:	0005c703          	lbu	a4,0(a1)
 740:	00e79863          	bne	a5,a4,750 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 744:	0505                	addi	a0,a0,1
    p2++;
 746:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 748:	fed518e3          	bne	a0,a3,738 <memcmp+0x14>
  }
  return 0;
 74c:	4501                	li	a0,0
 74e:	a019                	j	754 <memcmp+0x30>
      return *p1 - *p2;
 750:	40e7853b          	subw	a0,a5,a4
}
 754:	6422                	ld	s0,8(sp)
 756:	0141                	addi	sp,sp,16
 758:	8082                	ret
  return 0;
 75a:	4501                	li	a0,0
 75c:	bfe5                	j	754 <memcmp+0x30>

000000000000075e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 75e:	1141                	addi	sp,sp,-16
 760:	e406                	sd	ra,8(sp)
 762:	e022                	sd	s0,0(sp)
 764:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 766:	00000097          	auipc	ra,0x0
 76a:	f66080e7          	jalr	-154(ra) # 6cc <memmove>
}
 76e:	60a2                	ld	ra,8(sp)
 770:	6402                	ld	s0,0(sp)
 772:	0141                	addi	sp,sp,16
 774:	8082                	ret

0000000000000776 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 776:	4885                	li	a7,1
 ecall
 778:	00000073          	ecall
 ret
 77c:	8082                	ret

000000000000077e <exit>:
.global exit
exit:
 li a7, SYS_exit
 77e:	4889                	li	a7,2
 ecall
 780:	00000073          	ecall
 ret
 784:	8082                	ret

0000000000000786 <wait>:
.global wait
wait:
 li a7, SYS_wait
 786:	488d                	li	a7,3
 ecall
 788:	00000073          	ecall
 ret
 78c:	8082                	ret

000000000000078e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 78e:	4891                	li	a7,4
 ecall
 790:	00000073          	ecall
 ret
 794:	8082                	ret

0000000000000796 <read>:
.global read
read:
 li a7, SYS_read
 796:	4895                	li	a7,5
 ecall
 798:	00000073          	ecall
 ret
 79c:	8082                	ret

000000000000079e <write>:
.global write
write:
 li a7, SYS_write
 79e:	48c1                	li	a7,16
 ecall
 7a0:	00000073          	ecall
 ret
 7a4:	8082                	ret

00000000000007a6 <close>:
.global close
close:
 li a7, SYS_close
 7a6:	48d5                	li	a7,21
 ecall
 7a8:	00000073          	ecall
 ret
 7ac:	8082                	ret

00000000000007ae <kill>:
.global kill
kill:
 li a7, SYS_kill
 7ae:	4899                	li	a7,6
 ecall
 7b0:	00000073          	ecall
 ret
 7b4:	8082                	ret

00000000000007b6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 7b6:	489d                	li	a7,7
 ecall
 7b8:	00000073          	ecall
 ret
 7bc:	8082                	ret

00000000000007be <open>:
.global open
open:
 li a7, SYS_open
 7be:	48bd                	li	a7,15
 ecall
 7c0:	00000073          	ecall
 ret
 7c4:	8082                	ret

00000000000007c6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 7c6:	48c5                	li	a7,17
 ecall
 7c8:	00000073          	ecall
 ret
 7cc:	8082                	ret

00000000000007ce <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 7ce:	48c9                	li	a7,18
 ecall
 7d0:	00000073          	ecall
 ret
 7d4:	8082                	ret

00000000000007d6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 7d6:	48a1                	li	a7,8
 ecall
 7d8:	00000073          	ecall
 ret
 7dc:	8082                	ret

00000000000007de <link>:
.global link
link:
 li a7, SYS_link
 7de:	48cd                	li	a7,19
 ecall
 7e0:	00000073          	ecall
 ret
 7e4:	8082                	ret

00000000000007e6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 7e6:	48d1                	li	a7,20
 ecall
 7e8:	00000073          	ecall
 ret
 7ec:	8082                	ret

00000000000007ee <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 7ee:	48a5                	li	a7,9
 ecall
 7f0:	00000073          	ecall
 ret
 7f4:	8082                	ret

00000000000007f6 <dup>:
.global dup
dup:
 li a7, SYS_dup
 7f6:	48a9                	li	a7,10
 ecall
 7f8:	00000073          	ecall
 ret
 7fc:	8082                	ret

00000000000007fe <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 7fe:	48ad                	li	a7,11
 ecall
 800:	00000073          	ecall
 ret
 804:	8082                	ret

0000000000000806 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 806:	48b1                	li	a7,12
 ecall
 808:	00000073          	ecall
 ret
 80c:	8082                	ret

000000000000080e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 80e:	48b5                	li	a7,13
 ecall
 810:	00000073          	ecall
 ret
 814:	8082                	ret

0000000000000816 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 816:	48b9                	li	a7,14
 ecall
 818:	00000073          	ecall
 ret
 81c:	8082                	ret

000000000000081e <getyear>:
.global getyear
getyear:
 li a7, SYS_getyear
 81e:	48d9                	li	a7,22
 ecall
 820:	00000073          	ecall
 ret
 824:	8082                	ret

0000000000000826 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 826:	1101                	addi	sp,sp,-32
 828:	ec06                	sd	ra,24(sp)
 82a:	e822                	sd	s0,16(sp)
 82c:	1000                	addi	s0,sp,32
 82e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 832:	4605                	li	a2,1
 834:	fef40593          	addi	a1,s0,-17
 838:	00000097          	auipc	ra,0x0
 83c:	f66080e7          	jalr	-154(ra) # 79e <write>
}
 840:	60e2                	ld	ra,24(sp)
 842:	6442                	ld	s0,16(sp)
 844:	6105                	addi	sp,sp,32
 846:	8082                	ret

0000000000000848 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 848:	7139                	addi	sp,sp,-64
 84a:	fc06                	sd	ra,56(sp)
 84c:	f822                	sd	s0,48(sp)
 84e:	f426                	sd	s1,40(sp)
 850:	f04a                	sd	s2,32(sp)
 852:	ec4e                	sd	s3,24(sp)
 854:	0080                	addi	s0,sp,64
 856:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 858:	c299                	beqz	a3,85e <printint+0x16>
 85a:	0805c963          	bltz	a1,8ec <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 85e:	2581                	sext.w	a1,a1
  neg = 0;
 860:	4881                	li	a7,0
 862:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 866:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 868:	2601                	sext.w	a2,a2
 86a:	00000517          	auipc	a0,0x0
 86e:	52e50513          	addi	a0,a0,1326 # d98 <digits>
 872:	883a                	mv	a6,a4
 874:	2705                	addiw	a4,a4,1
 876:	02c5f7bb          	remuw	a5,a1,a2
 87a:	1782                	slli	a5,a5,0x20
 87c:	9381                	srli	a5,a5,0x20
 87e:	97aa                	add	a5,a5,a0
 880:	0007c783          	lbu	a5,0(a5)
 884:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 888:	0005879b          	sext.w	a5,a1
 88c:	02c5d5bb          	divuw	a1,a1,a2
 890:	0685                	addi	a3,a3,1
 892:	fec7f0e3          	bgeu	a5,a2,872 <printint+0x2a>
  if(neg)
 896:	00088c63          	beqz	a7,8ae <printint+0x66>
    buf[i++] = '-';
 89a:	fd070793          	addi	a5,a4,-48
 89e:	00878733          	add	a4,a5,s0
 8a2:	02d00793          	li	a5,45
 8a6:	fef70823          	sb	a5,-16(a4)
 8aa:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 8ae:	02e05863          	blez	a4,8de <printint+0x96>
 8b2:	fc040793          	addi	a5,s0,-64
 8b6:	00e78933          	add	s2,a5,a4
 8ba:	fff78993          	addi	s3,a5,-1
 8be:	99ba                	add	s3,s3,a4
 8c0:	377d                	addiw	a4,a4,-1
 8c2:	1702                	slli	a4,a4,0x20
 8c4:	9301                	srli	a4,a4,0x20
 8c6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 8ca:	fff94583          	lbu	a1,-1(s2)
 8ce:	8526                	mv	a0,s1
 8d0:	00000097          	auipc	ra,0x0
 8d4:	f56080e7          	jalr	-170(ra) # 826 <putc>
  while(--i >= 0)
 8d8:	197d                	addi	s2,s2,-1
 8da:	ff3918e3          	bne	s2,s3,8ca <printint+0x82>
}
 8de:	70e2                	ld	ra,56(sp)
 8e0:	7442                	ld	s0,48(sp)
 8e2:	74a2                	ld	s1,40(sp)
 8e4:	7902                	ld	s2,32(sp)
 8e6:	69e2                	ld	s3,24(sp)
 8e8:	6121                	addi	sp,sp,64
 8ea:	8082                	ret
    x = -xx;
 8ec:	40b005bb          	negw	a1,a1
    neg = 1;
 8f0:	4885                	li	a7,1
    x = -xx;
 8f2:	bf85                	j	862 <printint+0x1a>

00000000000008f4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 8f4:	7119                	addi	sp,sp,-128
 8f6:	fc86                	sd	ra,120(sp)
 8f8:	f8a2                	sd	s0,112(sp)
 8fa:	f4a6                	sd	s1,104(sp)
 8fc:	f0ca                	sd	s2,96(sp)
 8fe:	ecce                	sd	s3,88(sp)
 900:	e8d2                	sd	s4,80(sp)
 902:	e4d6                	sd	s5,72(sp)
 904:	e0da                	sd	s6,64(sp)
 906:	fc5e                	sd	s7,56(sp)
 908:	f862                	sd	s8,48(sp)
 90a:	f466                	sd	s9,40(sp)
 90c:	f06a                	sd	s10,32(sp)
 90e:	ec6e                	sd	s11,24(sp)
 910:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 912:	0005c903          	lbu	s2,0(a1)
 916:	18090f63          	beqz	s2,ab4 <vprintf+0x1c0>
 91a:	8aaa                	mv	s5,a0
 91c:	8b32                	mv	s6,a2
 91e:	00158493          	addi	s1,a1,1
  state = 0;
 922:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 924:	02500a13          	li	s4,37
 928:	4c55                	li	s8,21
 92a:	00000c97          	auipc	s9,0x0
 92e:	416c8c93          	addi	s9,s9,1046 # d40 <malloc+0x188>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 932:	02800d93          	li	s11,40
  putc(fd, 'x');
 936:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 938:	00000b97          	auipc	s7,0x0
 93c:	460b8b93          	addi	s7,s7,1120 # d98 <digits>
 940:	a839                	j	95e <vprintf+0x6a>
        putc(fd, c);
 942:	85ca                	mv	a1,s2
 944:	8556                	mv	a0,s5
 946:	00000097          	auipc	ra,0x0
 94a:	ee0080e7          	jalr	-288(ra) # 826 <putc>
 94e:	a019                	j	954 <vprintf+0x60>
    } else if(state == '%'){
 950:	01498d63          	beq	s3,s4,96a <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 954:	0485                	addi	s1,s1,1
 956:	fff4c903          	lbu	s2,-1(s1)
 95a:	14090d63          	beqz	s2,ab4 <vprintf+0x1c0>
    if(state == 0){
 95e:	fe0999e3          	bnez	s3,950 <vprintf+0x5c>
      if(c == '%'){
 962:	ff4910e3          	bne	s2,s4,942 <vprintf+0x4e>
        state = '%';
 966:	89d2                	mv	s3,s4
 968:	b7f5                	j	954 <vprintf+0x60>
      if(c == 'd'){
 96a:	11490c63          	beq	s2,s4,a82 <vprintf+0x18e>
 96e:	f9d9079b          	addiw	a5,s2,-99
 972:	0ff7f793          	zext.b	a5,a5
 976:	10fc6e63          	bltu	s8,a5,a92 <vprintf+0x19e>
 97a:	f9d9079b          	addiw	a5,s2,-99
 97e:	0ff7f713          	zext.b	a4,a5
 982:	10ec6863          	bltu	s8,a4,a92 <vprintf+0x19e>
 986:	00271793          	slli	a5,a4,0x2
 98a:	97e6                	add	a5,a5,s9
 98c:	439c                	lw	a5,0(a5)
 98e:	97e6                	add	a5,a5,s9
 990:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 992:	008b0913          	addi	s2,s6,8
 996:	4685                	li	a3,1
 998:	4629                	li	a2,10
 99a:	000b2583          	lw	a1,0(s6)
 99e:	8556                	mv	a0,s5
 9a0:	00000097          	auipc	ra,0x0
 9a4:	ea8080e7          	jalr	-344(ra) # 848 <printint>
 9a8:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 9aa:	4981                	li	s3,0
 9ac:	b765                	j	954 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9ae:	008b0913          	addi	s2,s6,8
 9b2:	4681                	li	a3,0
 9b4:	4629                	li	a2,10
 9b6:	000b2583          	lw	a1,0(s6)
 9ba:	8556                	mv	a0,s5
 9bc:	00000097          	auipc	ra,0x0
 9c0:	e8c080e7          	jalr	-372(ra) # 848 <printint>
 9c4:	8b4a                	mv	s6,s2
      state = 0;
 9c6:	4981                	li	s3,0
 9c8:	b771                	j	954 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 9ca:	008b0913          	addi	s2,s6,8
 9ce:	4681                	li	a3,0
 9d0:	866a                	mv	a2,s10
 9d2:	000b2583          	lw	a1,0(s6)
 9d6:	8556                	mv	a0,s5
 9d8:	00000097          	auipc	ra,0x0
 9dc:	e70080e7          	jalr	-400(ra) # 848 <printint>
 9e0:	8b4a                	mv	s6,s2
      state = 0;
 9e2:	4981                	li	s3,0
 9e4:	bf85                	j	954 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 9e6:	008b0793          	addi	a5,s6,8
 9ea:	f8f43423          	sd	a5,-120(s0)
 9ee:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 9f2:	03000593          	li	a1,48
 9f6:	8556                	mv	a0,s5
 9f8:	00000097          	auipc	ra,0x0
 9fc:	e2e080e7          	jalr	-466(ra) # 826 <putc>
  putc(fd, 'x');
 a00:	07800593          	li	a1,120
 a04:	8556                	mv	a0,s5
 a06:	00000097          	auipc	ra,0x0
 a0a:	e20080e7          	jalr	-480(ra) # 826 <putc>
 a0e:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a10:	03c9d793          	srli	a5,s3,0x3c
 a14:	97de                	add	a5,a5,s7
 a16:	0007c583          	lbu	a1,0(a5)
 a1a:	8556                	mv	a0,s5
 a1c:	00000097          	auipc	ra,0x0
 a20:	e0a080e7          	jalr	-502(ra) # 826 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a24:	0992                	slli	s3,s3,0x4
 a26:	397d                	addiw	s2,s2,-1
 a28:	fe0914e3          	bnez	s2,a10 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 a2c:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 a30:	4981                	li	s3,0
 a32:	b70d                	j	954 <vprintf+0x60>
        s = va_arg(ap, char*);
 a34:	008b0913          	addi	s2,s6,8
 a38:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 a3c:	02098163          	beqz	s3,a5e <vprintf+0x16a>
        while(*s != 0){
 a40:	0009c583          	lbu	a1,0(s3)
 a44:	c5ad                	beqz	a1,aae <vprintf+0x1ba>
          putc(fd, *s);
 a46:	8556                	mv	a0,s5
 a48:	00000097          	auipc	ra,0x0
 a4c:	dde080e7          	jalr	-546(ra) # 826 <putc>
          s++;
 a50:	0985                	addi	s3,s3,1
        while(*s != 0){
 a52:	0009c583          	lbu	a1,0(s3)
 a56:	f9e5                	bnez	a1,a46 <vprintf+0x152>
        s = va_arg(ap, char*);
 a58:	8b4a                	mv	s6,s2
      state = 0;
 a5a:	4981                	li	s3,0
 a5c:	bde5                	j	954 <vprintf+0x60>
          s = "(null)";
 a5e:	00000997          	auipc	s3,0x0
 a62:	2da98993          	addi	s3,s3,730 # d38 <malloc+0x180>
        while(*s != 0){
 a66:	85ee                	mv	a1,s11
 a68:	bff9                	j	a46 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 a6a:	008b0913          	addi	s2,s6,8
 a6e:	000b4583          	lbu	a1,0(s6)
 a72:	8556                	mv	a0,s5
 a74:	00000097          	auipc	ra,0x0
 a78:	db2080e7          	jalr	-590(ra) # 826 <putc>
 a7c:	8b4a                	mv	s6,s2
      state = 0;
 a7e:	4981                	li	s3,0
 a80:	bdd1                	j	954 <vprintf+0x60>
        putc(fd, c);
 a82:	85d2                	mv	a1,s4
 a84:	8556                	mv	a0,s5
 a86:	00000097          	auipc	ra,0x0
 a8a:	da0080e7          	jalr	-608(ra) # 826 <putc>
      state = 0;
 a8e:	4981                	li	s3,0
 a90:	b5d1                	j	954 <vprintf+0x60>
        putc(fd, '%');
 a92:	85d2                	mv	a1,s4
 a94:	8556                	mv	a0,s5
 a96:	00000097          	auipc	ra,0x0
 a9a:	d90080e7          	jalr	-624(ra) # 826 <putc>
        putc(fd, c);
 a9e:	85ca                	mv	a1,s2
 aa0:	8556                	mv	a0,s5
 aa2:	00000097          	auipc	ra,0x0
 aa6:	d84080e7          	jalr	-636(ra) # 826 <putc>
      state = 0;
 aaa:	4981                	li	s3,0
 aac:	b565                	j	954 <vprintf+0x60>
        s = va_arg(ap, char*);
 aae:	8b4a                	mv	s6,s2
      state = 0;
 ab0:	4981                	li	s3,0
 ab2:	b54d                	j	954 <vprintf+0x60>
    }
  }
}
 ab4:	70e6                	ld	ra,120(sp)
 ab6:	7446                	ld	s0,112(sp)
 ab8:	74a6                	ld	s1,104(sp)
 aba:	7906                	ld	s2,96(sp)
 abc:	69e6                	ld	s3,88(sp)
 abe:	6a46                	ld	s4,80(sp)
 ac0:	6aa6                	ld	s5,72(sp)
 ac2:	6b06                	ld	s6,64(sp)
 ac4:	7be2                	ld	s7,56(sp)
 ac6:	7c42                	ld	s8,48(sp)
 ac8:	7ca2                	ld	s9,40(sp)
 aca:	7d02                	ld	s10,32(sp)
 acc:	6de2                	ld	s11,24(sp)
 ace:	6109                	addi	sp,sp,128
 ad0:	8082                	ret

0000000000000ad2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 ad2:	715d                	addi	sp,sp,-80
 ad4:	ec06                	sd	ra,24(sp)
 ad6:	e822                	sd	s0,16(sp)
 ad8:	1000                	addi	s0,sp,32
 ada:	e010                	sd	a2,0(s0)
 adc:	e414                	sd	a3,8(s0)
 ade:	e818                	sd	a4,16(s0)
 ae0:	ec1c                	sd	a5,24(s0)
 ae2:	03043023          	sd	a6,32(s0)
 ae6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 aea:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 aee:	8622                	mv	a2,s0
 af0:	00000097          	auipc	ra,0x0
 af4:	e04080e7          	jalr	-508(ra) # 8f4 <vprintf>
}
 af8:	60e2                	ld	ra,24(sp)
 afa:	6442                	ld	s0,16(sp)
 afc:	6161                	addi	sp,sp,80
 afe:	8082                	ret

0000000000000b00 <printf>:

void
printf(const char *fmt, ...)
{
 b00:	711d                	addi	sp,sp,-96
 b02:	ec06                	sd	ra,24(sp)
 b04:	e822                	sd	s0,16(sp)
 b06:	1000                	addi	s0,sp,32
 b08:	e40c                	sd	a1,8(s0)
 b0a:	e810                	sd	a2,16(s0)
 b0c:	ec14                	sd	a3,24(s0)
 b0e:	f018                	sd	a4,32(s0)
 b10:	f41c                	sd	a5,40(s0)
 b12:	03043823          	sd	a6,48(s0)
 b16:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b1a:	00840613          	addi	a2,s0,8
 b1e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b22:	85aa                	mv	a1,a0
 b24:	4505                	li	a0,1
 b26:	00000097          	auipc	ra,0x0
 b2a:	dce080e7          	jalr	-562(ra) # 8f4 <vprintf>
}
 b2e:	60e2                	ld	ra,24(sp)
 b30:	6442                	ld	s0,16(sp)
 b32:	6125                	addi	sp,sp,96
 b34:	8082                	ret

0000000000000b36 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b36:	1141                	addi	sp,sp,-16
 b38:	e422                	sd	s0,8(sp)
 b3a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b3c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b40:	00000797          	auipc	a5,0x0
 b44:	4c07b783          	ld	a5,1216(a5) # 1000 <freep>
 b48:	a02d                	j	b72 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b4a:	4618                	lw	a4,8(a2)
 b4c:	9f2d                	addw	a4,a4,a1
 b4e:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 b52:	6398                	ld	a4,0(a5)
 b54:	6310                	ld	a2,0(a4)
 b56:	a83d                	j	b94 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 b58:	ff852703          	lw	a4,-8(a0)
 b5c:	9f31                	addw	a4,a4,a2
 b5e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b60:	ff053683          	ld	a3,-16(a0)
 b64:	a091                	j	ba8 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b66:	6398                	ld	a4,0(a5)
 b68:	00e7e463          	bltu	a5,a4,b70 <free+0x3a>
 b6c:	00e6ea63          	bltu	a3,a4,b80 <free+0x4a>
{
 b70:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b72:	fed7fae3          	bgeu	a5,a3,b66 <free+0x30>
 b76:	6398                	ld	a4,0(a5)
 b78:	00e6e463          	bltu	a3,a4,b80 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b7c:	fee7eae3          	bltu	a5,a4,b70 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 b80:	ff852583          	lw	a1,-8(a0)
 b84:	6390                	ld	a2,0(a5)
 b86:	02059813          	slli	a6,a1,0x20
 b8a:	01c85713          	srli	a4,a6,0x1c
 b8e:	9736                	add	a4,a4,a3
 b90:	fae60de3          	beq	a2,a4,b4a <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 b94:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 b98:	4790                	lw	a2,8(a5)
 b9a:	02061593          	slli	a1,a2,0x20
 b9e:	01c5d713          	srli	a4,a1,0x1c
 ba2:	973e                	add	a4,a4,a5
 ba4:	fae68ae3          	beq	a3,a4,b58 <free+0x22>
    p->s.ptr = bp->s.ptr;
 ba8:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 baa:	00000717          	auipc	a4,0x0
 bae:	44f73b23          	sd	a5,1110(a4) # 1000 <freep>
}
 bb2:	6422                	ld	s0,8(sp)
 bb4:	0141                	addi	sp,sp,16
 bb6:	8082                	ret

0000000000000bb8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 bb8:	7139                	addi	sp,sp,-64
 bba:	fc06                	sd	ra,56(sp)
 bbc:	f822                	sd	s0,48(sp)
 bbe:	f426                	sd	s1,40(sp)
 bc0:	f04a                	sd	s2,32(sp)
 bc2:	ec4e                	sd	s3,24(sp)
 bc4:	e852                	sd	s4,16(sp)
 bc6:	e456                	sd	s5,8(sp)
 bc8:	e05a                	sd	s6,0(sp)
 bca:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bcc:	02051493          	slli	s1,a0,0x20
 bd0:	9081                	srli	s1,s1,0x20
 bd2:	04bd                	addi	s1,s1,15
 bd4:	8091                	srli	s1,s1,0x4
 bd6:	0014899b          	addiw	s3,s1,1
 bda:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 bdc:	00000517          	auipc	a0,0x0
 be0:	42453503          	ld	a0,1060(a0) # 1000 <freep>
 be4:	c515                	beqz	a0,c10 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 be6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 be8:	4798                	lw	a4,8(a5)
 bea:	02977f63          	bgeu	a4,s1,c28 <malloc+0x70>
 bee:	8a4e                	mv	s4,s3
 bf0:	0009871b          	sext.w	a4,s3
 bf4:	6685                	lui	a3,0x1
 bf6:	00d77363          	bgeu	a4,a3,bfc <malloc+0x44>
 bfa:	6a05                	lui	s4,0x1
 bfc:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 c00:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c04:	00000917          	auipc	s2,0x0
 c08:	3fc90913          	addi	s2,s2,1020 # 1000 <freep>
  if(p == (char*)-1)
 c0c:	5afd                	li	s5,-1
 c0e:	a895                	j	c82 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 c10:	00000797          	auipc	a5,0x0
 c14:	40078793          	addi	a5,a5,1024 # 1010 <base>
 c18:	00000717          	auipc	a4,0x0
 c1c:	3ef73423          	sd	a5,1000(a4) # 1000 <freep>
 c20:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 c22:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 c26:	b7e1                	j	bee <malloc+0x36>
      if(p->s.size == nunits)
 c28:	02e48c63          	beq	s1,a4,c60 <malloc+0xa8>
        p->s.size -= nunits;
 c2c:	4137073b          	subw	a4,a4,s3
 c30:	c798                	sw	a4,8(a5)
        p += p->s.size;
 c32:	02071693          	slli	a3,a4,0x20
 c36:	01c6d713          	srli	a4,a3,0x1c
 c3a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c3c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 c40:	00000717          	auipc	a4,0x0
 c44:	3ca73023          	sd	a0,960(a4) # 1000 <freep>
      return (void*)(p + 1);
 c48:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 c4c:	70e2                	ld	ra,56(sp)
 c4e:	7442                	ld	s0,48(sp)
 c50:	74a2                	ld	s1,40(sp)
 c52:	7902                	ld	s2,32(sp)
 c54:	69e2                	ld	s3,24(sp)
 c56:	6a42                	ld	s4,16(sp)
 c58:	6aa2                	ld	s5,8(sp)
 c5a:	6b02                	ld	s6,0(sp)
 c5c:	6121                	addi	sp,sp,64
 c5e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 c60:	6398                	ld	a4,0(a5)
 c62:	e118                	sd	a4,0(a0)
 c64:	bff1                	j	c40 <malloc+0x88>
  hp->s.size = nu;
 c66:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 c6a:	0541                	addi	a0,a0,16
 c6c:	00000097          	auipc	ra,0x0
 c70:	eca080e7          	jalr	-310(ra) # b36 <free>
  return freep;
 c74:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 c78:	d971                	beqz	a0,c4c <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c7a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c7c:	4798                	lw	a4,8(a5)
 c7e:	fa9775e3          	bgeu	a4,s1,c28 <malloc+0x70>
    if(p == freep)
 c82:	00093703          	ld	a4,0(s2)
 c86:	853e                	mv	a0,a5
 c88:	fef719e3          	bne	a4,a5,c7a <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 c8c:	8552                	mv	a0,s4
 c8e:	00000097          	auipc	ra,0x0
 c92:	b78080e7          	jalr	-1160(ra) # 806 <sbrk>
  if(p == (char*)-1)
 c96:	fd5518e3          	bne	a0,s5,c66 <malloc+0xae>
        return 0;
 c9a:	4501                	li	a0,0
 c9c:	bf45                	j	c4c <malloc+0x94>
