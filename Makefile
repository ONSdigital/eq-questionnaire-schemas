clean:
	rm -rf schemas

build-schemas:
	./scripts/build_schemas.sh

build: build-schemas translate-schemas resolve-suggestions-urls

run-validator:
	./scripts/run_validator.sh

format:
	./scripts/format_jsonnet.sh

lint:
	./scripts/lint_jsonnet.sh

validate-schemas:
	./scripts/validate_schemas.sh

eq-translations-check:
	pipenv run python -m scripts.eq_translations_check

translate-schemas: eq-translations-check
	pipenv run python -m scripts.translate_schemas

translation-templates: eq-translations-check
	pipenv run python -m scripts.extract_translation_templates

test-translation-templates: eq-translations-check
	pipenv run python -m scripts.extract_translation_templates --test

resolve-suggestions-urls:
	pipenv run python -m scripts.resolve_suggestions_urls
