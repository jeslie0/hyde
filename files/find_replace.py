#!/usr/bin/env python3
import sys

#read input file
fin = open(sys.argv[1] , "rt")
#read file contents to string
data = fin.read()
#replace all occurrences of the required string
data = data.replace('2e3440', 'ffffff')
data = data.replace('d8dee9', '2e3440')
#close the input file
fin.close()
#open the input file in write mode
fin = open(sys.argv[1], "wt")
#overrite the input file with the resulting data
fin.write(data)
#close the file
fin.close()

