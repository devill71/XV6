#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{
  int priority, pid;

  if(argc < 3 ){
      printf(2, "Usage: change pid priority\n" );
      exit();
  }
  pid = atoi ( argv[1] );
  priority = atoi ( argv[2] );
  if ( priority < 1 || priority > 3 ) {
      printf(2, "Invalid priority (1-3)!\n" );
      exit();
  }
  chpr ( pid, priority );

  exit();
}
