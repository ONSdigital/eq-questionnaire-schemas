#!/usr/bin/env python3

import logging
import os
import sys

from eq_translations.entrypoints import handle_translate_schema

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)
logger.addHandler(logging.StreamHandler(sys.stdout))

TRANSLATION_MAP = {
    "cy": [
        "ccs_household_gb_wls",
        "census_individual_gb_wls",
        "census_household_gb_wls",
        "census_communal_establishment_gb_wls",
    ],
    "eo": ["census_individual_gb_nir", "census_household_gb_nir"],
    "ga": ["census_individual_gb_nir", "census_household_gb_nir"],
}


def translate_schemas(runner_directory):
    logger.info("Using runner directory: %s", runner_directory)

    for language, schemas in TRANSLATION_MAP.items():
        for schema_name in schemas:
            translation_file = f"{schema_name}_{language}.po"
            schema_file = f"{schema_name}.json"
            relative_dir = f"schemas/{language}"
            output_dir = f"{runner_directory}/schemas/{language}"
            language_dir = f"{runner_directory}/translations/{language}"

            logger.info("\n-------\n" "Building %s/%s", relative_dir, schema_file)

            os.makedirs(relative_dir, exist_ok=True)

            schema_path = f"{runner_directory}/schemas/en/{schema_file}"

            handle_translate_schema(
                schema_path, f"{language_dir}/{translation_file}", output_dir
            )


if __name__ == "__main__":
    translate_schemas(".")
