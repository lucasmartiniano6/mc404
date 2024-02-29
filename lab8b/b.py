with open("image.pgm", 'wb') as f:
    f.write(b'P5 10 10 255 ')
    c = 0xff
    for i in range(10):
        # c = 0x00 if (c==0xff) else 0xff
        for j in range(10):
            f.write(c.to_bytes(1, byteorder='big'))
    
