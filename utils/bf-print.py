#!/usr/bin/env python
from sys import argv

value = 10

for c in argv[1]:
    desired_value = ord(c)
    diff = abs(desired_value - value)
    if desired_value > value:
        increments = '+' * diff
    else:
        increments = '-' * diff

    print(c + ' ' + increments + '.')

    value = desired_value
