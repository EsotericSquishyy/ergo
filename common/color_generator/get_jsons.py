from pathlib import Path
from dataclasses import asdict
import json

from models import ErgoColorScheme, StatementEnv, ProofEnv, EnvOpts, RawOpts, Base16ColorScheme, Color


COLORSCHEME_DIR = Path("../../src/color/templates")
DARKEN_PCT = 0.5


def create_ergo_scheme(color_scheme: Base16ColorScheme) -> ErgoColorScheme:
    def base_statement_env(base_color: Color) -> StatementEnv:
        bgcolor = color_scheme.PRIMARY2
        if color_scheme.is_light:
            bgcolor = base_color.lighten(0.5)
            # bgcolor = bgcolor.lighten(0.2)
        # else:
        #   bgcolor = bgcolor.lighten(0.02)

        return StatementEnv(
            bgcolor=bgcolor,
            strokecolor=base_color.darken(DARKEN_PCT),
        )

    def base_proof_env(base_color: Color) -> ProofEnv:
        bgcolor1 = color_scheme.PRIMARY2
        bgcolor2 = color_scheme.PRIMARY3
        if color_scheme.is_light:
            bgcolor1 = base_color.lighten(0.5)
            bgcolor2 = base_color.lighten(0.3)
            # bgcolor1 = bgcolor1.lighten(0.2)
            # bgcolor2 = bgcolor2.lighten(0.2)
        # else:
        #   bgcolor1 = bgcolor1.lighten(0.02)
        #   bgcolor2 = bgcolor2.lighten(0.02)

        return ProofEnv(
            bgcolor1=bgcolor1,
            bgcolor2=bgcolor2,
            strokecolor1=base_color.darken(DARKEN_PCT),
            strokecolor2=base_color,
        )

    statement_env_groups: dict[tuple[str, ...], Color] = {
        ("note", "remark", "notation", "runtime"):          color_scheme.INDIGO,
        ("definition", "concept", "computational_problem"): color_scheme.BLUE,
        ("example",):                                       color_scheme.GREEN,
        ("algorithm",):                                     color_scheme.RED,
    }

    statement_envs = {
        name: base_statement_env(base_color)
        for names, base_color in statement_env_groups.items()
        for name in names
    }

    proof_envs = {
        "theorem":     base_proof_env(color_scheme.PURPLE),
        "lemma":       base_proof_env(color_scheme.YELLOW),
        "corollary":   base_proof_env(color_scheme.PURPLE),
        "proposition": base_proof_env(color_scheme.RED),
        "problem":     base_proof_env(color_scheme.GREEN),
        "exercise":    base_proof_env(color_scheme.ORANGE),
    }

    fill_color = color_scheme.PRIMARY1
    if color_scheme.is_light:
        fill_color = fill_color.lighten(0.15)
    else:
        fill_color = fill_color.darken(0.15)

    strong_color = color_scheme.HIGHLIGHT
    if color_scheme.is_light:
        strong_color = strong_color.darken(0.6)
    else:
        strong_color = strong_color.lighten(0.6)

    return ErgoColorScheme(
        opts=EnvOpts(
            fill=fill_color,
            text1=color_scheme.SECONDARY2,
            text2=color_scheme.SECONDARY3,
            h1=color_scheme.SECONDARY3,
            h2=color_scheme.SECONDARY1,
            strong=strong_color
        ),
        bookmark=StatementEnv(
            bgcolor=fill_color,
            strokecolor=color_scheme.RED.darken(DARKEN_PCT)
        ),
        raw=RawOpts(
            saturation="0.25"
        ),
        **statement_envs,  # type: ignore
        **proof_envs
    )

def write_scheme_json(ergo_scheme: ErgoColorScheme, scheme_name: str) -> None:
    with open(COLORSCHEME_DIR / f"{scheme_name}.json", "w") as f:
        f.write(json.dumps(asdict(ergo_scheme), indent=2, default=str).replace("_", "-"))

if __name__ == "__main__":
    for color_scheme_file in Path("base16_schemes").rglob("**/*.yaml"):
        color_scheme = Base16ColorScheme.from_yaml(color_scheme_file)
        ergo_scheme = create_ergo_scheme(color_scheme)
        write_scheme_json(ergo_scheme, color_scheme_file.stem)
