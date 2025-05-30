import glob
import json
import logging
import os
import re
import subprocess
import sys
import time
from concurrent.futures import ThreadPoolExecutor, as_completed

logging.basicConfig(
    level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s"
)


def check_connection():
    for connection_attempts in range(4, 0, -1):
        response = subprocess.run(
            [
                "curl",
                "-so",
                "/dev/null",
                "-w",
                "%{http_code}",
                "http://localhost:5002/status",
            ],
            capture_output=True,
            text=True,
            check=False,
        ).stdout.strip()

        if response == "200":
            return

        logging.error("\033[31m---Error: Schema Validator Not Reachable---\033[0m")
        logging.error(  # pylint: disable=logging-too-many-args
            "\033[31mHTTP Status: %s\033[0m", response
        )

        if connection_attempts == 1:
            logging.info("Exiting...\n")
            sys.exit(1)

        logging.info("Retrying...\n")
        time.sleep(5)


def get_schemas() -> list[str]:
    # argv[0] is the script name, so len(argv) == 1 means no arguments passed
    file_path = (
        "./schemas" if len(sys.argv) == 1 or sys.argv[1] == "--local" else sys.argv[1]
    )

    schemas = glob.glob(os.path.join(file_path, "**", "*.json"), recursive=True)
    logging.info(f"--- Testing Schemas in {file_path} ---")
    return schemas


def validate_schema(schema_path):
    try:
        result = subprocess.run(
            [
                "curl",
                "-s",
                "-w",
                "HTTPSTATUS:%{http_code}",
                "-X",
                "POST",
                "-H",
                "Content-Type: application/json",
                "-d",
                f"@{schema_path}",
                "http://localhost:5001/validate",
            ],
            capture_output=True,
            text=True,
            check=True,
        )
        return schema_path, result.stdout
    except subprocess.CalledProcessError as e:
        logging.info(f"Error validating schema {schema_path}: {e}")
        return schema_path, None


def main():
    # pylint: disable=broad-exception-caught
    passed = 0
    failed = 0

    check_connection()
    schemas = get_schemas()

    with ThreadPoolExecutor(max_workers=20) as executor:
        future_to_schema = {
            executor.submit(validate_schema, schema): schema for schema in schemas
        }
        for future in as_completed(future_to_schema):
            schema = future_to_schema[future]
            try:
                schema_path, result = future.result()
                # Extract HTTP body
                http_body = re.sub(r"HTTPSTATUS:.*", "", result)

                # Convert HTTP body to JSON
                http_body_json = json.loads(http_body)

                # Format JSON
                formatted_json = json.dumps(http_body_json, indent=4)

                # Extract HTTP status code
                result_response = re.search(r"HTTPSTATUS:(\d+)", result)[1]

                if result_response == "200" and http_body_json == {}:
                    logging.info(f"\033[32m{schema_path}: PASSED\033[0m")
                    passed += 1
                else:
                    logging.error(f"\033[31m{schema_path}: FAILED\033[0m")
                    logging.error(
                        f"\033[31mHTTP Status @ /validate: {result_response}\033[0m"
                    )
                    logging.error(f"\033[31mHTTP Status: {formatted_json}\033[0m")
                    failed += 1
            except Exception as e:
                logging.error(f"\033[31mError processing {schema}: {e}\033[0m")
                failed += 1

    logging.info(f"\033[32m{passed} passed\033[0m - \033[31m{failed} failed\033[0m")
    if passed != len(schemas):
        sys.exit(1)


if __name__ == "__main__":
    main()
