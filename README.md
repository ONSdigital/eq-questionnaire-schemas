# eq-questionnaire-schemas

A registry for questionnaire schemas for eq-questionnaire-runner.

A make target exists (`validate-schemas`) in order to validate schemas locally using eq-questionnaire-validator docker image.

To do this run `make run-validator` to run the validator and then run `make validate-schemas` to validate the schemas.

## Testing built schemas with eq-questionnaire-runner

In order to test the schemas in this repo you will need to create symbolic links between the `/schemas` directory in runner and the folders in the schemas directory here. 

For example in your local eq-questionnaire-runner repository, running the following command will create a symbolic link between the business folder here and the schemas directory in runner.
```
ln -s <PATH_TO_REPO>/eq-questionnaire-schemas/schemas/business <PATH_TO_REPO>/eq-questionnaire-runner/schemas
```
You should now be able launch a questionnaire using one of the schemas.

**CAVEAT - while `raw.githubusercontent.com` can be used for development and sandbox integrations, it is NOT a formally hosted survey questionnaire registry**
