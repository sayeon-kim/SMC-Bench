#include <unistd.h>
int main(){
    char **argv = NULL;
    char **env = NULL;
    char command[] = "/bin/sh";
    execve(command, argv, env);

    return 0;
}