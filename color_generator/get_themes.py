import os
import requests

FILES = [
    'eighties.yaml',
    'dracula.yaml',
    'solarized-dark.yaml'
]

BASE_URL = 'https://raw.githubusercontent.com/tinted-theming/schemes/spec-0.11/base16/'
OUTPUT_DIR = 'base16_schemes'

os.makedirs(OUTPUT_DIR, exist_ok=True)

for filename in FILES:
    url = BASE_URL + filename
    dest = os.path.join(OUTPUT_DIR, filename)
    print(f'Downloading {filename}')
    resp = requests.get(url)
    if resp.ok:
        with open(dest, 'wb') as f:
            f.write(resp.content)
    else:
        print(f'Failed to download {filename} - Status code: {resp.status_code}')
