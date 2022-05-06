# rapid-clickable-wireframes

Building clickable lo-fi wireframes really quickly using plantuml, envsubst and svg links. Great for workshops! 

## Description

Scrappy shell script to orchestrate the following...

- Use a template UML file containing headers and footers for all pages and inject page content and title based on normalised filename
- Generate SVG with plantuml
- Add links based on normalised file names. e.g. all instances of "Sample Page" will be linked to SamplePage.html
- Create html pages containing svg images

Deploy the result from ./target/static and let your team click around!

## Prerequisites

- Java
- plantuml + graphviz
- POSIX compliant shell
- `envsubst` (from `gettext`)
- `xmllint` and `xmlstarlet` (formatting and tidying)

