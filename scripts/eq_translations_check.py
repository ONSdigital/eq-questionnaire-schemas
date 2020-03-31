import logging
import requests
import re
import sys

logger = logging.getLogger(__name__)


response = requests.get("https://api.github.com/repos/ONSdigital/eq-translations/commits/master").json()
commit_sha = response.get('sha')

f = open("Pipfile.lock", "r")
file = f.readlines()
for i, line in enumerate(file):
    if '"eq-translations"' in line:
        ref = re.compile(r"\w{40}")
        mo = ref.search(file[i + 3])
        pipfile_sha = mo.group()
        if pipfile_sha == commit_sha:
            logger.error("eq-translations up to date")

        else:
            logger.error('Newer version of eq-translations available, use "pipenv update"')
            sys.exit(0)
        break
