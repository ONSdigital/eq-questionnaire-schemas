#!/usr/bin/env python3

import json
import os
from jsonpath_rw import parse
from jsonpointer import set_pointer

UNFORMATTED_SUGGESTIONS_URL_ROOT = (
    "https://cdn.eq.census-gcp.onsdigital.uk/data/{version}/{region}/{language}"
)
VERSION = "v4.0.0"


def json_path_to_json_pointer(json_path):
    """
    Convert a json path string into a json pointer string.
    :param json_path: the input data to search
    :return: json pointer equivalent to the json path
    """
    json_pointer = json_path.replace("[", "").replace("]", "").replace(".", "/")
    return f"/{json_pointer}"


def resolve_schema(schema_filepath, suggestions_url_root=None):
    with open(schema_filepath, "r+") as schema_file:
        schema_json = json.load(schema_file)
        json_path = parse("$..suggestions_url")
        for match in json_path.find(schema_json):
            json_pointer = json_path_to_json_pointer(str(match.full_path))
            suggestions_url = match.value
            if suggestions_url_root:
                set_pointer(
                    schema_json,
                    json_pointer,
                    suggestions_url.format(suggestions_url_root=suggestions_url_root),
                )
            else:
                set_pointer(schema_json, json_pointer, "")
        schema_file.seek(0)
        json.dump(schema_json, schema_file, indent=4)


gb_en = [
    "census_household_gb_eng.json",
    "census_individual_gb_eng.json",
    "census_household_gb_wls.json",
    "census_individual_gb_wls.json",
]
gb_cy = ["census_household_gb_wls.json", "census_individual_gb_wls.json"]
ni = ["census_household_gb_nir.json", "census_individual_gb_nir.json"]

if __name__ == "__main__":

    for schema in gb_en:
        resolve_schema(
            os.getcwd() + f"/schemas/en/{schema}",
            UNFORMATTED_SUGGESTIONS_URL_ROOT.format(version=VERSION, region="gb", language="en"),
        )

    for schema in gb_cy:
        resolve_schema(
            os.getcwd() + f"/schemas/cy/{schema}",
            UNFORMATTED_SUGGESTIONS_URL_ROOT.format(version=VERSION, region="gb", language="cy"),
        )

    for schema in ni:
        resolve_schema(
            os.getcwd() + f"/schemas/en/{schema}",
            UNFORMATTED_SUGGESTIONS_URL_ROOT.format(version=VERSION, region="ni", language="en"),
        )
        resolve_schema(f"{os.getcwd()}/schemas/eo/{schema}")
        resolve_schema(f"{os.getcwd()}/schemas/ga/{schema}")
