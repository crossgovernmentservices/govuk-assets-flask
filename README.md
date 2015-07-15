# Easy import of GOV.UK assets using Make

- https://github.com/alphagov/govuk_template
- https://github.com/alphagov/govuk_elements
- https://github.com/alphagov/govuk_frontend_toolkit

Assumes a Flask app with an application proper called ```application```, with the usual ```static``` and ```templates``` directories inside it.

# Use it in your Flask app

I recommend using RVM, renv, or similar. Copy [.ruby-version](.ruby-version) and [.ruby-gemset](.ruby-gemset) into the root of your Flask app, ```cd ..; cd -``` for it to take effect, then follow the steps below.

## Just once


    git clone  https://github.com/crossgovernmentservices/govuk-assets-flask.git scripts/govuk-assets-flask
    make -f scripts/govuk-assets-flask/Makefile govuk_assets_all

## Many times

I.e. make it part of your development flow.

Add this project as a submodule to your own. E.g. if you have a location ```scripts``` where you keep things like these:

    git submodule add  https://github.com/crossgovernmentservices/govuk-assets-flask.git scripts/govuk-assets-flask

Modify your existing Makefile to include this one, so add this line:

    include scripts/govuk-assets-flask/Makefile

Then run it:

    make govuk_assets_all


After a successful run, these 4 directories are new:

    application/template/govuk_template
    application/static/govuk_template
    application/static/govuk_elements
    application/static/govuk_frontend_toolkit

Re-run to get the latest assets.

# What about Heroku?

See this commit in the example app:

https://github.com/crossgovernmentservices/xgs_prototypes/commit/bc88582b27e5e9b57d3c13ba2640c38edd60a06d

...and make sure to use the 'multi' buildpack:

    heroku config:set BUILDPACK_URL=https://github.com/ddollar/heroku-buildpack-multi.git
    
...and also tell Flask where it can find the Sass binary:

     heroku config:set SASS_BIN=/app/vendor/ruby-2.0.0/bin/sass

# Now what?

* In your own ```layout.html```:

    {% extends "govuk_template/views/layouts/govuk_template.html" %}

```govuk_template.html``` defines the following blocks:

- top_of_page
- page_title
- head
- body_classes
- body_start
- cookie_message
- header_class
- inside_header
- proposition_header
- after_header
- content
- footer_top
- footer_support_links
- body_end

E.g. inject your content with:

```html
{% block content %}
  <p>My content</p>
{% endblock %}
```

* Tell govuk_template where to find its assets by using the ```@app.context_processor``` decorator or if you're into factories:

(copy/paste the below, or use [asset_locator.py](asset_locator.py).)

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
