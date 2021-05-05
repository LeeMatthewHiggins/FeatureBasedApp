# feature_based_app

A WIP bootstrap for feature based approach to flutter apps

## Getting Started

This project is a starting point for a Flutter application based around a concept of a "feature graph"

This is an experimental project.

The current engineering pattern is a flavor of MVVM with the viewmodel implementation extracted to a Business logic class, leaving the viewmodel class as just an interface. This means views only know about the interface, the viewmodel implementation can be changed at will.
The business logic class should use repositories to abstract away from implementation details of the data source. 

A cross section of the app looks like this:

View <- View Model <- Business Logic [<- Repositories <- Services]

Repositories use services
Repositories provide model objects
Business logic class uses repositories
Business logic class provides a view model
Views use viewmodels

View Model classes are kept simple, with no state (state can in the business logic class).

Concept:
The app starts with a route feature (e.g a landing page)

Features have an id,
A type,
Some metadata (title, subtitle)
and config
They can be thought of as micro apps
A screen could be composed of many features

A *provider repository*, which can build providers given a type (viewmodel type) and a context.
A *widget repository*, which can build widgets given a feature type.

Features are resolved using a FeatureBuilder widget, this uses the systems above to build the feature.
