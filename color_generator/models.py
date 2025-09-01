from __future__ import annotations
from dataclasses import dataclass
import yaml
from pathlib import Path


@dataclass
class Base16ColorScheme:
    colors: list[str]

    def __post_init__(self):
        assert len(self.colors) == 16, "Base 16 color schemes must have 16 colors"

        (
            self.PRIMARY1,
            self.PRIMARY2,
            self.PRIMARY3,
            _,
            _,
            self.SECONDARY1,
            self.SECONDARY2,
            self.SECONDARY3,
            self.RED,
            self.ORANGE,
            self.YELLOW,
            self.GREEN,
            self.BLUE1,
            self.BLUE2,
            self.PURPLE,
            self.HIGHLIGHT,
        ) = self.colors

    @classmethod
    def from_yaml(cls, yaml_path: Path) -> Base16ColorScheme:
        with open(yaml_path, "r", encoding="utf-8") as f:
            data = yaml.safe_load(f)
        palette = data.get("palette")
        assert palette and isinstance(palette, dict) and palette, "Could not find palette"

        return cls(list(palette.values()))


#------Color Scheme Creation------
@dataclass(frozen=True)
class StatementEnv:
    bgcolor:     str
    strokecolor: str

@dataclass(frozen=True)
class ProofEnv:
    bgcolor1:     str
    bgcolor2:     str
    strokecolor1: str
    strokecolor2: str

@dataclass(frozen=True)
class EnvOpts:
    fill:   str
    text1:  str
    text2:  str
    h1:     str
    h2:     str
    strong: str

@dataclass(frozen=True)
class RawOpts:
    saturation: str

@dataclass(frozen=True)
class ErgoColorScheme:
    opts:                  EnvOpts
    bookmark:              StatementEnv
    theorem:               ProofEnv
    lemma:                 ProofEnv
    corollary:             ProofEnv
    proposition:           ProofEnv
    note:                  StatementEnv
    definition:            StatementEnv
    remark:                StatementEnv
    notation:              StatementEnv
    example:               StatementEnv
    concept:               StatementEnv
    computational_problem: StatementEnv
    algorithm:             StatementEnv
    runtime:               StatementEnv
    problem:               ProofEnv
    exercise:              ProofEnv
    raw:                   RawOpts
