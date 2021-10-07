'''
from flask import Flask
app = Flask(__name__)
@app.route('/')
def hello_world():
	return 'Hello World'
'''
from flask import Flask, request
from flask import jsonify
app = Flask(__name__)
@app.route('/')
def myapp():
    message = "To use this app: %s/add?x=value&y=value" % request.base_url
    return message
@app.route('/add')
def add():
    # Checking that both parameters have been supplied
    for param in ['x', 'y']:
        if not param in request.args:
            result = { 
                'type': '%s value is missing' % param, 
                'content': '', 
                'status': 'REQUEST_DENIED'
            }
            return jsonify(result)
    
    # Make sure they are numbers too
    try:
        x = float(request.args['x'])
        y = float(request.args['y'])
    except:
        return "x and y should be numbers"
    
    result = { 
        'type': 'result', 
        'content': x+y, 
        'status': 'REQUEST_OK'
    }   
    return jsonify(result)

if __name__ == '__main__':
	app.run(host="0.0.0.0", debug=True)