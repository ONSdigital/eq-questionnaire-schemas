#!/usr/bin/env bash

set -e

mkdir -p schemas/en

# Build Census schema for each region
for region_code in GB-WLS GB-ENG GB-NIR; do
    # Lowercase the region code and replace '-' with '_'
    FORMATTED_REGION_CODE=$(echo "${region_code}" | tr '[:upper:]' '[:lower:]' | tr - _)

    CENSUS_DATE="2021-03-21"
    CENSUS_MONTH_YEAR_DATE="2021-03"

    for census_type in "individual" "household" "communal_establishment"; do

        DESTINATION_FILE="schemas/en/census_${census_type}_${FORMATTED_REGION_CODE}.json"

        if [[ "$region_code" = "GB-NIR" ]]; then
            if [[ "$census_type" != "communal_establishment"  ]]; then
                SOURCE_FILE="source/jsonnet/northern-ireland/census_${census_type}.jsonnet"
                ADDITIONAL_LIBRARY_PATH="source/jsonnet/northern-ireland/${census_type}/lib/"

                jsonnet --tla-str region_code="${region_code}" --ext-str census_date="${CENSUS_DATE}" --jpath "${ADDITIONAL_LIBRARY_PATH}" "${SOURCE_FILE}" > "${DESTINATION_FILE}"
                echo "Built ${DESTINATION_FILE}"
            fi
        else
            SOURCE_FILE="source/jsonnet/england-wales/census_${census_type}.jsonnet"
            ADDITIONAL_LIBRARY_PATH="source/jsonnet/england-wales/${census_type}/lib/"

            jsonnet --tla-str region_code="${region_code}"  --ext-str census_date="${CENSUS_DATE}" --tla-str census_month_year_date="${CENSUS_MONTH_YEAR_DATE}" --jpath "${ADDITIONAL_LIBRARY_PATH}" "${SOURCE_FILE}" > "${DESTINATION_FILE}"
            echo "Built ${DESTINATION_FILE}"
        fi

    done
done

# Build CCS schema for England and Wales
for region_code in GB-WLS GB-ENG; do
  FORMATTED_REGION_CODE=$(echo "${region_code}" | tr '[:upper:]' '[:lower:]' | tr - _)

  DESTINATION_FILE="schemas/en/ccs_household_${FORMATTED_REGION_CODE}.json"

  SOURCE_FILE="source/jsonnet/england-wales/ccs_household.jsonnet"
  ADDITIONAL_LIBRARY_PATH="source/jsonnet/england-wales/ccs/lib/"

  jsonnet --tla-str region_code=${region_code} --ext-str census_date="${CENSUS_DATE}" --tla-str census_month_year_date="${CENSUS_MONTH_YEAR_DATE}" --jpath "${ADDITIONAL_LIBRARY_PATH}" "${SOURCE_FILE}" > "${DESTINATION_FILE}"
  echo "Built ${DESTINATION_FILE}"
done