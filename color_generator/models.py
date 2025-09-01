from __future__ import annotations
from dataclasses import dataclass
import yaml
from typing import Self
import re
from pathlib import Path



class Color(str):
    """See https://en.wikipedia.org/wiki/SRGB#Definition for sRGB manipulations"""

    hex_regex = re.compile(r"^#([0-9A-Fa-f]{6})$")
    gamma = 2.2

    def __new__(cls: type[Self], hex_rep: str) -> Self:
        assert cls.hex_regex.fullmatch(hex_rep), "Must be a valid hex string"
        return str.__new__(cls, hex_rep)

    @staticmethod
    def _clamp_rgb(rgb_value: int) -> int:
        return min(255, max(0, rgb_value))

    @staticmethod
    def _srgb_to_linear(rgb_value: int) -> float:
        return (rgb_value / 255.0) ** Color.gamma

    @staticmethod
    def _linear_to_srgb(linear_value: float) -> int:
        return round(255.0 * (linear_value ** (1.0 / Color.gamma)))

    def _adjust_linear(self, percent: float, *, toward_white: bool) -> Self:
        assert 0.0 <= percent <= 1.0, "Percent must be in [0, 1]"

        r = int(self[1:3], 16)
        g = int(self[3:5], 16)
        b = int(self[5:7], 16)

        def adjust_channel(rgb_value: int) -> int:
            linear_value = self._srgb_to_linear(rgb_value)
            if toward_white:
                linear_value = linear_value + (1.0 - linear_value) * percent
            else:
                linear_value = linear_value * (1.0 - percent)
            return self._clamp_rgb(self._linear_to_srgb(linear_value))

        converted_channels = [adjust_channel(rgb_value) for rgb_value in (r, g, b)]
        return type(self)("#{:02x}{:02x}{:02x}".format(*converted_channels))

    def darken(self, percent: float) -> Self:
        return self._adjust_linear(percent, toward_white=False)

    def lighten(self, percent: float) -> Self:
        return self._adjust_linear(percent, toward_white=True)

@dataclass
class Base16ColorScheme:
    colors:   list[Color]
    is_light: bool

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
    def from_yaml(cls: type[Self], yaml_path: Path) -> Self:
        with open(yaml_path, "r", encoding="utf-8") as f:
            data = yaml.safe_load(f)
        palette = data.get("palette")
        assert palette and isinstance(palette, dict) and palette, "Could not find palette"

        is_light = "light" in yaml_path.parent.name
        return cls(list(map(Color, palette.values())), is_light)


#------Color Scheme Creation------
@dataclass(frozen=True)
class StatementEnv:
    bgcolor:     Color
    strokecolor: Color

@dataclass(frozen=True)
class ProofEnv:
    bgcolor1:     Color
    bgcolor2:     Color
    strokecolor1: Color
    strokecolor2: Color

@dataclass(frozen=True)
class EnvOpts:
    fill:   Color
    text1:  Color
    text2:  Color
    h1:     Color
    h2:     Color
    strong: Color

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
