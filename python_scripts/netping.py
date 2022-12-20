import os
import sys
import platform
import threading
import subprocess

PLANT = platform.system()

DEV_NULL = open(os.devnull, 'w')

PING_RESULT = []

match PLANT:
    case 'Windows':
        PING_ARGS = ['ping', '-n', '1', '-w', '1']
    case _:
        PING_ARGS = ['ping', '-c', '1', '-w', '1']


def single_ping(subnet, host):
    ip_addr = f'{subnet}{host}'
    status_code = subprocess.call(
        args=PING_ARGS + [ip_addr],
        stdout=DEV_NULL,
        stderr=DEV_NULL
    )
    if status_code == 0:
        PING_RESULT.append(host)


def group_ping(sub):
    ping_threads = []
    for i in range(1, 255):
        t = threading.Thread(target=single_ping, args=[sub, i])
        t.start()
        ping_threads.append(t)
    for pt in ping_threads:
        pt.join()


def show_result(sub):
    new_result = sorted(PING_RESULT)
    for i in new_result:
        print(f'{sub}{i}')
    print(f'\nPing: {len(new_result)} Pong.')


def main(sub):
    group_ping(sub)
    show_result(sub)
    DEV_NULL.close()


if __name__ == '__main__':
    subnet = sys.argv[1]
    if subnet[-1] == '.':
        main(subnet)
    else:
        main(f'{subnet}.')
