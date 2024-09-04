# piwave.hs.vs

from flask import Flask, render_template, request, jsonify, send_from_directory
import os
import json
from piwave import PiWave

app = Flask(__name__)

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
MUSIC_DIR = os.path.join(SCRIPT_DIR, 'music')
CONFIG_FILE = os.path.join(SCRIPT_DIR, 'piwave.conf') # goofy ahh caps lock vars

piwave = None

def initialize_piwave():
    global piwave
    config = load_config()
    piwave = PiWave(
        frequency=config.get('frequency', 90.0),
        ps=config.get('ps', 'PiWave'),
        rt=config.get('rt', 'Playing great music'),
        pi=config.get('pi', 'ABCD'),
        loop=config.get('loop', False),
        debug=config.get('debug', False)
    )

def load_config():
    if os.path.exists(CONFIG_FILE):
        with open(CONFIG_FILE, 'r') as f:
            return json.load(f)
    return {}

@app.route('/')
def index():
    files = [f for f in os.listdir(MUSIC_DIR) if f.endswith('.mp3') and not f.endswith('_converted.mp3')]
    return render_template('index.html', files=files)

@app.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return jsonify({'status': 'error', 'message': 'No file part'}), 400

    file = request.files['file']
    if file.filename == '':
        return jsonify({'status': 'error', 'message': 'No selected file'}), 400

    if file and file.filename.endswith('.mp3'):
        filename = file.filename.replace(' ', '_')
        file_path = os.path.join(MUSIC_DIR, filename)
        file.save(file_path)
        return jsonify({'status': 'success', 'message': 'File uploaded successfully'}), 200

    return jsonify({'status': 'error', 'message': 'Invalid file type'}), 400

@app.route('/play/<filename>', methods=['GET'])
def play_file(filename):
    global piwave
    try:
        if piwave is None:
            initialize_piwave()
        file_path = os.path.join(MUSIC_DIR, filename)
        if os.path.exists(file_path):
            piwave.send([file_path])
            return jsonify({'status': 'success', 'message': f'Playing {filename}'}), 200
        else:
            return jsonify({'status': 'error', 'message': 'File not found'}), 404
    except Exception as e:
        print(e)
        return jsonify({'status': 'error', 'message': 'Failed to play the file'}), 500

@app.route('/stop', methods=['GET'])
def stop_playback():
    global piwave
    try:
        if piwave:
            piwave.stop()
        return jsonify({'status': 'success', 'message': 'Playback stopped'}), 200
    except Exception as e:
        print(e)
        return jsonify({'status': 'error', 'message': 'Failed to stop playback'}), 500

@app.route('/config', methods=['GET'])
def get_config():
    if os.path.exists(CONFIG_FILE):
        with open(CONFIG_FILE, 'r') as f:
            config = json.load(f)
        return jsonify(config), 200
    else:
        return jsonify({'status': 'error', 'message': 'Configuration file not found'}), 404

@app.route('/files', methods=['GET'])
def list_files():
    try:
        files = [f for f in os.listdir(MUSIC_DIR) if f.endswith('.mp3') and not f.endswith('_converted.mp3')]
        return jsonify({'files': files}), 200
    except Exception as e:
        print(e)
        return jsonify({'status': 'error', 'message': 'Failed to list files'}), 500

@app.route('/static/<path:filename>')
def serve_static(filename):
    return send_from_directory('static', filename)

if __name__ == '__main__':
    initialize_piwave()
    app.run(host='0.0.0.0', port=80)
