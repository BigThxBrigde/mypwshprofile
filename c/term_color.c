#include <stdbool.h>
#include <stdio.h>

// https://askubuntu.com/questions/821157/print-a-256-color-test-pattern-in-the-terminal
int main(void)
{
    int i;

    while (i < 256)
    {

        printf("\033[48;5;%dm%3d\033[0m ", i, i);

        bool has_linefeed = i == 15
                || (i > 15 && i <= 231 && ((i - 15) % 18 == 0))
                || (i > 231 && ((i - 231) % 12 == 0));

        bool has_gap = i > 15 && i <= 231 && ((i - 15) % 18 == 0);

        bool has_extra_linefeed = i == 15 || i == 123 || i == 231;

        if (has_linefeed)
        {
            if (has_gap) printf(" ");
            printf("\n");
        }

        if (has_extra_linefeed) printf("\n");

        ++i;
    }

    return 0;
}
