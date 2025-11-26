import os
import subprocess


class Sweeper:
    '''
    Sweeper object identifies contents of a given directory,
    creates directories for file extensions that don't yet exist,
    and organizes files into their respective directories.
    '''
    def __init__(self, filepath: str):
        self.filepath = filepath
        self.directories = set()
        self.extensions = set()
        self.missing_dirs = set()
        self.files = dict()

    def catalog_directory(self):
        '''Walk directory and catalog current files and subdirectories.'''
        for root, dirs, files in os.walk(self.filepath):
            # Ignore . files as they have no extension
            files[:] = [f for f in files if not f.startswith('.')]
            for file in files:
                _, ext = os.path.splitext(file)
                if ext:
                    ext = ext[1:]
                    self.extensions.add(ext)
                    self.files[file] = ext
            for dir in dirs:
                self.directories.add(dir)
            # Clear list of dirs to prevent catalogging subdirectories
            dirs[:] = []

    def create_missing_dirs(self):
        '''Create new directories for file types that don't have one already.'''
        # Create a copy of the current file extensions in the directory
        self.missing_dirs = self.extensions.copy()
        # Remove all elements from the set that already have a directory
        self.missing_dirs-=self.directories
        # Create missing directories
        for dir in self.missing_dirs:
            if dir != None:
                result = subprocess.run(['mkdir', f'{self.filepath}/{dir}'], capture_output=True)
                if result.returncode != 0:
                    print(f'>>> Failed to create directory: {self.filepath}/{dir}')
                else:
                    self.directories.add(dir)
        self.missing_dirs.clear()


    def organize_files(self):
        '''Move files into their respective directories.'''
        for file in self.files.keys():
            directory = self.files.get(file)
            result = subprocess.run(['mv', f'{self.filepath}/{file}', f'{self.filepath}/{directory}/'], capture_output=True)
            if result.returncode != 0:
                print(f'>>> Failed to move file {self.filepath}/{file} to directory {self.filepath}/{directory}')
        self.files.clear()
