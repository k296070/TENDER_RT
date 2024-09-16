with open('./modules/utils/data/vpu_1.mem', 'w') as f:
    f.write('1')
    for i in range(0, 65):
        if i !=64:
            f.write(f'{int(i/4):06b}')
            f.write(f'{0:010b}')
        if i ==64:
            k=int(i/64)
            print(k)
            f.write(f'{12:016b}')
            f.write(f'{63:06b}')
            f.write(f'{0:010b}')
            f.write('\n')
    f.write('1')
    for i in range(0, 65):
        if i !=64:
            f.write(f'{i:06b}')
            f.write(f'{0:010b}')
        if i ==64:
            k=int(i/64)
            print(k)
            f.write(f'{k:016b}')
            f.write(f'{63:06b}')
            f.write(f'{0:010b}')
            f.write('\n')
    f.write('0')
    for i in range(1, 129):
        k=0
        f.write(f'{k:016b}')
        if i %64==0:
            f.write(f'{k:016b}')
            f.write(f'{k:016b}')
            f.write('\n')