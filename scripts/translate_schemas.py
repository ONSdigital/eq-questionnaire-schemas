#!/usr/bin/env python3

import logging
import os
import sys
from glob import glob

from eq_translations.entrypoints import handle_translate_schema

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)
logger.addHandler(logging.StreamHandler(sys.stdout))

TRANSLATION_MAP = {
    "cy": ["schemas/health/en/phm*", "schemas/health/en/cris*"],
}


def translate_schemas(runner_directory):
    logger.info(f"Using runner directory: {runner_directory}")

    for language, schemas in TRANSLATION_MAP.items():

        filenames = []
        for pattern in schemas:
            filenames.extend(glob(pattern))

        for schema in filenames:
            schema_name = os.path.basename(schema).replace(".json", "")
            theme_path = os.path.dirname(schema)

            translation_file = f"{schema_name}.po"
            relative_dir = theme_path.replace("en", language)
            output_dir = f"{runner_directory}/{relative_dir}"
            language_dir = f"{runner_directory}/{relative_dir}".replace(
                "schemas", "translations"
            )

            logger_file_path = f"{relative_dir}/{schema_name}.json"

            logger.info(f"\n-------\n" f"Building {logger_file_path}")

            os.makedirs(relative_dir, exist_ok=True)

            handle_translate_schema(
                schema, f"{language_dir}/{translation_file}", output_dir
            )


if __name__ == "__main__":
    translate_schemas(".")
