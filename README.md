# about_you

About you inteview App by Eric Pomeranz Ritter

## Getting Started

This project is a small code test for about you.

## IMPORTANT NOTES

* The project was tested only in android phones
* Only a few Unit test tests were written for this demo
* The demo includes two json files with the following name and locations
  * assets/json/contacts.json (provided by About you)
  * assets/json/contacts_large.json (a much larger file to test pagination and performance)

if you want to switch between the provided list of contacts and the large one you can do so [here (direct github link)](https://github.com/epomeranz/about_you/blob/882f5c03a086f1ea89bdf7239aa303f6ac3cae89/lib/core/services/db/user_snippets_db_Service_mockup.dart#L10)
* lib/core/services/db/user_snippets_db_Service_mockup.dart#L10

future updates:
The Stacked packages I use in the MVVM architecture does not provide a good locator service for instances that need parameters for their constructor. At the moment the view is declaring the VM instead of using dependency inversion. In future apps I would like to explore getx and replace the locator service with dependency injection
Otherwise this archtecture it's a good approach to a SOLID architecture.

## Features included in this demo:
* SOLID priciples architecture
* pagination in list view
* Support for localization
* mockup services
* MVVM Architecture
* light Unit Testing of one View Model
* published to web demo (see link below)
* Pretty aweful design (I'm not a good designer :p)
* etc.

## Live Demo

You can see the app running in web at
[About you demo](https://ericpomeranz.web.app/#/home-view).
