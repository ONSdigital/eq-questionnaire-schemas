import logging
import requests
import sys

import eq_translations

from requests.exceptions import RequestException

logger = logging.getLogger(__name__)

try:
    response = requests.get(
        "https://api.github.com/repos/ONSdigital/eq-translations/releases"
    )
    if response.status_code == 200:
        version = eq_translations.__version__
        latest_tag = response.json()[0]["tag_name"]
        if latest_tag != f"v{version}":
            logger.error(
                f'Latest eq-translations version is {version}, use "pipenv update"'
            )
            sys.exit(1)
    else:
        logger.error("Can't check eq-translations version")
        sys.exit(0)

except RequestException:
    logger.error("Can't check eq-translations version")
    sys.exit(0)
