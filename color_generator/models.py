from dataclasses import dataclass


@dataclass(frozen=True)
class Color:
    hex_rep: str
