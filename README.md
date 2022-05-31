# rapid-clickable-wireframes

Building clickable lo-fi wireframes really quickly using plantuml, envsubst and svg links. Great for workshops! 

## Quickstart

Clone this repo

```
cd rapid-clickable-wireframes
docker build -t rcw .
docker run -it -p 8080:8080 rcw
```

and browse to localhost:8080 to see the sample app.

Change credentials `config/httpd.conf`
Change templates in `config/template.*`
Create new pages in `pages/*.uml`

## Description

Scrappy shell script to orchestrate the following...

- Use a template UML file containing headers and footers for all pages and inject page content and title based on normalised filename
- Generate SVG with plantuml
- Add links based on normalised file names. e.g. all instances of "Sample Page" will be linked to SamplePage.html
- Create html pages containing svg images
- create a docker container with a busybox webserver for the pages, protected by basic auth

Deploy the result and let your team click around!

## Prerequisites

- Docker

