#!/usr/bin/env python


#4 = mapped TRUE 
#256 = secondary alignment if true we dont want it

#if mapped and primary count
#if unmapped and primary count 

import argparse

def get_args():
    parser = argparse.ArgumentParser(description="create tsv file of RBH")
    parser.add_argument("-f", help="input aligned sam file", type = str) #type: str
    # parser.add_argument("-o", help="output file name") #type: str
    return parser.parse_args()

args = get_args()

file = args.f

mapped_counter = 0
unmapped_counter = 0 

with open(file) as fh1:
    for line in fh1: 
        if line[0] != "@": 
            alignment = line.split('\t')
            # print(alignment)
            flag = int(alignment[1]) #sets the bitwise flag equal to flag
            #set the bools
            mapped:bool = False
            primary:bool = False
            #if the unmapped flag is false mapped is true
            if((flag & 4) != 4):
                mapped = True
            #if secondary read is false, primary is true 
            if((flag & 256) != 256):
                primary = True

            if mapped == True and primary == True:
                mapped_counter += 1
            
            if mapped == False and primary == True:
                unmapped_counter +=1

print("Mapped Reads:", mapped_counter)
print("Unmapped Reads:", unmapped_counter)