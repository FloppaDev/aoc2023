
#include <stdio.h>

#include "input.c"

char *spelled_digits[] = {
    "one", 
    "two", 
    "three", 
    "four", 
    "five", 
    "six", 
    "seven", 
    "eight", 
    "nine" 
};

int main() {
    int sum_p1 = 0;
    int sum_p2 = 0;

    char first_p1;
    char start_p1;
    char end_p1;

    char first_p2;
    char start_p2;
    char end_p2;

    char newline = 1;

    for (int i = 0; i < input_txt_len; i++) {
        if (newline) {
            first_p1 = 1;
            start_p1 = 0;
            end_p1 = 0;

            first_p2 = 1;
            start_p2 = 0;
            end_p2 = 0;

            newline = 0;
        }

        char i_ch = input_txt[i];

        if (i_ch == 10) {
            newline = 1;
            sum_p1 += start_p1 * 10 + end_p1;
            sum_p2 += start_p2 * 10 + end_p2;

            continue;
        }

        char is_digit = 0;
        char digit;

        if (i_ch >= 48 && i_ch <= 57) {
            digit = i_ch - 48;
            is_digit = 1;
        }

        else {
            for (int s = 0; s < 9; s++) {
                int s_i = 0;
                char *s_ch = spelled_digits[s] + s_i;

                while (*s_ch != '\0') {
                    int is = i + s_i; 

                    if (is >= input_txt_len) {
                        continue;
                    }

                    i_ch = input_txt[is];

                    if (*s_ch != i_ch) {
                        goto next_spelled_digit;
                    }

                    s_i++;
                    s_ch = spelled_digits[s] + s_i;
                }

                digit = s + 1;
                goto process_digit;

                next_spelled_digit:
            }

            continue;
        }

        process_digit:

        if (is_digit) {
            if (first_p1) {
                start_p1 = digit;
                first_p1 = 0;
            }

            end_p1 = digit;
        }

        if (first_p2) {
            start_p2 = digit;
            first_p2 = 0;
        }

        end_p2 = digit;
    }

    printf("Part 1: %d\n", sum_p1);
    printf("Part 2: %d\n", sum_p2);

    return 0;
}
