# README

[![Build Status](https://travis-ci.org/joelakes/TCD-Hyrax-Web-App.svg?branch=master)](https://travis-ci.org/joelakes/TCD-Hyrax-Web-App)

## Local Setup

In order for the Universal Viewer to work properly locally, run the following:
```sh
yarn install
```

### Docker Setup

Refer to the [ops README](ops/README.md).

---

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Rails version:
  - 5.1.6 (Hyrax didn't work with 5.2.1)

* Ruby version:
  - 2.5.1

* System dependencies/Hyrax prerequisites:
  - Imagemagick (I had to add jpg delegate)
  - Fits 1.3.0
  - LibreOffice
  - Fedora Commons 4.7.5
  - MySql (defaults to SqlLite without it)
  - Solr 7.5.0 (needed to clone solr_wrapper config to set up Core)
  - Redis (also needs tcl)
  - ffmpeg

* Configuration
  -

* Database creation
  -

* Database initialization
  -

* How to run the test suite:
  - rake hydra:test_server
  - rspec spec

* Services (job queues, cache servers, search engines, etc.)
  - Search engine is SOLR
  -

* Deployment instructions
  -

* ...

* ... etc
