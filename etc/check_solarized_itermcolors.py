#!/usr/bin/env python3
"""
Parse Solarized.itermcolors file using Python's built-in xml library
to extract sRGB values for each ANSI color.
"""

import xml.etree.ElementTree as ET
import sys
import re

from dataclasses import dataclass
from typing import Iterator, NamedTuple

RE_ANSI_COLOR_KEY = re.compile(r"^Ansi (\d+) Color(?: \((.*)\))?$")


class SRGBColor(NamedTuple):
    red: int
    green: int
    blue: int

    def as_floats(self) -> tuple[float, float, float]:
        return self.red / 255, self.green / 255, self.blue / 255


@dataclass
class AnsiColorSet:
    colours: dict[int, SRGBColor]


EXPECTED_DARK = AnsiColorSet(
    colours={
        0: SRGBColor(red=7, green=54, blue=66),
        1: SRGBColor(red=220, green=50, blue=47),
        2: SRGBColor(red=133, green=153, blue=0),
        3: SRGBColor(red=181, green=137, blue=0),
        4: SRGBColor(red=38, green=139, blue=210),
        5: SRGBColor(red=211, green=54, blue=130),
        6: SRGBColor(red=42, green=161, blue=152),
        7: SRGBColor(red=238, green=232, blue=213),
        8: SRGBColor(red=0, green=43, blue=54),
        9: SRGBColor(red=203, green=75, blue=22),
        10: SRGBColor(red=88, green=110, blue=117),
        11: SRGBColor(red=101, green=123, blue=131),
        12: SRGBColor(red=131, green=148, blue=150),
        13: SRGBColor(red=108, green=113, blue=196),
        14: SRGBColor(red=147, green=161, blue=161),
        15: SRGBColor(red=253, green=246, blue=227),
    }
)

EXPECTED_LIGHT = AnsiColorSet(
    colours={
        7: SRGBColor(red=7, green=54, blue=66),
        1: SRGBColor(red=220, green=50, blue=47),
        2: SRGBColor(red=133, green=153, blue=0),
        3: SRGBColor(red=181, green=137, blue=0),
        4: SRGBColor(red=38, green=139, blue=210),
        5: SRGBColor(red=211, green=54, blue=130),
        6: SRGBColor(red=42, green=161, blue=152),
        0: SRGBColor(red=238, green=232, blue=213),
        15: SRGBColor(red=0, green=43, blue=54),
        9: SRGBColor(red=203, green=75, blue=22),
        14: SRGBColor(red=88, green=110, blue=117),
        12: SRGBColor(red=101, green=123, blue=131),
        11: SRGBColor(red=131, green=148, blue=150),
        13: SRGBColor(red=108, green=113, blue=196),
        10: SRGBColor(red=147, green=161, blue=161),
        8: SRGBColor(red=253, green=246, blue=227),
    }
)


def get_key_value_pairs[T](
    dict_elem: ET.Element[str],
) -> Iterator[tuple[str, ET.Element]]:
    children = list(dict_elem)
    for key_element, value_element in zip(children[::2], children[1::2]):
        assert key_element.tag == "key", "Expected key"
        key = key_element.text
        assert key is not None, "Expected key"
        yield key, value_element


def parse_plist_color(dict_elem: ET.Element[str]) -> SRGBColor:
    key_value_pairs = dict(get_key_value_pairs(dict_elem))
    assert key_value_pairs["Color Space"].text == "sRGB", (
        f"Expected sRGB color space but got {key_value_pairs['Color Space']}"
    )
    color_dict = {
        key: int(float(value_element.text) * 255)
        for key, value_element in key_value_pairs.items()
        if value_element.tag == "real" and value_element.text is not None
    }
    return SRGBColor(
        red=color_dict["Red Component"],
        green=color_dict["Green Component"],
        blue=color_dict["Blue Component"],
    )


def extract_ansi_color_sets(
    tree: ET.ElementTree[ET.Element[str]],
) -> dict[str, AnsiColorSet]:
    root = tree.getroot()
    colors: dict[str, AnsiColorSet] = {}

    main_dict = root.find("dict")
    assert main_dict is not None, "No main dict found in the file"

    for key, dict_element in get_key_value_pairs(main_dict):
        if (match := RE_ANSI_COLOR_KEY.match(key)) is not None:
            ansi_code = int(match.group(1))
            variant = match.group(2) or "default"
            rgb = parse_plist_color(dict_element)
            colors.setdefault(variant, AnsiColorSet(colours={})).colours[ansi_code] = (
                rgb
            )

    return colors


def compare_color_sets(actual: AnsiColorSet, expected: AnsiColorSet) -> bool:
    match = True
    for ansi_code in actual.colours.keys() | expected.colours.keys():
        actual_color = actual.colours[ansi_code]
        expected_color = expected.colours[ansi_code]
        if actual_color != expected_color:
            print(
                f"  {ansi_code}: {actual_color.red}, {actual_color.green}, {actual_color.blue} != {expected_color.red}, {expected_color.green}, {expected_color.blue}; should be {expected_color.as_floats()}"
            )
            match = False
    return match


def main(argv: list[str]):
    colors = extract_ansi_color_sets(ET.parse(argv[1]))
    for variant, color_set in colors.items():
        print(f"{variant}:")
        if variant == "Light":
            assert compare_color_sets(color_set, EXPECTED_LIGHT)
        elif variant == "Dark":
            assert compare_color_sets(color_set, EXPECTED_DARK)


if __name__ == "__main__":
    main(sys.argv)
