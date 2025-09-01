from pathlib import Path

from models import Base16ColorScheme


PREVIEWS_PATH = Path("../../gallery/scheme_previews")
PREVIEWS_PATH.mkdir(exist_ok=True)
(PREVIEWS_PATH / "light").mkdir(exist_ok=True)
(PREVIEWS_PATH / "dark").mkdir(exist_ok=True)


def make_stripe_svg(
        color_scheme: Base16ColorScheme,
        file_stem:    str,
        width:        int = 1200,
        height:       int = 160) -> None:
    color_count = len(color_scheme.colors)
    parts = [
        '<svg xmlns="http://www.w3.org/2000/svg" '
        f'viewBox="0 0 {width} {height}" width="{width}" height="{height}" '
        'shape-rendering="crispEdges">',
        '  <title>Base16 Palette Stripes</title>'
    ]
    for i, color in enumerate(color_scheme.colors):
        x = width * i / color_count
        w = width / color_count
        parts.append(f'  <rect x="{x:.4f}" y="0" width="{w:.4f}" height="{height}" fill="{color}">')
        parts.append('  </rect>')
    parts.append('</svg>')
    svg = "\n".join(parts)
    write_path = PREVIEWS_PATH / ("light" if color_scheme.is_light else "dark") / (file_stem + ".svg")
    write_path.write_text(svg, encoding="utf-8")


if __name__ == "__main__":
    for color_scheme_file in Path("base16_schemes").rglob("**/*.yaml"):
        color_scheme = Base16ColorScheme.from_yaml(color_scheme_file)
        make_stripe_svg(color_scheme, color_scheme_file.stem)
