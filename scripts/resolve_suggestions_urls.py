import json
from jsonpointer import set_pointer

ENG_WLS_ADDRESS = "https://cdn.eq.census-gcp.onsdigital.uk/data/v4.0.0/gb/"
NI_ADDRESS = "https://cdn.eq.census-gcp.onsdigital.uk/data/v4.0.0/ni/"


def resolve_question(
    data, block, section_index, group_index, block_index, url_address, language
):
    for answer_index, answer in enumerate(block["question"]["answers"]):
        if "suggestions_url" in answer:
            set_pointer(
                data,
                f"/sections/{section_index}/groups/{group_index}/blocks/{block_index}/question/answers/{answer_index}"
                f"/suggestions_url",
                "{}{}{}".format(url_address, language, answer["suggestions_url"]),
            )


def resolve_question_variants(
    data, block, section_index, group_index, block_index, url_address, language
):
    for variant_index, question_variant in enumerate(block["question_variants"]):
        for answer_index, answer in enumerate(question_variant["question"]["answers"]):
            if "suggestions_url" in answer:
                set_pointer(
                    data,
                    f"/sections/{section_index}/groups/{group_index}/blocks/{block_index}/question_variants/"
                    f"{variant_index}/question/answers/{answer_index}/suggestions_url",
                    "{}{}{}".format(url_address, language, answer["suggestions_url"]),
                )


def resolve_schema(schema_address, url_address, language):
    with open(schema_address, "r+") as file:
        data = json.load(file)
        for section_index, section in enumerate(data["sections"]):
            for group_index, group in enumerate(section["groups"]):
                for block_index, block in enumerate(group["blocks"]):
                    if "question" in block:
                        resolve_question(
                            data,
                            block,
                            section_index,
                            group_index,
                            block_index,
                            url_address,
                            language,
                        )
                    elif "question_variants" in block:
                        resolve_question_variants(
                            data,
                            block,
                            section_index,
                            group_index,
                            block_index,
                            url_address,
                            language,
                        )
        file.seek(0)
        json.dump(data, file, indent=4)


gb_en = [
    "census_household_gb_eng.json",
    "census_individual_gb_eng.json",
    "census_household_gb_wls.json",
    "census_individual_gb_wls.json",
]
gb_cy = ["census_household_gb_wls.json", "census_individual_gb_wls.json"]
ni_en = ["census_household_gb_nir.json", "census_individual_gb_nir.json"]

for schema in gb_en:
    resolve_schema(f"schemas/en/{schema}", ENG_WLS_ADDRESS, "en/")

for schema in gb_cy:
    resolve_schema(f"schemas/cy/{schema}", ENG_WLS_ADDRESS, "cy/")

for schema in ni_en:
    resolve_schema(f"schemas/en/{schema}", NI_ADDRESS, "en/")
