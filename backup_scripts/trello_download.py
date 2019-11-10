import argparse
import json
import os
from datetime import datetime
from typing import Dict
from urllib.request import urlopen


API = 'https://api.trello.com/1/'

FILTERS = ['open', 'all']
FILTER_IDX = 1


def parse_args() -> argparse.Namespace:
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


def get_board_url(key: str, token: str, board_id: str) -> str:
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


def get_board_json(url: str) -> Dict:
    with urlopen(url) as response:
        payload = json.load(response)
    return payload


def get_file_name(board_name: str, board_id: str) -> str:
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
        board = get_board_json(board_url)

        outfile = get_file_name(board['name'], board_id)
        outpath = os.path.join(args.outdir, outfile)

        with open(outpath, 'w+') as fh:
            json.dump(board, fh)

        if args.verbose:
            print(f' ...wrote {outfile} to {args.outdir}')
