
import uuid
import argparse


def get_args():
    parser = argparse.ArgumentParser()
    group = parser.add_mutually_exclusive_group()
    group.add_argument('-d', '--delimiter', metavar='?', dest='d', help='specify delimiter')
    group.add_argument('-p', '--pure', action='store_true', dest='p', help='no delimiter')
    return parser.parse_args()

def create_uuid():
    o_uuid = uuid.uuid4()  # type UUID
    s_uuid = str(o_uuid)  # type str
    return s_uuid

def main():
    args = get_args()
    result = create_uuid()
    if args.d:
        print(result.replace('-', args.d))   # eg d=*, 2e9bcf75*eb64*48b4*872c*ca1a9d73a9c0
    elif args.p:
        print(result.replace('-',''))  # eg: 2e9bcf75-eb64-48b4-872c-ca1a9d73a9c0
    else:
        print(result)  # eg: b92ed4dc2afd440e858e76366486de3a



if __name__ == '__main__':
    main()
