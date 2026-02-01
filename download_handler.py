import time
import os
from watchdog.events import PatternMatchingEventHandler
from sweeper import Sweeper

class DownloadHandler(PatternMatchingEventHandler):
    patterns = ["*"] # Define file patterns to watch

    def on_created(self, event):
        """Called when a file or directory is created."""
        print(f"New file detected: {event.src_path}")
        downloads_path = os.path.dirname(event.src_path)
        sweeper = Sweeper(downloads_path)
        sweeper.catalog_directory()
        sweeper.create_missing_dirs()
        sweeper.organize_files()
        print('-' * 30)
        print('DIRECTORY SWEEPED')
        print('-' * 30)
        time.sleep(1)
