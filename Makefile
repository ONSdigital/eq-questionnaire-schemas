run-validator:
	./scripts/run_validator.sh

validate-schemas:
	./scripts/validate_schemas.sh

translations-check:
	poetry run python -m scripts.eq_translations_check

translation-templates: translations-check
	poetry run python -m scripts.extract_translation_templates

test-translation-templates: translations-check
	poetry run python -m scripts.extract_translation_templates --test

translate-schemas: translations-check
	poetry run python -m scripts.translate_schemas