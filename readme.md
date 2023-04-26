# Bluetooth Driver Restart Script

This is a bash script that restarts Bluetooth drivers and services on Ubuntu (20.04) systems. It first checks if the shell is bash and goes to work.

## Usage
1. Clone or download the repository to your local machine.
2. Open a terminal and navigate to the repository directory.
3. Make the script executable with the command `chmod +x btreset.sh`.
4. Run the script with the command `sudo ./btreset.sh`.
  If the script refuses to run, try `sudo bash -x btreset.sh` from withing the directory where the file is stored.

## What it does

The script simply restarts Bluetooth drivers and services. It first checks if the `rfcomm` module is in use, and then proceeds with the following steps:

1. Disables Bluetooth drivers
2. Stops `bluetooth.service`
3. Disables `btusb`, `btrtl`, `btintel`, `rfcomm` (if in use), and `btbcm` modules
4. Disables `bnep` and `bluetooth` modules
5. Enables Bluetooth drivers
6. Enables `btusb`, `bnep`, and `bluetooth` modules
7. Enables `btrtl`, `btintel`, `rfcomm`, and `btbcm` modules
8. Starts `bluetooth.service`

Note: The rfcomm module is mostly unrelated, but to cover all bases i disable it if its found.
      Feel free to customize the script to fit your purpose. 
      
## Compatibility

This script is compatible with Ubuntu 20.04 with PulseAudio enabled.
