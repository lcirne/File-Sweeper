# File-Sweeper
Automates organization of downloaded files into subdirectories within the Downloads folder using python3 and the watchdog module. Available for *macOS* and *Linux*.

## About
File-Sweeper is a lightweight utility for cleaning up your downloads directory without needing to manually move things around. It works by performing an intial scan of your downloads directory after installation and catalogging each unique `.extension`. It then creates a subdirectory for each extension type within your downloads and organizes files accordingly. Once this initial cleaning is complete, File-Sweeper creates an Observer using the watchdog library to monitor when a new file enters your downloads folder and it automatically categorizes that new download by extension and organizes it just as it did initially. 

## Installation
Note: if on macOS ensure python is enabled to run in the background in settings.
```bash
cd ~/.config
git clone https://github.com/yourname/file-sweeper.git
cd file-sweeper
sh install.sh
```
If experiencing permission issues, run `chmod +x *.sh`.
