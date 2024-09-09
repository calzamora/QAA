#!/usr/bin/env python

import matplotlib.pyplot as plt
import argparse
import numpy as np 

def get_args():
    parser = argparse.ArgumentParser(description="test")
    parser.add_argument("-fw", help="specify the foward read filename", type=str) #type: strr
    parser.add_argument("-rv", help="specify the reverse read filename", type=str)
    parser.add_argument("-o", help="output graph name", type=str) #type: str
    return parser.parse_args()

args = get_args()

FowardFile = args.fw
RevFile = args.rv
out= args.o 

#key: length (bp)
#value = frequency
fw_my_dict = {}
rv_my_dict = {}

with open (FowardFile) as fh1:
    for line in fh1: 
        spline = line.split()
        # print(spline)
        frequency = spline[0]
        length = spline[1]
        fw_my_dict[length] = frequency

#turn the dict into a list and then into a numpy array
fw_np_ar_results = np.array(list(fw_my_dict.items())).astype(int)
#sory the array in place using the LENGTHS 
fw_np_ar_results = fw_np_ar_results[np.argsort(fw_np_ar_results[:,0])]

#same as above for reverse file
with open (RevFile) as fh1:
    for line in fh1: 
        spline = line.split()
        # print(spline)
        frequency = spline[0]
        length = spline[1]
        rv_my_dict[length] = frequency

rv_np_ar_results = np.array(list(rv_my_dict.items())).astype(int)
rv_np_ar_results = rv_np_ar_results[np.argsort(rv_np_ar_results[:,0])]


plt.plot(fw_np_ar_results[:,0],fw_np_ar_results[:,1], color = 'm', label = "Foward Paired Read")
plt.plot(rv_np_ar_results[:,0],rv_np_ar_results[:,1], color = 'c', label = "Reverse Paired Read")
plt.yscale('log')
plt.xlabel("Read Length (bp)")
plt.ylabel("Occurrance")
plt.title(f"Distribution of Read Length for {args.o}")
plt.legend()

plt.savefig(f"{args.o}.png")