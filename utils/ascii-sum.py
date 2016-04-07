#!/usr/bin/env python
from sys import argv

result = 0
for c in argv[1]:
    result += ord(c)

print(result)
