import yaml
from pathlib import Path

from models import Color


PREVIEWS_PATH = Path("./scheme_previews")
PREVIEWS_PATH.mkdir(exist_ok=True)

def load_base16_yaml(path: Path) -> list[Color]:
    with open(path, "r", encoding="utf-8") as f:
        data = yaml.safe_load(f)
    palette = data.get("palette")
    assert palette and isinstance(palette, dict) and palette, "Could not find palette"

    return list(map(Color, palette.values()))

def make_stripe_svg(
        colors:    list[Color],
        file_stem: str,
        width:     int = 1200,
        height:    int = 160) -> None:
    color_count = len(colors)
    parts = [
        '<svg xmlns="http://www.w3.org/2000/svg" '
        f'viewBox="0 0 {width} {height}" width="{width}" height="{height}" '
        'shape-rendering="crispEdges">',
        '  <title>Base16 Palette Stripes</title>'
    ]
    for i, color in enumerate(colors):
        x = width * i / color_count
        w = width / color_count
        parts.append(f'  <rect x="{x:.4f}" y="0" width="{w:.4f}" height="{height}" fill="{color.hex_rep}">')
        parts.append('  </rect>')
    parts.append('</svg>')
    svg = "\n".join(parts)
    (PREVIEWS_PATH / (file_stem + ".svg")).write_text(svg, encoding="utf-8")


if __name__ == "__main__":
    for color_scheme_file in Path("base16_schemes").rglob("*.yaml"):
        color_scheme = load_base16_yaml(color_scheme_file)
        make_stripe_svg(color_scheme, color_scheme_file.stem)
