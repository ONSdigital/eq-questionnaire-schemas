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
    "cy": ["schemas/health/en/phm*"],
}


def translate_schemas(runner_directory):
    logger.info("Using runner directory: %s", runner_directory)

    for language, schemas in TRANSLATION_MAP.items():

        filenames = []
        for pattern in schemas:
            filenames.extend(glob(pattern))

        for schema in filenames:
            schema_name = os.path.basename(schema).replace(".json", "")
            theme_path = os.path.dirname(schema)

            translation_file = f"{schema_name}_{language}.po"
            relative_dir = theme_path.replace("en", language)
            output_dir = f"{runner_directory}/{relative_dir}"
            language_dir = f"{runner_directory}/{relative_dir}".replace(
                "schemas", "translations"
            )

            logger.info(
                "\n-------\n" "Building %s/%s", relative_dir, f"{schema_name}.json"
            )

            os.makedirs(relative_dir, exist_ok=True)

            handle_translate_schema(
                schema, f"{language_dir}/{translation_file}", output_dir
            )


if __name__ == "__main__":
    translate_schemas(".")
