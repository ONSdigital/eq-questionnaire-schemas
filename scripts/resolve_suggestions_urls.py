import json
from jsonpointer import resolve_pointer, set_pointer


def find_pointers_containing(input_data, search_key, pointer=None):
    if isinstance(input_data, dict):
        if pointer and search_key in input_data:
            yield pointer
        for k, v in input_data.items():
            yield from find_pointers_containing(
                v, search_key, f"{pointer}/{k}" if pointer else f"/{k}"
            )
    elif isinstance(input_data, list):
        for index, item in enumerate(input_data):
            yield from find_pointers_containing(item, search_key, f"{pointer}/{index}")


def resolve_schema(schema_address, language=None):
    with open(schema_address, "r+") as file:
        data = json.load(file)
        pointer_iterator = find_pointers_containing(data, "suggestions_url")
        for pointer in pointer_iterator:
            address = resolve_pointer(data, "{}{}".format(pointer, "/suggestions_url"))
            if language:
                set_pointer(
                    data,
                    "{}{}".format(pointer, "/suggestions_url"),
                    address.replace("{language_code}", language),
                )
            else:
                set_pointer(data, "{}{}".format(pointer, "/suggestions_url"), "")
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

for schema in gb_en:
    resolve_schema(f"schemas/en/{schema}", "en")

for schema in gb_cy:
    resolve_schema(f"schemas/cy/{schema}", "cy")

for schema in ni:
    resolve_schema(f"schemas/en/{schema}", "en")
    resolve_schema(f"schemas/eo/{schema}")
    resolve_schema(f"schemas/ga/{schema}")
