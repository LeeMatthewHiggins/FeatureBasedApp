# feature_based_app

A WIP bootstrap for feature based approach to flutter apps

## Getting Started

This project is a starting point for a Flutter application based around a concept of a "feature graph"

This is an experimental project.

The current engineering pattern is MVVM with bloc (repos, services, blocs, viewmodels, views(widgets))

A cross section of the app looks like this:

View <- View Model <- Bloc [<- Repositories <- Services]

Repositories use services
Blocs use repositories
Bloc provides a view model
Views use viewmodels

Viewmodels are kept simple, with no state.

Concept:
The app starts with a route feature (e.g a landing page)

Features have an id,
A type,
Some metadata (title, subtitle)
and config
They can be thought of as mini apps

There are two factories/libraries:

A *widget libaray*, which can build widgets given a feature type.

A *provider libaray*, which can build providers given a type (viewmodel type) and a context.

Features are resolved using a FeatureResolver widget, this uses the libraries above to build the feature.

Currenty the project uses riverpods for state notifying and dependency injection.
