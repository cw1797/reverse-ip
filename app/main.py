from flask import Flask
import requests

app = Flask(__name__)

def get_public_ip():
    try:
        response = requests.get('https://ifconfig.me/ip')
        if response.status_code == 200:
            return response.text.strip()
    except Exception as e:
        print("Error fetching Public IP:", e)
    return None

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
