# File-Sweeper
Automates organization of downloaded files into subdirectories within the Downloads folder using python3 and the watchdog module. Available for *macOS* and *Linux*.

<img width="577" height="138" alt="Screenshot 2026-02-02 at 3 08 29 PM" src="https://github.com/user-attachments/assets/ad2a3bb9-02ba-491c-b7b7-cf71b737a486" />

## About
File-Sweeper is a lightweight utility for cleaning up your downloads directory without needing to manually move things around. It works by performing an intial scan of your downloads directory after installation and catalogging each unique `.extension`. It then creates a subdirectory for each extension type within your downloads and organizes files accordingly. Once this initial cleaning is complete, File-Sweeper creates an Observer using the watchdog library to monitor when a new file enters your downloads folder and it automatically categorizes that new download by extension and organizes it just as it did initially. 

## Installation
Note: if on macOS ensure python is enabled to run in the background in settings.
```bash
cd ~/.config
git clone https://github.com/lcirne/file-sweeper.git
cd File-Sweeper/utilities
sh install.sh
```
If experiencing permission issues, run `chmod +x *.sh`.

If you need to pause File-Sweeper you can do so by running:
```bash
sh ~/.config/File-Sweeper/utilities/uninstall.sh
```
