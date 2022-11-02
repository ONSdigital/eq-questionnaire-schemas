# eq-questionnaire-schemas

A registry for questionnaire schemas for eq-questionnaire-runner.

A make target exists (`validate-schemas`) in order to validate schemas locally using eq-questionnaire-validator docker image.

To do this run `make run-validator` to run the validator and then run `make validate-schemas` to validate the schemas.

**Schema file names must use snake case to be compatible with runner**

## Generating translated schemas

** N.B. Currently only supporting translations for Health themed surveys (PHM).

Before running any translations script it is important to check that the latest release of the eq-translations repo is being
used. This can be done using:
```angular2html
make translations-check
```

To generate a translation template `.pot` file in order to translate a schema, use the following command. It will generate a template file containing all the strings to be translated:
```angular2html
make translation-templates
```

To translate a schema, a `.po` file for the schema will need to be added to the `translations/{THEME}/{LANGUAGE_CODE}` directory containing strings from the schema
and the matching translations. 

The `.po` file needs to be named in the following format: `{SCHEMA_NAME}_{LANGUAGE_CODE}.po`

Once this in place, the following command can be run in order to generate a translated
schema:
```angular2html
make translate-schemas
```
The translated schema will be added to the `/schemas/{THEME}/{LANGUAGE_CODE}` directory.


## Testing built schemas with eq-questionnaire-runner

In order to test the schemas in this repo you will need to create symbolic links between the `/schemas` directory in runner and the folders in the schemas directory here. 

For example in your local eq-questionnaire-runner repository, running the following command will create a symbolic link between the business folder here and the schemas directory in runner.
```
ln -s <PATH_TO_REPO>/eq-questionnaire-schemas/schemas/business <PATH_TO_REPO>/eq-questionnaire-runner/schemas
```
You should now be able to launch a questionnaire using one of the schemas.

**CAVEAT - while `raw.githubusercontent.com` can be used for development and sandbox integrations, it is NOT a formally hosted survey questionnaire registry**
