import logging
import requests
import sys

import eq_translations

from requests.exceptions import ConnectionError

logger = logging.getLogger(__name__)
version = f"v{eq_translations.__version__}"

try:
    response = requests.get(
        "https://api.github.com/repos/ONSdigital/eq-translations/releases"
    )
    if response.status_code == 200:
        latest_tag = response.json()[0]["tag_name"]
        if latest_tag != version:
            logger.error(
                'Newer version of eq-translations available, use "pipenv update"'
            )
            sys.exit(1)
    else:
        logger.error("Can't check eq-translations version")
        sys.exit(1)

except ConnectionError:
    logger.error("Can't check eq-translations version")
    sys.exit(1)
