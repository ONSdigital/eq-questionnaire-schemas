# eq-questionnaire-schemas

A registry for questionnaire schemas for eq-questionnaire-runner.

A make target exists (`validate-schemas`) in order to validate schemas locally using eq-questionnaire-validator docker image
## Testing built schemas with eq-questionnaire-runner

In order to test the schemas built in this repo you will need to create a symbolic link between a /schemas directory in runner and the schemas directory that is generated here. 

In eq-questionnaire-schemas:

In your local eq-questionnaire-runner repository:

Remove the `/schema` directory if it already exists

Create a symbolic link pointing at your generated schema files by running the following command:
```
ln -s <PATH_TO_REPO>/eq-questionnaire-schemas/schemas <PATH_TO_REPO>/eq-questionnaire-runner/schemas
```
You should now be able launch a questionnaire using one of the schemas.

**CAVEAT - while `raw.githubusercontent.com` can be used for development and sandbox integrations, it is NOT a formally hosted survey questionnaire registry**
