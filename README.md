# Easy import of GOV.UK assets using Make

- https://github.com/alphagov/govuk_template
- https://github.com/alphagov/govuk_elements
- https://github.com/alphagov/govuk_frontend_toolkit

Assumes a Flask app with an application proper called ```application```, with the usual ```static``` and ```template``` directories inside it.

See an example use-case at https://github.com/crossgovernmentservices/xgs_prototypes

# Run

    make govuk_assets_all


After a successful run, these 3 directories are new:

    application/template/govuk_template
    application/static/govuk_elements
    application/static/govuk_frontend_toolkit

Re-run to get the latest assets.
