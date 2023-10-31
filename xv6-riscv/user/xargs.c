#include "kernel/types.h"
#include "kernel/param.h"
#include "user/user.h"


/*
This function is responsible for executing a command with arguments. 
Parameters:
line = a string containing the current line of input
args = an array of strings to store command and arguments
c_count = the count of existing arguments
*/

void execute_line(char* line, char *args[], int c_count) {

  // Create a child process that will execute the command
  // specified in xargs, with the given line of standard input.
  int f = fork();
  if (f < 0) {
    fprintf(2, "xargs: fork failed\n");
    exit(1);
  } else if (f == 0) {
    // Mark start of a word.
    int ws = 1;
    // Various pointers needed to traverse the arguments.
    // a = pointer to argument array
    // l = pointer to input line 
    
    char **a, *l;

    // Point a to the pointer to the argument after the last argument
    // in args.
    a = &args[c_count];
    l = line;

    // Loop through a line of input character by character until we
    // meet '\0' which marks the end of the line ('\n' was replaced
    // by '\0' earlier). Every space we meet is replaced by '\0' to
    // terminate separate words in the line.
    while (*l != '\0') {
      if (*l != ' ') {
        // New word has started. Save the pointer to it to args.
        if (ws) {

          //assigns the address 'l' to the pointer '*a'
          //this effectively stores the starting address of the new word in the 'args' array.
          //it also sets ws to 0 to indicate that a word has begun  
          *a = l;
          ws = 0;
        }
      } else {
        // A word in the line has ended since we met a space.
        if (!ws) {

          // replaces the space character with a null-terminating character \0.
          // this marks the end of the current word  
          *l = '\0';

          // the pointer a is then incremented to point ot the next element in the args array,
          // preparing it to store the address of the next word. 
          a++;

          //ws is set to 1 indicating the whitespace has started, as we're in the space between words.
          ws = 1;
        }
      }

      // pointer l is moved to the next character in the line, and the process continues for the next character
      l++;
    }
    // At this point args stores pointers to the original
    // command passed to xargs plus pointers to any inputs from
    // the standard input. Execute the command.
    exec(args[0], args);
  } else // parent
    wait(0);
}


int main(int argc, char *argv[]) {

  // Declare internal variables.
  char* args[MAXARG] = { 0 };
  // Storage for each line of standard input.
  char buf[512], *b;
  // Point b to the first character in the line.
  b = buf;

  // Read in the pointers to the arguments passed into the
  // xargs. Do not include the first argument which is 'xargs'.
  for (int i = 1; i < argc; i++)
    args[i - 1] = argv[i];

  // Read characters from the standard input. When we find '\n' that
  // means one line has terminated - execute the command specified
  // to args with inputs from the line of standard input.
  while (read(0, b, 1) > 0) {
    if (*b == '\n') {
      // Replace the end of line character by the string terminating
      // character.
      *b = '\0';
      execute_line(buf, args, argc - 1);
      // When a line has been executed, point b to the start of the
      // buf where a new line will be stored.
      b = buf;
    } else
      b++;
  }
  exit(0);  
}

