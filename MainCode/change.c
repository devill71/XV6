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
  if(pid<3){
    printf(2, "You can't change priority of init and shell\n");
    exit();
  }
  if ( priority < 0 || priority > 2 ) {
      printf(2, "Invalid priority (0-2)!\n" );
      exit();
  }
  chpr ( pid, priority );

  exit();
}
