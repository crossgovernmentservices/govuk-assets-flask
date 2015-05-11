# Easy import of GOV.UK assets using Make

- https://github.com/alphagov/govuk_template
- https://github.com/alphagov/govuk_elements
- https://github.com/alphagov/govuk_frontend_toolkit

Assumes a Flask app with an application proper called ```application```, with the usual ```static``` and ```templates``` directories inside it.

# Use it in your Flask app

See an example use-case at https://github.com/crossgovernmentservices/xgs_prototypes

Add this project as a submodule to your own. E.g. if you have a location ```scripts``` where you keep things like these:

    git submodule add  https://github.com/crossgovernmentservices/govuk-assets-flask.git scripts/govuk-assets-flask

Modify your existing Makefile to include this one, so add this line:

    include scripts/govuk-assets-flask/Makefile

# Run

    make govuk_assets_all


After a successful run, these 4 directories are new:

    application/template/govuk_template
    application/static/govuk_template
    application/static/govuk_elements
    application/static/govuk_frontend_toolkit

Re-run to get the latest assets.

# Now what?

* Tell govuk_template where to find its assets by using the ```@app.context_processor``` decorator or if you're into factories:

```python
class AssetLocator(object):

    def init_app(self, app):
        app.template_context_processors[None].append(self.locate)

    def locate(self):
        return {'asset_path': '/static/govuk_template/assets/'}
```

* Point to the SASS variables in **govuk_elements** or **govuk_frontend_toolkit** like so:

```sass
@import "../govuk_frontend_toolkit/stylesheets/colours"
@import "../govuk_elements/public/sass/elements/reset";
```
