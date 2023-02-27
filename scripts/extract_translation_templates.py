#!/usr/bin/env python3
import argparse
import difflib
import logging
import os
import pathlib
import sys
import tempfile
from glob import glob

import coloredlogs
from eq_translations.entrypoints import handle_extract_template

logger = logging.getLogger(__name__)

coloredlogs.install(level="DEBUG", logger=logger, fmt="%(message)s")

SCHEMAS_TO_EXTRACT = ["schemas/health/en/phm*.json", "schemas/health/en/cris*.json", ]


def get_template_content(filename, ignore_context=False):
    line_beginnings_to_ignore = ['"POT-Creation-Date']

    if ignore_context:
        line_beginnings_to_ignore += ["#:"]

    with open(filename, encoding="utf-8") as file:
        return list(
            filter(
                lambda l: all(
                    not l.startswith(param) for param in line_beginnings_to_ignore
                ),
                file.readlines(),
            )
        )


def print_filename_results(filename, is_successful=True):
    if is_successful:
        logger.debug(f"{filename} - NO CHANGES")
    else:
        logger.error(f"{filename} - CHANGES FOUND")


def compare_files(source_dir, target_dir, filename):
    source_file = f"{source_dir}/{filename}"
    target_file = f"{target_dir}/{filename}"

    source_contents = get_template_content(source_file, ignore_context=True)
    target_contents = get_template_content(target_file, ignore_context=True)

    contents_match = source_contents == target_contents

    if not contents_match:
        diff_results = difflib.unified_diff(
            source_contents,
            target_contents,
            fromfile=source_file,
            tofile=target_file,
        )
        logger.info("".join(list(diff_results)))

    print_filename_results(f"{source_file}", contents_match)

    return contents_match


def build_schema_templates(output_dir):
    filenames = []

    for pattern in SCHEMAS_TO_EXTRACT:
        filenames = glob(pattern)

    for file in filenames:
        template_file = os.path.basename(file).replace(".json", ".pot")

        logger.info(f"Building {output_dir}/{template_file}")

        handle_extract_template(file, output_dir)

        logger.info(f"Built {output_dir}/{template_file}")


def check_schema_templates(source_dir, target_dir):
    schemas = []
    filenames = []

    for pattern in SCHEMAS_TO_EXTRACT:
        filenames.extend(glob(pattern))

    for schema in filenames:
        schema_name = os.path.basename(schema)
        schemas.append(schema_name.replace(".json", ""))

    return all(
        compare_files(source_dir, target_dir, f"{schema_name}.pot")
        for schema_name in schemas
    )


if __name__ == "__main__":

    parser = argparse.ArgumentParser(
        description="Extract translation templates from runner"
    )
    parser.add_argument(
        "--test",
        help="Test the templates without making changes",
        action="store_true",
    )

    args = parser.parse_args()

    if args.test:
        with tempfile.TemporaryDirectory(dir="/tmp") as temp_dir:
            build_schema_templates(temp_dir)

            success = check_schema_templates("translations", temp_dir)

            if not success:
                logger.error(
                    "Translation templates are not up to date. Run make translation-templates to fix this"
                )
                sys.exit(1)

            logger.debug("Translation templates are up to date.")
        sys.exit(0)

    translations_dir = f"{os.getcwd()}/translations"
    pathlib.Path(translations_dir).mkdir(parents=True, exist_ok=True)
    build_schema_templates(translations_dir)
