.PHONY: govuk_assets_all govuk_elements govuk_template

SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

govuk_assets_all:	govuk_frontend_toolkit_clone_or_pull govuk_elements govuk_template

# https://github.com/alphagov/govuk_frontend_toolkit
govuk_frontend_toolkit_clone_or_pull:
	-./$(SELF_DIR)/scripts/govuk_frontend_toolkit_clone_or_pull.sh

# https://github.com/alphagov/govuk_elements
govuk_elements_clean:
	-rm -rf application/static/govuk_elements

govuk_elements_get:
	-./$(SELF_DIR)scripts/govuk_elements_get.sh

govuk_elements:	govuk_elements_clean govuk_elements_get

# https://github.com/alphagov/govuk_template
govuk_template_clean:
	-rm -rf application/templates/govuk_template

govuk_template_get:
	-./$(SELF_DIR)/scripts/govuk_template_get.sh

govuk_template:	govuk_template_clean govuk_template_get

