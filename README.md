# Archived
Take a look at [this](https://github.com/dxw/dxw_govuk_frontend_rails) to see 
how to add the GOVUK frontend to Rails with sprockets.

If you want to use webpacker, I would go and look at the excellent [DfE Rails
template](https://github.com/DFE-Digital/govuk-rails-boilerplate)

## GOVUK Frontend in Rails
I have a need to do this at work and so I wanted to find the most 'Rails' way to
get this done. The main goals were:

- keep the dependancy management in package.json
- load the assets into the asset pipeline
- keep the config to a minimum and at an appropriate level (the app)
- allow the styles to be overriden

I am no Rails expert so this was a journey into that for me as well.

Feedback welcome!

### Install GOVUK-frontend
```yarn add govuk-frontend```

### Config the app to use the GOVUK asset paths

Edit config/initalizers/assets.rb

Images:

```ruby
Rails.application.config.assets.paths << Rails.root.join('node_modules/govuk-frontend/assets/images')
```

Fonts (if using NTA):

```ruby
Rails.application.config.assets.paths << Rails.root.join('node_modules/govuk-frontend/assets/fonts')
```

### Add GOVUK to precompile

Edit config/initalizers/assets.rb

Images:

```ruby
Rails.application.config.assets.precompile += %w( govuk-frontend/assets/images/* )
```

Fonts (if using NTA font and your app is deployed to a gov.uk domain):

```ruby
Rails.application.config.assets.precompile += %w( govuk-frontend/assets/fonts/* )
```

If you are not using NTA make sure you set you fonts in `_settings.scss`

### Stop Rails loading all styles and JS files

We'll load everyting ourselves.

Remove `*= require_tree .` from app/assets/stylesheets/application.css

Remove `//= require_tree .` from app/assets/javascripts/application.js

### Import the GOVUK syles and settings

Create `govuk-frontend.scss` at app/assets/stylesheets

Create `_settings.scss` at app/assets/stylesheets for your settings

Edit govuk-frontend.scss:

```scss
// We import the GOVUK settings and then override the ones we need to in
// our own settings file.
@import "govuk-frontend/settings/all";
@import "settings";
@import "govuk-frontend/tools/all";
@import "govuk-frontend/helpers/all";
@import "govuk-frontend/core/all";
@import "govuk-frontend/objects/all";
// We are importing all the GOVUK components here, but we could import only
// the ones we need.
@import "govuk-frontend/components/all";
@import "govuk-frontend/utilities/all";
@import "govuk-frontend/overrides/all";
```

Edit _settings.scss:

This is a sensible place to start.

```scss
// Override any GOVUK settings here
// use Rails asset helpers
$govuk-font-url-function: 'font-url';
$govuk-image-url-function: 'image-url';
// tell GOVUK to apply base styles to <p> and <a> so we don't have to add the
// classes
$govuk-global-styles: true;
// Disable compatibilty with old GOVUK kits as we do not need it
$govuk-compatibility-govukfrontendtoolkit: false;
$govuk-compatibility-govuktemplate: false;
$govuk-compatibility-govukelements: false;
```

### Require the GOVUK JS

 Add this to app/assets/javascripts/application.js
 ```
 //= require govuk-frontend/all
 ```

Initialize the JS on your page:

```html
  <script>
    window.GOVUKFrontend.initAll()
  </script>
```
 ### Add GOVUK markup
 Check the docs at [https://github.com/alphagov/govuk-frontend](https://github.com/alphagov/govuk-frontend)

 Or look at the starting point in `app/views/layouts/application.erb` and `app/views/home/index.html.erb`

 ## Deploy
Make sure your deploy solution can run yarn.
