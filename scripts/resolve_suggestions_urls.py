#!/usr/bin/env python3

import json
import logging
import os

import coloredlogs
from jsonpath_rw import parse
from jsonpointer import set_pointer

SUGGESTIONS_URL_BASE = "https://cdn.eq.census-gcp.onsdigital.uk/eq-lookup-suggestions-data/v5.3.0"

logger = logging.getLogger(__name__)

coloredlogs.install(level="DEBUG", logger=logger, fmt="%(message)s")


def json_path_to_pointer(json_path):
    """
    Convert a json path string into a json pointer string.
    :param json_path: the input data to search
    :return: json pointer equivalent to the json path
    """
    json_pointer = json_path.replace("[", "").replace("]", "").replace(".", "/")
    return f"/{json_pointer}"


def find_suggestion_urls(data):
    json_path = parse("$..suggestions")
    for match in json_path.find(data):
        suggestions_url = match.value["url"]
        if "suggestions_url_root" in suggestions_url:
            yield match


def replace_suggestions_urls(data, replacement_url_root) -> int:
    replaced_pointer_count = 0
    for match in find_suggestion_urls(data):
        pointer = json_path_to_pointer(f"{str(match.full_path)}.url")
        replacement_url = match.value['url'].format(suggestions_url_root=replacement_url_root)
        set_pointer(data, pointer, replacement_url)
        replaced_pointer_count += 1
    return replaced_pointer_count


def remove_suggestions_urls(data) -> int:
    removed_pointer_count = 0
    for match in find_suggestion_urls(data):
        parent_pointer = json_path_to_pointer(str(match.context.full_path))
        parent_object = match.context.value
        del parent_object["suggestions"]
        set_pointer(data, parent_pointer, parent_object)

        removed_pointer_count += 1
    return removed_pointer_count


def update_schemas(schemas_dir):
    language_dirs = filter(
        lambda d: os.path.isdir(f"{schema_directory}/{d}"), os.listdir(schemas_dir)
    )

    for language_code in language_dirs:
        language_dir = f"{schema_directory}/{language_code}"
        for schema_name in os.listdir(language_dir):
            region = "ni" if schema_name.endswith("nir.json") else "gb"
            schema_filepath = f"{language_dir}/{schema_name}"

            replaced = 0
            removed = 0

            with open(schema_filepath, "r+") as schema_file:
                schema_data = json.load(schema_file)

                if language_code in ["eo", "ga"]:
                    removed = remove_suggestions_urls(schema_data)
                else:
                    replaced = replace_suggestions_urls(
                        schema_data,
                        f"{SUGGESTIONS_URL_BASE}/{region}/{language_code}",
                    )

            if replaced or removed:
                with open(schema_filepath, "w") as schema_file:
                    json.dump(schema_data, schema_file, indent=4)
            else:
                logger.info(
                    f"{language_code}/{schema_name}: No suggestions urls to resolve"
                )

            if replaced:
                logger.debug(
                    f"{language_code}/{schema_name}: Replaced {replaced} suggestions urls"
                )
            if removed:
                logger.debug(
                    f"{language_code}/{schema_name}: Removed {removed} suggestions urls"
                )


if __name__ == "__main__":
    working_directory = os.getcwd()
    schema_directory = f"{working_directory}/schemas"

    update_schemas(schema_directory)
