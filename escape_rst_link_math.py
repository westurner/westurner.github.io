#!/usr/bin/env python3
"""Escape TeX backslashes in inline reStructuredText external-link labels."""

import argparse
import re
from pathlib import Path


EXTERNAL_LINK_RE = re.compile(
    r"(?P<start>`)(?P<label>[^`\r\n]*?)"
    r"(?P<target>\s+<https?://[^>\r\n]+>`_?)"
)


def escape_math_backslashes(label):
    """Make TeX backslash runs even inside unescaped dollar delimiters."""
    result = []
    in_math = False
    index = 0

    while index < len(label):
        character = label[index]
        if character == "\\":
            end = index
            while end < len(label) and label[end] == "\\":
                end += 1

            slash_count = end - index
            has_dollar = end < len(label) and label[end] == "$"
            escaped_dollar = has_dollar and slash_count % 2 == 1
            if in_math and slash_count % 2:
                slash_count += 1

            result.append("\\" * slash_count)
            if has_dollar:
                result.append("$")
                if not escaped_dollar:
                    in_math = not in_math
                index = end + 1
            else:
                index = end
        else:
            result.append(character)
            if character == "$":
                in_math = not in_math
            index += 1

    return "".join(result)


def transform_rst(source):
    """Return transformed RST and the number of link labels changed."""
    changed_links = 0

    def replace_link(match):
        nonlocal changed_links
        label = match.group("label")
        escaped_label = escape_math_backslashes(label)
        if escaped_label != label:
            changed_links += 1
        return match.group("start") + escaped_label + match.group("target")

    return EXTERNAL_LINK_RE.sub(replace_link, source), changed_links


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "files", nargs="+", type=Path, help="RST files to scan"
    )
    parser.add_argument(
        "--write",
        action="store_true",
        help="write changes in place (default: report only)",
    )
    args = parser.parse_args()

    total_changed = 0
    for path in args.files:
        if not path.is_file():
            parser.error(f"not a file: {path}")

        original = path.read_text(encoding="utf-8")
        transformed, changed_links = transform_rst(original)
        if not changed_links:
            continue

        total_changed += changed_links
        if args.write:
            path.write_text(transformed, encoding="utf-8")
            print(f"updated {path}: {changed_links} link(s)")
        else:
            print(f"{path}: {changed_links} link(s) need escaping; rerun with --write")

    if not total_changed:
        print("No changes needed.")


if __name__ == "__main__":
    main()