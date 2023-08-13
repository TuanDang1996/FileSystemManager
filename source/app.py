import os
from flask import Flask, render_template, request, send_from_directory
from werkzeug.utils import secure_filename

app = Flask(__name__, template_folder=os.path.abspath('.'))
app.config['UPLOAD_PATH'] = 'uploads'

@app.errorhandler(413)
def too_large(e):
    return "File is too large", 413

@app.route('/')
def index():
    files = os.listdir(app.config['UPLOAD_PATH'])
    return render_template('index.html', files=files)

@app.route('/', methods=['POST'])
def upload_files():
    uploaded_file = request.files['file']
    filename = secure_filename(uploaded_file.filename)
    if filename != '':
        uploaded_file.save(os.path.join(app.config['UPLOAD_PATH'], filename))
    return '', 204

@app.route('/retrieveFile', methods=['GET'])
def upload():
    file_name = request.args['filename']
    return send_from_directory(app.config['UPLOAD_PATH'], file_name)


@app.route('/deleteFile', methods=['GET'])
def deleteFile():
    file_name = request.args['filename']
    os.remove(os.path.join(app.config['UPLOAD_PATH'], file_name))
    return '', 204


if __name__ == '__main__':
    app.run(port=5000)