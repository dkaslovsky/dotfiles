import argparse
import json
import os
from datetime import datetime

import requests


API = 'https://api.trello.com/1/'

FILTERS = ['open', 'all']
FILTER_IDX = 1


def parse_args():
    parser = argparse.ArgumentParser()

    parser.add_argument(
        '-k', '--key',
        type=str,
        required=True,
    )
    parser.add_argument(
        '-t', '--token',
        type=str,
        required=True,
    )
    parser.add_argument(
        '-o', '--outdir',
        type=str,
        required=True,
    )
    parser.add_argument(
        '-v', '--verbose',
        action='store_true',
        default=False,
        required=False,
    )
    parser.add_argument(
        'ids',
        nargs='+',
        type=str,
    )

    args = parser.parse_args()
    return args


def get_board_url(key, token, board_id):
    auth = f'key={key}&token={token}'
    return ''.join((
        f'{API}boards/{board_id}?{auth}&',
        'actions=all&',
        'actions_limit=1000&',
        f'cards={FILTERS[FILTER_IDX]}&',
        'card_attachments=true&',
        'labels=all&',
        f'lists={FILTERS[FILTER_IDX]}&',
        'members=all&',
        'member_fields=all&',
        'checklists=all&',
        'fields=all'
    ))


def get_file_name(board_name, board_id):
    time_format = '%Y-%m-%dT%H_%M_%S'
    now = datetime.now().strftime(time_format)
    return f'trello_board={board_name}_id={board_id}_time={now}.json'


if __name__ == '__main__':

    args = parse_args()

    # create outdir if it doesn't exist
    os.makedirs(args.outdir, exist_ok=True)

    for board_id in args.ids:
        
        if args.verbose:
            print(f'Backing up board id {board_id}...')
        
        board_url = get_board_url(args.key, args.token, board_id)
        board = requests.get(board_url).json()
        
        outfile = get_file_name(board['name'], board_id)
        outpath = os.path.join(args.outdir, outfile)
        
        with open(outpath, 'w+') as fh:
            json.dump(board, fh)
        
        if args.verbose:
            print(f' ...wrote {outfile} to {args.outdir}')
