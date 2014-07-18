import os
from flask import Flask, request
from jinja2 import Environment, FileSystemLoader

template_dir = os.path.join(os.path.dirname(__file__),"templates")

app = Flask(__name__, static_folder="media", static_url_path='/media', )

@app.route('/login')
def hello_world():
    print request.headers
    # return 'Hello headers! \n %s' % request.headers

    # put nginx.conf template into remote nginx folder
    jinja_env = Environment(loader=FileSystemLoader(template_dir))

    h_temp = jinja_env.get_template('headers.html')
    return h_temp.render(headers=request.headers)

if __name__ == '__main__':
    app.debug = True
    app.run()




