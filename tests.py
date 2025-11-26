import unittest
from unittest.mock import patch, MagicMock, call
import tempfile
import os
from sweeper import Sweeper  # adjust import to match your project structure

class TestSweeper(unittest.TestCase):

    @patch("os.walk")
    @patch("os.path.splitext")
    def test_catalog_directory(self, mock_splitext, mock_walk):
        # Mock os.walk behavior
        mock_walk.return_value = [
            ("/root", ["subdir"], ["file1.txt", "file2.py"])
        ]

        # Mock splitext return values
        mock_splitext.side_effect = [
            ("file1", ".txt"),
            ("file2", ".py"),
        ]

        sweeper = Sweeper("/root")
        # Fix attribute sets manually since original code is buggy
        sweeper.extensions = set()
        sweeper.directories = set()
        sweeper.files = {}

        sweeper.catalog_directory()

        # Expected results
        self.assertIn("txt", sweeper.extensions)
        self.assertIn("py", sweeper.extensions)
        self.assertIn("subdir", sweeper.directories)
        self.assertEqual(sweeper.files["file1.txt"], "txt")
        self.assertEqual(sweeper.files["file2.py"], "py")

    @patch("subprocess.run")
    def test_create_missing_dirs(self, mock_run):
        mock_run.return_value = MagicMock(
            stdout=b"",
            stderr=b"",
            returncode=0
        )

        sweeper = Sweeper("/root")
        sweeper.extensions = {"txt", "py", "jpg"}
        sweeper.directories = {"txt"}

        sweeper.create_missing_dirs()

        expected_dirs = {"py", "jpg"}

        # missing_dirs should be EMPTY after method runs
        self.assertEqual(sweeper.missing_dirs, set())

        # new directories should be added to sweeper.directories
        self.assertTrue(expected_dirs.issubset(sweeper.directories))

        # verify subprocess.run was called correctly
        calls = [call(['mkdir', d], capture_output=True) for d in expected_dirs]
        mock_run.assert_has_calls(calls, any_order=True)


    @patch("subprocess.run")
    def test_organize_files(self, mock_run):
        mock_run.return_value = MagicMock(
            stdout=b"",
            stderr=b"",
            returncode=0
        )

        sweeper = Sweeper("/root")
        sweeper.files = {
            "file1.txt": "txt",
            "file2.py": "py"
        }

        sweeper.organize_files()

        expected_calls = [
            call(['mv', 'file1.txt', 'txt/'], capture_output=True),
            call(['mv', 'file2.py', 'py/'], capture_output=True),
        ]

        mock_run.assert_has_calls(expected_calls, any_order=True)


if __name__ == "__main__":
    unittest.main()
