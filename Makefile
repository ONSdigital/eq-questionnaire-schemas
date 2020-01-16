clean:
	rm -rf schemas

build-schemas:
	pipenv run ./scripts/build_schemas.sh

build: build-schemas translate-schemas

run-validator:
	pipenv run ./scripts/run_validator.sh

lint-jsonnet:
	pipenv run ./scripts/lint_jsonnet.sh

test-schemas:
	pipenv run ./scripts/test_schemas.sh

translate-schemas:
	pipenv run python -m scripts.translate_schemas

translation-templates:
	pipenv run python -m scripts.extract_translation_templates

test-translation-templates:
	pipenv run python -m scripts.extract_translation_templates --test
