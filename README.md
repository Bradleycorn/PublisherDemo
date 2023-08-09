# Publisher Demo

This is a sample Kotlin Multiplatform project that demos a potential issue in
the [KMP-NativeCoroutines](https://github.com/rickclephas/KMP-NativeCoroutines) library.

See [Issue #123](https://github.com/rickclephas/KMP-NativeCoroutines/issues/123) for more information.

To produce the crash, build and run the included iOS app, and then select a new value in the displayed
`Picker`.

The `Picker` has a Binding to a `@Published` property in the included ViewModel.

The Property's publisher is used to trigger a call to the shared Kotlin `FlowCreator` whenever
the property value changes (using `map().switchToLatest()`). The resulting publisher is converted to
an Async Stream (via it's `values` property) and the Stream is then consumed and updates 
another `@Published` property, which is bound to the `Text` View in the ui.