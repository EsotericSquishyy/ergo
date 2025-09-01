from pathlib import Path
from dataclasses import asdict
import json

from models import ErgoColorScheme, StatementEnv, ProofEnv, EnvOpts, RawOpts, Base16ColorScheme


COLORSCHEME_DIR = Path("../src/color")

def create_ergo_scheme(color_scheme: Base16ColorScheme) -> ErgoColorScheme:
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
            strokecolor=color_scheme.RED
        ),
        theorem=ProofEnv(
            bgcolor1=color_scheme.PRIMARY2,
            bgcolor2=color_scheme.PRIMARY3,
            strokecolor1=color_scheme.PURPLE,
            strokecolor2=color_scheme.PURPLE
        ),
        lemma=ProofEnv(
            bgcolor1=color_scheme.PRIMARY2,
            bgcolor2=color_scheme.PRIMARY3,
            strokecolor1=color_scheme.YELLOW,
            strokecolor2=color_scheme.YELLOW
        ),
        corollary=ProofEnv(
            bgcolor1=color_scheme.PRIMARY2,
            bgcolor2=color_scheme.PRIMARY3,
            strokecolor1=color_scheme.PURPLE,
            strokecolor2=color_scheme.PURPLE
        ),
        proposition=ProofEnv(
            bgcolor1=color_scheme.PRIMARY2,
            bgcolor2=color_scheme.PRIMARY3,
            strokecolor1=color_scheme.RED,
            strokecolor2=color_scheme.RED
        ),
        note=StatementEnv(
            bgcolor=color_scheme.PRIMARY2,
            strokecolor=color_scheme.BLUE2
        ),
        definition=StatementEnv(
            bgcolor=color_scheme.PRIMARY2,
            strokecolor=color_scheme.BLUE1
        ),
        remark=StatementEnv(
            bgcolor=color_scheme.PRIMARY2,
            strokecolor=color_scheme.BLUE2
        ),
        notation=StatementEnv(
            bgcolor=color_scheme.PRIMARY2,
            strokecolor=color_scheme.BLUE2
        ),
        example=StatementEnv(
            bgcolor=color_scheme.PRIMARY2,
            strokecolor=color_scheme.GREEN
        ),
        concept=StatementEnv(
            bgcolor=color_scheme.PRIMARY2,
            strokecolor=color_scheme.BLUE1
        ),
        computational_problem=StatementEnv(
            bgcolor=color_scheme.PRIMARY2,
            strokecolor=color_scheme.BLUE1
        ),
        algorithm=StatementEnv(
            bgcolor=color_scheme.PRIMARY2,
            strokecolor=color_scheme.RED
        ),
        runtime=StatementEnv(
            bgcolor=color_scheme.PRIMARY2,
            strokecolor=color_scheme.BLUE2
        ),
        problem=ProofEnv(
            bgcolor1=color_scheme.PRIMARY2,
            bgcolor2=color_scheme.PRIMARY3,
            strokecolor1=color_scheme.GREEN,
            strokecolor2=color_scheme.GREEN
        ),
        exercise=ProofEnv(
            bgcolor1=color_scheme.PRIMARY2,
            bgcolor2=color_scheme.PRIMARY3,
            strokecolor1=color_scheme.ORANGE,
            strokecolor2=color_scheme.ORANGE
        ),
        raw=RawOpts(
            saturation="0.25"
        )
    )

def write_scheme_json(ergo_scheme: ErgoColorScheme, scheme_name: str) -> None:
    with open(COLORSCHEME_DIR / f"{scheme_name}.json", "w") as f:
        f.write(json.dumps(asdict(ergo_scheme), indent=2, default=str).replace("_", "-"))

if __name__ == "__main__":
    for color_scheme_file in Path("base16_schemes").rglob("*.yaml"):
        color_scheme = Base16ColorScheme.from_yaml(color_scheme_file)
        ergo_scheme = create_ergo_scheme(color_scheme)
        write_scheme_json(ergo_scheme, color_scheme_file.stem)
