import json
import argparse

INPUT_FILE = 'file.yaml'
OUTPUT_FILE = 'file.json'

def parse_base16_file(path):
    base16_colors = {}
    with open(path, 'r') as f:
        for line in f:
            line = line.strip()
            if line.startswith('base') and ':' in line:
                key, value = line.split(':', 1)
                base16_colors[key.strip()] = value.strip().strip('"')
    return base16_colors

def hex_to_rgb(hex_color):
    return int(hex_color[0:2], 16), int(hex_color[2:4], 16), int(hex_color[4:6], 16)

def rgb_to_hex(rgb_color):
    return f"{rgb_color[0]:02X}{rgb_color[1]:02X}{rgb_color[2]:02X}"

def lighten_color(hex_color, amount):
    r, g, b = tuple(int(c + (255 - c) * amount) for c in hex_to_rgb(hex_color))
    return rgb_to_hex((r, g, b))

def gen_statement_shades(base_color_hex):
    return [base_color_hex, lighten_color(base_color_hex, 0.8)]

def gen_proof_shades(base_color_hex):
    return [
        base_color_hex,
        lighten_color(base_color_hex, 0.2),
        lighten_color(base_color_hex, 0.6),
        lighten_color(base_color_hex, 0.8)
    ]

def create_typst_scheme(base16_colors, dark=False):
    get_color = lambda key: base16_colors.get(key, '000000')

    theorem_shades      = gen_proof_shades(get_color('base07'))
    lemma_shades        = gen_proof_shades(get_color('base08'))
    corollary_shades    = gen_proof_shades(get_color('base09'))
    proposition_shades  = gen_proof_shades(get_color('base0A'))

    definition_shades   = gen_statement_shades(get_color('base0B'))
    remark_shades       = gen_statement_shades(get_color('base0C'))
    notation_shades     = gen_statement_shades(get_color('base0C'))
    example_shades      = gen_statement_shades(get_color('base0D'))
    concept_shades      = gen_statement_shades(get_color('base07'))
    computational_problem_shades = gen_statement_shades(get_color('base08'))
    algorithm_shades    = gen_statement_shades(get_color('base09'))
    runtime_shades      = gen_statement_shades(get_color('base0A'))

    problem_shades      = gen_proof_shades(get_color('base0E'))
    exercise_shades     = gen_proof_shades(get_color('base0F'))

    typst_scheme = {
        "opts": {
            "fill":     f"#{get_color('base00')}",
            "text1":    f"#{get_color('base06')}",
            "text2":    f"#{get_color('base00')}",
            "h1":       f"#{get_color('base06')}",
            "h2":       f"#{get_color('base06')}",
            "strong":   f"#{get_color('base06')}"
        },
        "bookmark": {
            "bgcolor":      f"#{get_color('base00')}",
            "strokecolor":  f"#{get_color('base08')}"
        },
        "theorem": {
            "bgcolor1":     f"#{get_color('base00') if dark else theorem_shades[3]}",
            "bgcolor2":     f"#{get_color('base00') if dark else theorem_shades[2]}",
            "strokecolor1": f"#{theorem_shades[0]}",
            "strokecolor2": f"#{theorem_shades[1]}"
        },
        "lemma": {
            "bgcolor1":     f"#{get_color('base00') if dark else lemma_shades[3]}",
            "bgcolor2":     f"#{get_color('base00') if dark else lemma_shades[2]}",
            "strokecolor1": f"#{lemma_shades[0]}",
            "strokecolor2": f"#{lemma_shades[1]}"
        },
        "corollary": {
            "bgcolor1":     f"#{get_color('base00') if dark else corollary_shades[3]}",
            "bgcolor2":     f"#{get_color('base00') if dark else corollary_shades[2]}",
            "strokecolor1": f"#{corollary_shades[0]}",
            "strokecolor2": f"#{corollary_shades[1]}"
        },
        "proposition": {
            "bgcolor1":     f"#{get_color('base00') if dark else proposition_shades[3]}",
            "bgcolor2":     f"#{get_color('base00') if dark else proposition_shades[2]}",
            "strokecolor1": f"#{proposition_shades[0]}",
            "strokecolor2": f"#{proposition_shades[1]}"
        },
        "note": {
            "bgcolor":      f"#{get_color('base00')}",
            "strokecolor":  f"#{get_color('base06')}"
        },
        "definition": {
            "bgcolor":      f"#{get_color('base00') if dark else definition_shades[1]}",
            "strokecolor":  f"#{definition_shades[0]}"
        },
        "remark": {
            "bgcolor":      f"#{get_color('base00') if dark else remark_shades[1]}",
            "strokecolor":  f"#{remark_shades[0]}"
        },
        "notation": {
            "bgcolor":      f"#{get_color('base00') if dark else notation_shades[1]}",
            "strokecolor":  f"#{notation_shades[0]}"
        },
        "example": {
            "bgcolor":      f"#{get_color('base00') if dark else example_shades[1]}",
            "strokecolor":  f"#{example_shades[0]}"
        },
        "concept": {
            "bgcolor":      f"#{get_color('base00') if dark else concept_shades[1]}",
            "strokecolor":  f"#{concept_shades[0]}"
        },
        "computational-problem": {
            "bgcolor":      f"#{get_color('base00') if dark else computational_problem_shades[1]}",
            "strokecolor":  f"#{computational_problem_shades[0]}"
        },
        "algorithm": {
            "bgcolor":      f"#{get_color('base00') if dark else algorithm_shades[1]}",
            "strokecolor":  f"#{algorithm_shades[0]}"
        },
        "runtime": {
            "bgcolor":      f"#{get_color('base00') if dark else runtime_shades[1]}",
            "strokecolor":  f"#{runtime_shades[0]}"
        },
        "problem": {
            "bgcolor1":     f"#{get_color('base00') if dark else problem_shades[3]}",
            "bgcolor2":     f"#{get_color('base00') if dark else problem_shades[2]}",
            "strokecolor1": f"#{problem_shades[0]}",
            "strokecolor2": f"#{problem_shades[1]}"
        },
        "exercise": {
            "bgcolor1":     f"#{get_color('base00') if dark else exercise_shades[3]}",
            "bgcolor2":     f"#{get_color('base00') if dark else exercise_shades[2]}",
            "strokecolor1": f"#{exercise_shades[0]}",
            "strokecolor2": f"#{exercise_shades[1]}"
        },
        "raw": {
            "saturation": "0.25"
        }
    }
    return typst_scheme



def main():
    parser = argparse.ArgumentParser(description='Generate a Typst scheme from a Base16 YAML.')
    parser.add_argument('-f', '--file', help='Path to input YAML file')
    parser.add_argument('-o', '--output', help='Path to output JSON file')
    parser.add_argument('--dark', action='store_true', help='Theme is dark')

    args = parser.parse_args()
    input_path = args.file
    output_path = args.output or input_path.split('.')[0] + '.json'

    base16_colors = parse_base16_file(input_path)
    typst_scheme = create_typst_scheme(base16_colors, dark=args.dark)

    with open(output_path, 'w') as f:
        json.dump(typst_scheme, f, indent=2)

    print(f"Typst scheme generated and saved to {output_path}")

if __name__ == "__main__":
    main()
