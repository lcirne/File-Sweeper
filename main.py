import sys
import platform
import time
from pathlib import Path
from sweeper import Sweeper

VALID_OS = ['Darwin', 'Linux']

def main():
    # Verify user is on macos or linux
    os_name = platform.system()
    if os_name not in VALID_OS:
        sys.exit('Program not available for your operating system.')
    downloads_path = f'{Path.home()}/Downloads'

    # Initialize sweeper
    sweeper = Sweeper(downloads_path)
    while True:
        sweeper.catalog_directory()
        sweeper.create_missing_dirs()
        sweeper.organize_files()
        print('-' * 30)
        print('DIRECTORY SWEEPED')
        print('-' * 30)
        time.sleep(1)


if __name__=='__main__':
    main()
