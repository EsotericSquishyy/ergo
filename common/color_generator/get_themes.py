import requests
from pathlib import Path

LIGHT_SCHEMES = [
    'ayu-light',
    'measured-light',
    'selenized-white',
    'terracotta'
]

DARK_SCHEMES = [
    'eighties',
    'dracula',
    'gruvbox-dark-medium',
    'brewer',
    'gotham',
    'lime',
    'woodland'
]

BASE_URL = "https://raw.githubusercontent.com/tinted-theming/schemes/spec-0.11/base16/"
OUTPUT_DIR = Path('./base16_schemes')


if __name__ == "__main__":
    OUTPUT_DIR.mkdir(exist_ok=True)
    (OUTPUT_DIR / "light").mkdir(exist_ok=True)
    (OUTPUT_DIR / "dark").mkdir(exist_ok=True)

    for color_scheme in LIGHT_SCHEMES + DARK_SCHEMES:
        filename = color_scheme + ".yaml"
        url = BASE_URL + filename
        theme_type = "light" if color_scheme in LIGHT_SCHEMES else "dark"
        dest = OUTPUT_DIR / theme_type / filename
        print(f'Downloading {filename}')
        resp = requests.get(url)
        if resp.ok:
            with open(dest, 'wb') as f:
                f.write(resp.content)
        else:
            print(f'Failed to download {filename} - Status code: {resp.status_code}')
