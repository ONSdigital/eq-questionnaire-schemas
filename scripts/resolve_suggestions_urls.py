#!/usr/bin/env python3

import json
import os

from jsonpath_rw import parse
from jsonpointer import resolve_pointer, set_pointer

SUGGESTIONS_URL_BASE = "https://cdn.eq.census-gcp.onsdigital.uk/data/v4.0.0"


def json_path_to_pointer(json_path):
    """
    Convert a json path string into a json pointer string.
    :param json_path: the input data to search
    :return: json pointer equivalent to the json path
    """
    json_pointer = json_path.replace("[", "").replace("]", "").replace(".", "/")
    return f"/{json_pointer}"


def replace_suggestions_urls(schema_filepath, replacement_url_root):
    updated_pointer_count = 0

    try:
        with open(schema_filepath, "r+") as schema_file:
            schema_json = json.load(schema_file)
            json_path = parse("$..suggestions_url")
            for match in json_path.find(schema_json):
                json_pointer = json_path_to_pointer(str(match.full_path))
                suggestions_url = match.value
                if "suggestions_url_root" in suggestions_url:
                    if replacement_url_root:
                        replacement_url = suggestions_url.format(
                            suggestions_url_root=replacement_url_root
                        )
                        set_pointer(schema_json, json_pointer, replacement_url)
                    else:
                        parent_pointer = "/".join(json_pointer.split("/")[0:-1])
                        parent_object = resolve_pointer(schema_json, parent_pointer)
                        del parent_object["suggestions_url"]
                        set_pointer(schema_json, parent_pointer, parent_object)
                    updated_pointer_count += 1
    except FileNotFoundError:
        print(f"{schema_filepath} not found")

    if updated_pointer_count:
        with open(schema_filepath, "w") as schema_file:
            json.dump(schema_json, schema_file, indent=4)

    schema_name = os.path.split(schema_filepath)[-1]
    print(f"{schema_name}: Replaced {updated_pointer_count} suggestions urls")


SUGGESTION_MAP = {
    "en": [
        "census_household_gb_eng",
        "census_individual_gb_eng",
        "census_household_gb_wls",
        "census_individual_gb_wls",
        "census_individual_gb_nir",
        "census_household_gb_nir",
    ],
    "cy": [
        "census_individual_gb_wls",
        "census_household_gb_wls",
    ],
    "eo": ["census_individual_gb_nir", "census_household_gb_nir"],
    "ga": ["census_individual_gb_nir", "census_household_gb_nir"],
}

if __name__ == "__main__":
    working_directory = os.getcwd()
    schema_directory = f"{working_directory}/schemas"

    for language_code, schema_list in SUGGESTION_MAP.items():
        for schema in schema_list:
            region = "ni" if schema.endswith("nir") else "gb"
            replace_suggestions_urls(
                f"{schema_directory}/{language_code}/{schema}.json",
                None
                if language_code in ["eo", "ga"]
                else f"{SUGGESTIONS_URL_BASE}/{region}/{language_code}",
            )
