# iOS Technical Challenge - Emoji & GitHub App

This is an iOS app built with UIKit using View Code (no Storyboards). It follows Clean Architecture and MVVM patterns.


Architecture & Decisions

- **SOLID & Protocols**: I used protocols so different layers communicate through interfaces instead of concrete classes.
- **AppContainer**: I wanted a single place to create and assemble all instances (Network, Storage, Repositories, UseCases). As the project grew, I kept adding methods here to manage Dependency Injection cleanly.
- **Coordinator Pattern**: I created a Coordinator because I did not want ViewControllers to handle navigation directly or pass dependencies into the navigation stack, respecting DI.
- **ViewModel Data Transformation**: In the ViewModel, I converted the API response dictionary into an array of structs so the list could render the items cleanly.

---

## Challenges & Things I Am Learning

- **Classes vs Structs**: I am still working on fully understanding when to pick a class or a struct in everyday code, especially around memory and reference handling.
- **Search Field Validation**: I noticed the app still lets users search even when the text field is empty, which should be blocked.

---

## Points to Improve

- **Git Flow Discipline**: I made a few mistakes during the challenge by mixing fixes and refactors inside feature branches.
