from flask import Flask, request

app = Flask(__name__)

def get_public_ip():
    if 'X-Forwarded-For' in request.headers:
        return request.headers['X-Forwarded-For'].split(',')[0]
    return request.remote_addr

@app.route('/')
def get_reversed_public_ip():
    public_ip = get_public_ip()
    if public_ip:
        octets = public_ip.split('.')
        reversed_octets = octets[::-1]
        reversed_ip = '.'.join(reversed_octets)
        return f"Reversed Public IP: {reversed_ip}"
    else:
        return "Failed to retrieve Public IP"

if __name__ == '__main__':
    app.run(host='0.0.0.0')
