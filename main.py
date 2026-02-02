import sys
import platform
import time
from pathlib import Path
from watchdog.observers import Observer
from download_handler import DownloadHandler
from sweeper import Sweeper

VALID_OS = ['Darwin', 'Linux']

def main():
    # Verify user is on macos or linux
    os_name = platform.system()
    if os_name not in VALID_OS:
        sys.exit('Program not available for your operating system.')
    downloads_path = f'{Path.home()}/Downloads'

    print(r" ______ _ _             _____                                    __    ")
    print(r"|  ____(_) |           / ____|                                   | |   ")
    print(r"| |__   _| | ___ _____| (_____      _____  ___ _ __   ___ _ __   | |   ")
    print(r"|  __| | | |/ _ \______\___ \ \ /\ / / _ \/ _ \ '_ \ / _ \ '__|  | |   ")
    print(r"| |    | | |  __/      ____) \ V  V /  __/  __/ |_) |  __/ |   __| |__ ")
    print(r"|_|    |_|_|\___|     |_____/ \_/\_/ \___|\___| .__/ \___|_|   |/|/|\| ")
    print(r"                                              | |              |/|\|\| ")
    print(r"                                              |_|              |/|\|/| ")

    # Initialize sweeper for preliminary clean
    sweeper = Sweeper(downloads_path)
    sweeper.initial_sweep()

    # Initialize downloads watcher
    observer = Observer()
    handler = DownloadHandler(downloads_path)
    observer.schedule(handler, path=downloads_path, recursive=False)

    print(f"Starting file system monitor on {downloads_path}...")
    observer.start()

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
        print("Monitor stopped.")
    observer.join()


if __name__=='__main__':
    main()
