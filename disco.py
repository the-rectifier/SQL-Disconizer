#!/usr/bin/python
# Author: Stavrou Odysseas - canopus
# Descr: Takes your SQL code for a discodance
# Run: python ./disco.py [SQL file to disconize]

import sys
import random


BYPASS = set(list('( ).*0123456789:='))


def get_rand():
    return bool(random.getrandbits(1))


def flip(ch:str):
    if ch.isupper():
        return ch.lower() if get_rand() else ch
    else:
        return ch.upper() if get_rand() else ch


def flush(out, data, i, stop_ch):
    out += data[i]
    i += 1
    while data[i] != stop_ch:
        out += data[i]
        i += 1
    out += data[i]

    return out,i


def disconize(data):
    out = ""
    i = 0
    while(i < len(data)):
        if(data[i:i+9] == "'plpgsql'"):
            out += data[i:i+9]
            i += 9
        if data[i] in BYPASS:
            out += data[i]
        elif data[i:i+2] == '--':
            while data[i] != '\n':
                i += 1
        elif data[i] == '"':
            out, i = flush(out, data, i, '"')
        elif data[i] == '$':
            out, i = flush(out, data, i, '$')
        elif data[i] == '\n' or data[i] == '\t':
            out += ' ' if get_rand() else data[i]
        else:
            out += flip(data[i])
        i += 1
    return out
            


if __name__ == "__main__":
    if len(sys.argv) != 2 :
        print("Please supply .sql file to disconize!")
        sys.exit(-1)

    filename = sys.argv[1]

    with open(filename, 'r') as f:
        file_data = f.read()

    # file_data = 'SELECT * as "Id1" FROM (SELECT * FROM "trinkiTRINKI")'
    with open(filename + '.disconized', 'w') as f:
        f.write(disconize(file_data))
    
    
