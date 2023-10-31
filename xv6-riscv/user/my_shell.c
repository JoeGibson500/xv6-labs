#include "kernel/types.h"
#include "user/user.h"
#include "kernel/fcntl.h"
#include "kernel/param.h"


/*
the function readLine will :
    - print the command prompt
    - read in user input 
    - return 1 when 
*/
int
readLine(char buffer[], const int bufferSize)
{
    //constantly display command prompt
    write(2, ">>> ", 4);

    //read input from user
    gets(buffer, bufferSize);


    //if the user just presses enter, exit function (this is so it is called again in the while loop so that the command prompt will be printed agaim)
    if (strlen(buffer) == 1)
    {
        write(2, "\n", 2);
        return 0;
    }

    for (int i=0; i<bufferSize; i++)
    {
        if (buffer[i] == '\n')
        {
            //replace with null-terminating char, to indicate end of command/argument
            buffer[i] = '\0';
            return 1;

        }
    }
    return 0;
}

void
formatLine(char *buffer, char *args[])
{

    int pid = fork();
    if (pid < 0)
    {
        printf("Fork failed");
        exit(1);
    } else if(pid == 0)
    {
        int wordstart = 1;
        char **argumentPointer, *bufferPointer;

        argumentPointer = &args[0];

        //set buffer pointer to start of buffer
        bufferPointer = buffer;
        while (*bufferPointer != '\0') {
            if (*bufferPointer != ' ') 
            {
                if (wordstart)
                {
                    // New word has started. Save the pointer to it to args.
                

                    //assigns the address 'bufferPointer' to the pointer '*argumentPointer'
                    //this effectively stores the starting address of the new word in the 'args' array.
                    //it also sets wordstart to 0 to indicate that a word has begun  
                    *argumentPointer = bufferPointer;
                    wordstart = 0;
                }
            }   else 
            {
                // A word in the line has ended since we met a space.
                if (!wordstart) 
                {

                // replaces the space character with a null-terminating character \0.
                // this marks the end of the current word  
                *bufferPointer = '\0';

                // the pointer a is then incremented to point ot the next element in the args array,
                // preparing it to store the address of the next word. 
                argumentPointer++;

                //ws is set to 1 indicating the whitespace has started, as we're in the space between words.
                wordstart = 1;
                }
            }

        // pointer b is moved to the next character in the line, and the process continues for the next character
        bufferPointer++;
        }
        // At this point args stores pointers to the original
        // command passed to xargs plus pointers to any inputs from
        // the standard input. Execute the command.
        exec(args[0], args);
        
    } else // parent
        wait(0);
}

//function to change directory
void
cd(char *path)
{
    if(chdir(path) < 0)
    {
        printf("cd: Error. Cannot cd to %s\n", path);
    }

}

int 
main(int argc, char *argv[]) 
{

    //create a buffer that we will read into and declare a constant size
    const int BUFSIZE = 512;
    char buffer[BUFSIZE];    

    //initialize argument array that will store arguments after tokenized
    //set all elements to null
    char* args[MAXARG] = { 0 };

    //display command prompt indefinitely 
    while (1)
    {
        //readLine will return 1 when it replaces the newline character with a null terminating character
        if (readLine(buffer, BUFSIZE) == 1)
        {

            formatLine(buffer, args);
        }

    }

    if(buffer[0] == 'c' && buffer[1] == 'd' && buffer[2] == ' ')
    {
        char *path = buffer + 3; // skip cd and get the directory path
        cd(path);
 
    }

    return 0;
}