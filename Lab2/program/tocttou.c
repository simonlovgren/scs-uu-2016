#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

#define INPUT_BUF_SIZ 100

char *readline() {
  // Create buffer space
  char *line = malloc(INPUT_BUF_SIZ);
  char *cursor = line;
  if(line == NULL) // If memory was abailable
    return NULL;
  // variable for slots left in buffer and buffer size
  size_t bufsiz = INPUT_BUF_SIZ;
  size_t len = INPUT_BUF_SIZ;
  // Char to store read char in
  char c;
  // Loop until all chars read
  for(;;) {
    c = fgetc(stdin); // Read line from term
    if(c == EOF) // Check for EOF, if so break
      break;
    // Decrease available length and check if space is available
    if(--len == 0) {
      // reallocate buffer
      len = bufsiz;
      char *line_tmp = realloc(line, bufsiz *= 2);
      if(line_tmp == NULL){
        free(line);
        return NULL;
      }
      // Set cursor to correct location in new memory
      cursor = line_tmp + (cursor - line);
      line = line_tmp;
    }
    // Save char to buffer and check for newline
    if((*cursor++ = c) == '\n')
      break;
  }
  // NULL-terminate string and return line
  *cursor = '\0';
  return line;
}

int main(int argc, char **argv)
{
  if(argc < 2){
    puts("Missing argument: <file>");
    return 1;
  }

  char *file = argv[1];
  
  if(access(file, F_OK) == -1) {
    printf("ERROR: File not found - %s\n", file);
    return 1;
  }

  if(access(file, W_OK) == -1) {
    printf("ERROR: File not writable - %s\n", file);
    return 1;
  }
  // Open file for writing  
  FILE *fp = fopen(file, "w");
  // Read input from user
  char *in = readline();
  // Write to file
  fputs(in,fp);
  // Close file
  fclose(fp);
  // Free read line
  free(in);
  return 0;
}
