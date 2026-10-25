# Zimu Wang Personal Website

Source for [Zimu Wang's personal website](https://zimuwang-real.github.io/), built on top of the [academicpages](https://github.com/academicpages/academicpages.github.io) Jekyll template.

The search identity uses the site title in `_config.yml`, homepage `WebSite`
structured data in `_includes/seo.html`, and the ZW monogram in `images/favicon.svg`
with matching PNG, ICO, and Apple touch icons. Regenerate the raster icons when
changing the SVG so browsers and search results use the same design.

After publishing identity changes, use Google Search Console's URL Inspection
tool for `https://zimuwang-real.github.io/` and select **Request indexing**.
Google chooses the displayed site name and icon; updates require recrawling.
