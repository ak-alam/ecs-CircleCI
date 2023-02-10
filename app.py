from cProfile import run
from flask import Flask
app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def welcome():
    return "Health Check."
    
@app.route('/hello', methods=['GET', 'POST'])
def hello_world():
    return "Hello API"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)