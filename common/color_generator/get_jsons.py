from pathlib import Path
from dataclasses import asdict
import json

from models import ErgoColorScheme, StatementEnv, ProofEnv, EnvOpts, RawOpts, Base16ColorScheme, Color


COLORSCHEME_DIR = Path("../src/color")
DARKEN_PCT = 0.7


def create_ergo_scheme(color_scheme: Base16ColorScheme) -> ErgoColorScheme:
    def base_statement_env(base_color: Color):
        return StatementEnv(
            bgcolor=color_scheme.PRIMARY2,
            strokecolor=base_color.darken(DARKEN_PCT),
        )

    def base_proof_env(base_color: Color):
        return ProofEnv(
            bgcolor1=color_scheme.PRIMARY2,
            bgcolor2=color_scheme.PRIMARY3,
            strokecolor1=base_color.darken(DARKEN_PCT),
            strokecolor2=base_color,
        )

    statement_env_groups: dict[tuple[str, ...], Color] = {
        ("note", "remark", "notation", "runtime"):          color_scheme.BLUE2,
        ("definition", "concept", "computational_problem"): color_scheme.BLUE1,
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

    return ErgoColorScheme(
        opts=EnvOpts(
            fill=color_scheme.PRIMARY1,
            text1=color_scheme.SECONDARY2,
            text2=color_scheme.SECONDARY3,
            h1=color_scheme.SECONDARY3,
            h2=color_scheme.SECONDARY1,
            strong=color_scheme.HIGHLIGHT
        ),
        bookmark=StatementEnv(
            bgcolor=color_scheme.PRIMARY1,
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
