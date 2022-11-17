# eq-questionnaire-schemas

A registry for questionnaire schemas for eq-questionnaire-runner.


## Setup

It is recommended that you use [Pyenv](https://github.com/pyenv/pyenv) to manage your Python installations.

### Install Poetry

We use poetry to manage the dependencies in this repository, to install poetry use:

```
curl -sSL https://install.python-poetry.org | python3 -
```

Install the dependencies for this project using
```
poetry install
```

## Validating Schemas

A make target exists (`validate-schemas`) in order to validate schemas locally using eq-questionnaire-validator docker image.

To do this run `make run-validator` to run the validator and then run `make validate-schemas` to validate the schemas.

**Schema file names must use snake case to be compatible with runner**

## Translations

** N.B. Currently only supporting translations for Health themed surveys (PHM).

The latest release of the eq-translations package is required to successfully run the translation scripts. The release version is checked automatically when running translations commands and the scripts will error if the release version does not match the installed version.

### Generating Translation Templates

To generate a translation template `.pot` file in order to translate a schema, use the following command. It will generate a template file containing all the strings to be translated:
```
make translation-templates
```

### Generating Translated Schemas

To translate a schema, a `.po` file for the schema will need to be added to the `translations/{SURVEY_TYPE}/{LANGUAGE_CODE}/` directory containing strings from the schema. For example, `translations/health/cy/`
and the matching translations. 

The `.po` file needs to be named in the following format: `{SCHEMA_NAME}_{LANGUAGE_CODE}.po`

Once this in place, the following command can be run in order to generate a translated
schema:
```
make translate-schemas
```
The translated schema will be added to the `/schemas/{SURVEY_TYPE}/{LANGUAGE_CODE}/` directory. For example, `schemas/health/cy/`

### Testing Translation Templates

To check that translations are up to date use the following command (This check will run automatically when a pull request is raised):
```
make test-translate-templates
```

## Testing built schemas with eq-questionnaire-runner

In order to test the schemas in this repo you will need to create symbolic links between the `/schemas` directory in runner and the folders in the schemas directory here. 

For example in your local eq-questionnaire-runner repository, running the following command will create a symbolic link between the business folder here and the schemas directory in runner.
```
ln -s <PATH_TO_REPO>/eq-questionnaire-schemas/schemas/business <PATH_TO_REPO>/eq-questionnaire-runner/schemas
```
You should now be able to launch a questionnaire using one of the schemas.

**CAVEAT - while `raw.githubusercontent.com` can be used for development and sandbox integrations, it is NOT a formally hosted survey questionnaire registry**
