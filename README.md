# eq-questionnaire-schemas

A registry for questionnaire schemas for eq-questionnaire-runner.


## Setup

### Pre-Requisites

The following must be installed and working before you start:
- Miniconda: Python and system package management (install from Self Service)

Verify each is available:

```shell
conda --version
```

If `conda` reports `command not found` after installing from Self Service, the installer did not
write the conda block into `~/.zshrc`. Confirm the install is present and wire it in:

```shell
ls -d /opt/miniconda3
/opt/miniconda3/bin/conda init zsh
```

Open a new terminal tab and re-check `conda --version`.

### Conda environment

Python version is pinned in the committed `environment.yml`, matching
`.python-version` as closely as conda-forge availability allows:

If `.python-version` change, update `environment.yml` to match.

Create and activate the environment:

```shell
conda env create -f environment.yml
conda activate eq-schemas
```

Version can be changed by editing `environment.yml` and running:

```shell
conda env update -f environment.yml --prune
```

### Authenticate

Authenticate to make sure Docker can pull from GAR
```shell
gcloud auth login
```

### Install Poetry

With the conda environment active, install the Python dependencies. Add the option `--without dev` to ignore dev dependencies. 

```shell
poetry install
```

## Validating Schemas

A make target exists (`validate-schemas`) in order to validate schemas locally using eq-questionnaire-validator docker image.

To do this run `make run-validator` to run the validator and then run `make validate-schemas` to validate the schemas.

### Validating a single schema

To validate a single schema, run the following command:

```bash
./scripts/validate_schemas.sh <path-to-schema-json>

# For Example
./scripts/validate_schemas.sh schemas/health/en/health_demo.json  
````

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

The `.po` file needs to be named in the following format: `{SCHEMA_NAME}.po`

Once this in place, the following command can be run in order to generate a translated
schema:
```
make translate-schemas
```
The translated schema will be added to the `/schemas/{SURVEY_TYPE}/{LANGUAGE_CODE}/` directory. For example, `schemas/health/cy/`

### Testing Translation Templates

To check that translations are up to date use the following command (This check will run automatically when a pull request is raised):
```bash
make test-translation-templates
```

## Testing built schemas with eq-questionnaire-runner

In order to test the schemas in this repo you will need to create symbolic links between the `/schemas` directory in runner and the folders in the schemas directory here. 

For example in your local eq-questionnaire-runner repository, running the following command will create a symbolic link between the business folder here and the schemas directory in runner.
```bash
ln -s <PATH_TO_REPO>/eq-questionnaire-schemas/schemas/business <PATH_TO_REPO>/eq-questionnaire-runner/schemas
```
You should now be able to launch a questionnaire using one of the schemas.

**CAVEAT - while `raw.githubusercontent.com` can be used for development and sandbox integrations, it is NOT a formally hosted survey questionnaire registry**
