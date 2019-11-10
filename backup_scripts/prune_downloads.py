import argparse
import os
import sys
from datetime import datetime, timedelta


def parse_args():
    parser = argparse.ArgumentParser()

    parser.add_argument(
        '-r', '--rootdir',
        type=str,
        required=True,
    )
    parser.add_argument(
        '-d', '--days',
        type=int,
        required=True,
        help='number of days after which to prune',
    )
    parser.add_argument(
        'dirs',
        nargs='+',
        type=str,
    )

    args = parser.parse_args()
    return args


def should_prune(file_name: str, now: datetime, time_thresh: timedelta) -> bool:
    time_format = '%Y-%m-%dT%H_%M_%S'
    no_ext = os.path.splitext(file_name)[0]  # remove extension
    time_str = no_ext.split('time=')[-1]
    ts = datetime.strptime(time_str, time_format)
    return now - ts > time_thresh


if __name__ == '__main__':

    args = parse_args()
    now = datetime.now()
    time_thresh = timedelta(days=args.days)

    to_prune = []
    for _dir in args.dirs:
        full_path = os.path.join(args.rootdir, _dir)
        for obj in os.listdir(full_path):
            full_obj_path = os.path.join(full_path, obj)
            if os.path.isfile(full_obj_path) and should_prune(obj, now, time_thresh):
                to_prune.append(full_obj_path)
    
    if not to_prune:
        print('No files to prune')
        sys.exit()

    print(f'About to prune {len(to_prune)} files:')
    for f in to_prune:
        print(f)

    ans = None
    while ans not in {'Y', 'n'}:
        ans = input('Confirm delete [Y/n]: ')
    if ans != 'Y':
        print('Aborted')
        sys.exit()
    for f in to_prune:
        os.remove(f)
        print(f'DELETED {f}')
