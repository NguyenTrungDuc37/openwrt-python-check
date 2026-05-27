#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define LOG_FILE "/tmp/python_ver.log"

int main(void)
{
    FILE *fp;
    FILE *log;
    char buffer[128];

    fp = popen("python3.9 --version 2>&1", "r");

    if (fp == NULL) {
        printf("Error: Python 3.9 not found\n");
        return 1;
    }

    if (fgets(buffer, sizeof(buffer), fp) == NULL) {
        printf("Error: Python 3.9 not found\n");
        pclose(fp);
        return 1;
    }

    int status = pclose(fp);

    if (status != 0 || strstr(buffer, "Python 3.9") == NULL) {
        printf("Error: Python 3.9 not found\n");
        return 1;
    }

    printf("Detected Python Version: %s", buffer + 7);

    log = fopen(LOG_FILE, "w");

    if (log != NULL) {
        fprintf(log, "Detected Python Version: %s", buffer + 7);
        fclose(log);
    }

    return 0;
}
