.PHONY: govuk_assets_all govuk_elements govuk_template

SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

govuk_assets_all:	govuk_frontend_toolkit govuk_elements govuk_template

# https://github.com/alphagov/govuk_frontend_toolkit
govuk_frontend_toolkit_clean:
	-./$(SELF_DIR)/scripts/govuk_frontend_toolkit.sh clean

govuk_frontend_toolkit_get:
	-./$(SELF_DIR)/scripts/govuk_frontend_toolkit.sh get

govuk_frontend_toolkit: govuk_frontend_toolkit_clean govuk_frontend_toolkit_get

# https://github.com/alphagov/govuk_elements
govuk_elements_clean:
	-./$(SELF_DIR)scripts/govuk_elements.sh clean

govuk_elements_get:
	-./$(SELF_DIR)scripts/govuk_elements.sh get

govuk_elements:	govuk_elements_clean govuk_elements_get

# https://github.com/alphagov/govuk_template
govuk_template_clean:
	-./$(SELF_DIR)/scripts/govuk_template.sh clean

govuk_template_get:
	-./$(SELF_DIR)/scripts/govuk_template.sh get

govuk_template:	govuk_template_clean govuk_template_get

