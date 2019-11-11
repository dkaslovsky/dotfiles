import argparse
import os
import sys
from datetime import datetime, timedelta
from typing import Iterator, List

from time_format import TIME_FORMAT


def parse_args() -> argparse.Namespace:
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


def parse_time(file_name: str) -> datetime:
    no_ext = os.path.splitext(file_name)[0]  # remove extension
    time_str = no_ext.split('time=')[-1]
    return datetime.strptime(time_str, TIME_FORMAT)


def get_objs_to_prune(full_path: str, now: datetime, time_thresh: timedelta) -> Iterator[str]:

    def should_prune(file_name: str, now: datetime, time_thresh: timedelta) -> bool:
        ts = parse_time(file_name)
        return now - ts > time_thresh

    for obj in os.listdir(full_path):
        full_obj_path = os.path.join(full_path, obj)
        if os.path.isfile(full_obj_path) and should_prune(obj, now, time_thresh):
            yield full_obj_path


def confirm_delete() -> bool:
    ans = None
    while ans not in {'Y', 'n'}:
        ans = input('Confirm delete [Y/n]: ')
    return ans == 'Y'


def delete_files(file_list: List[str]) -> None:
    for f in file_list:
        os.remove(f)
        print(f'DELETED {f}')


if __name__ == '__main__':

    args = parse_args()
    now = datetime.now()
    time_thresh = timedelta(days=args.days)

    to_prune = []
    for _dir in args.dirs:
        full_path = os.path.join(args.rootdir, _dir)
        to_prune.extend(get_objs_to_prune(full_path, now, time_thresh))

    if not to_prune:
        print('No files to prune')
        sys.exit()

    print(f'About to prune {len(to_prune)} files:')
    print('\n'.join(to_prune))
    if not confirm_delete():
        print('Aborted')
        sys.exit()
    delete_files(to_prune)
