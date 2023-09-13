import logging
import sys

import eq_translations
import requests
from requests.exceptions import RequestException

logger = logging.getLogger(__name__)

try:
    response = requests.get(
        "https://api.github.com/repos/ONSdigital/eq-translations/releases", timeout=120
    )
    if response.status_code == 200:
        version = f"v{eq_translations.__version__}"
        latest_tag = response.json()[0]["tag_name"]
        if latest_tag != version:
            latest_tag_with_prefix = r"\#" + latest_tag
            logger.error(
                f"eq-translations is out of date. Update using: 'poetry add git+https://github.com/ONSDigital/eq-translations{latest_tag_with_prefix}'"
            )
            sys.exit(1)
    else:
        logger.error("Can't check eq-translations version")
        sys.exit(0)

except RequestException:
    logger.error("Can't check eq-translations version")
    sys.exit(0)
