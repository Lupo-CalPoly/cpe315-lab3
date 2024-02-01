#include <stdio.h>

int main(int argc, char* argv[])
{
  int a, b, result;
  char c;

  printf("Enter Number 1: ");
  scanf("%d", &a);
  printf("Enter Number 2: ");
  scanf("%d", &b);
  printf("Enter Operation: ");
  scanf(" %c", &c);

  printf("The numbers were %d %d %c\n", a, b, c);


  printf("Again? ");
  scanf(" %c", &c);

  printf("Make a decision based on '%c'\n", c);


  return 0;
}
