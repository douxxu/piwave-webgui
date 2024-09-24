# 🌐 PiWave WebGUI

<div align=center>

![PiWave WebGUI image](https://piwave.hs.vc/static/img/logo.png)

</div>

**PiWave WebGUI** is a web-based interface designed to manage and control your PiWave directly from your browser. It allows you to upload audio files, play, stop them, and view the current PiWave configuration through an easy-to-use interface.

## Features

- **Intuitive Web Interface**: Control your PiWave from a browser with an easy-to-use interface.
- **File Management**: Upload, play, and stop MP3 audio files.
- **Configuration Display**: View the current PiWave settings directly from the interface.
- **Notifications**: Receive real-time notifications for actions like file uploads and audio playback.

## Installation

### Method 1: Full Install (with PiWave included)

For a complete installation of PiWave WebGUI with PiWave included, use the auto-install script:

```bash
sudo sh <(curl -sL https://piwave.hs.vc/setup/gui/full)
```

This script will install both PiWave WebGUI and PiWave, setting up the necessary dependencies and preparing your environment for immediate use.

### Method 2: WebGUI Install (PiWave must already be installed)

If you already have PiWave installed and configured, you can install only PiWave WebGUI using the dedicated installation script:

```bash
sudo sh <(curl -sL https://piwave.hs.vc/setup/gui/)
```

This script will install PiWave WebGUI and the required dependencies to work with your existing PiWave setup.

## Usage

1. **Start the Flask Server**: Run the Flask server to start the web interface.
   
   ```bash
   sudo python3 $HOME/piwave-webgui/server.py
   ```
   or
   ```bash
   pw-webgui
   ```

> [!NOTE]
> You can edit the configuration file `piwave.conf` to edit the piwave instance  
> Use `pw-webgui-config` to open the file

2. **Access the WebGUI**: Open your browser and navigate to `http://<your-raspberry-pi-ip>` to access the PiWave WebGUI.

3. **Upload and Manage Files**: Use the interface to upload MP3 files, play them, and stop playback.

4. **View Configuration**: Check the current PiWave configuration directly from the web interface.

## Requirements

- **PiWave**: Ensure PiWave is installed and configured if you are using the WebGUI installation method.
- **Flask**: Python web framework for the web interface.
- **ffmpeg**: Required for audio file processing.

## Error Handling

- **Configuration Errors**: Ensure `piwave.conf` exists and is correctly formatted.
- **Playback Issues**: Verify that your PiWave hardware is properly set up and connected.

## License

PiWave WebGUI is licensed under the GNU General Public License (GPL) v3.0. See the [LICENSE](LICENSE) file for more details.

## Contributing

Contributions are welcome! Please submit a pull request or open an issue on [GitHub](https://github.com/douxxu/piwave-webgui/issues) for any bugs or feature requests.

---

Thank you for using PiWave WebGUI!
