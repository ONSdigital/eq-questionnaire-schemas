clean:
	rm -rf schemas

build-schemas:
	./scripts/build_schemas.sh

build: build-schemas translate-schemas

run-validator:
	./scripts/run_validator.sh

lint-jsonnet:
	./scripts/lint_jsonnet.sh

validate-schemas:
	./scripts/validate_schemas.sh

translate-schemas:
	pipenv run python -m scripts.translate_schemas

translation-templates:
	pipenv run python -m scripts.extract_translation_templates

test-translation-templates:
	pipenv run python -m scripts.extract_translation_templates --test
