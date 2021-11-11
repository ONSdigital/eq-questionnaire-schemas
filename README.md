# eq-questionnaire-schemas

A registry for questionnaire schemas for eq-questionnaire-runner.

A make target exists (`validate-schemas`) in order to validate schemas locally using eq-questionnaire-validator docker image.

To do this run `make run-validator` to run the validator and then run `make validate-schemas` to validate the schemas.

## Testing built schemas with eq-questionnaire-runner

In order to test the schemas in this repo you will need to create a symbolic link between a `/schemas` directory in runner and the schemas directory here. 

In your local eq-questionnaire-runner repository:

Remove the `/schema` directory if it already exists

Create a symbolic link pointing at your generated schema files by running the following command:
```
ln -s <PATH_TO_REPO>/eq-questionnaire-schemas/schemas <PATH_TO_REPO>/eq-questionnaire-runner/schemas
```
You should now be able launch a questionnaire using one of the schemas.

**CAVEAT - while `raw.githubusercontent.com` can be used for development and sandbox integrations, it is NOT a formally hosted survey questionnaire registry**
