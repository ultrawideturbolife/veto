## 0.0.4+1

* **🐛️ Bugfix:** Fixed naming of `AkeViewModelBuilder`.

## 0.0.4

* **✨ New:** Added `AutomaticKeepAliveClientMixin` to `AkeViewModelBuilder`.
* **✨ New:** Added `AkeBaseViewModel`.

## 0.0.3+2

* Improve readme

## 0.0.3+1

* Improved isMounted logic.

## 0.0.3

* **⚠️ Breaking:** Made the `BaseViewModel.context` getter nullable to better reflect actual logic.
* **⚠️ Breaking:** Removed all context related helper methods. Suggest to add these methods to a context extension yourself for easy fix and access.

## 0.0.2

* **⚠️ Breaking:** Refactor `BaseViewModel.isMounted` to function instead of callback.

## 0.0.1+7

* Update example project

## 0.0.1+6

* Fix fully removing unused parameters.
* Remove irrelevant todos.

## 0.0.1+5

* **⚠️ Breaking:** Removed `disposeViewModel`, `initialiseViewModel` and `rebuild` boolean arguments to the `ViewModelBuilder`.

## 0.0.1+4

* **✨ New:** Added `disposeViewModel`, `initialiseViewModel` and `rebuild` boolean arguments to the `ViewModelBuilder`.

## 0.0.1+3

* Updated readme.

## 0.0.1+2

* **✨ New:** Added proper example project, unit tests and widget tests.

## 0.0.1+1

* **🐛️ Bugfix:** Improved the `BaseViewModel.state` logic to give `hasError` and `isBusy` proper back and forth precedence over `isInitialised`.

## 0.0.1

* Initial release.
