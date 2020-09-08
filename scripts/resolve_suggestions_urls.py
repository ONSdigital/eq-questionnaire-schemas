import json
from jsonpath_rw import parse
from jsonpointer import set_pointer

SUGGESTIONS_API_URL = (
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


def resolve_schema(schema_address, version=None, language=None):
    with open(schema_address, "r+") as file:
        data = json.load(file)
        json_path = parse("$..suggestions_url")
        for match in json_path.find(data):
            json_pointer = json_path_to_json_pointer(str(match.full_path))
            suggestions_url = match.value
            if language:
                set_pointer(
                    data,
                    json_pointer,
                    suggestions_url.format(suggestions_api_url=version),
                )
            else:
                set_pointer(data, json_pointer, "")
        file.seek(0)
        json.dump(data, file, indent=4)


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
            f"schemas/en/{schema}",
            SUGGESTIONS_API_URL.format(version=VERSION, region="gb", language="en"),
            "en",
        )

    for schema in gb_cy:
        resolve_schema(
            f"schemas/cy/{schema}",
            SUGGESTIONS_API_URL.format(version=VERSION, region="gb", language="cy"),
            "cy",
        )

    for schema in ni:
        resolve_schema(
            f"schemas/en/{schema}",
            SUGGESTIONS_API_URL.format(version=VERSION, region="ni", language="en"),
            "en",
        )
        resolve_schema(f"schemas/eo/{schema}")
        resolve_schema(f"schemas/ga/{schema}")
