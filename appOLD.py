from flask import Flask, jsonify
import os

app = Flask(__name__)

@app.route('/')
def hello():
    name = os.environ.get('NAME', 'world')
    return jsonify({'message': f'Hello {name}!'})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
