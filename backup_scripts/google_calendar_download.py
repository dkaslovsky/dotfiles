import argparse
import os
from datetime import datetime
from urllib.request import urlopen


def parse_args():
    parser = argparse.ArgumentParser()

    parser.add_argument(
        '-u', '--user',
        type=str,
        required=True,
    )
    parser.add_argument(
        '-k', '--key',
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

    args = parser.parse_args()
    return args


def get_url(args):
    return f'https://www.google.com/calendar/ical/{args.user}/private-{args.key}/basic.ics'


def get_file_name(args):
    time_format = '%Y-%m-%dT%H_%M_%S'
    now = datetime.now().strftime(time_format)
    return f'google_calendar_{args.user}_time={now}.ics'


if __name__ == '__main__':

    args = parse_args()

    if args.verbose:
        print(f'Backing up calendar for {args.user}...')

    # create outdir if it doesn't exist
    os.makedirs(args.outdir, exist_ok=True)

    url = get_url(args)
    with urlopen(url) as response:
        data = response.read()

    outfile = get_file_name(args)
    outpath = os.path.join(args.outdir, outfile)
    with open(outpath, 'wb') as fh:
        fh.write(data)

    if args.verbose:
        print(f' ...wrote {outfile} to {args.outdir}')
