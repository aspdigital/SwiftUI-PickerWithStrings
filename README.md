# SwiftUI-PickerWithStrings
Here is an example of a SwiftUI Picker control which displays customizable strings for each choice, and the selector returns an integer.

## Description
SwiftUI's Picker control is a renamed drop-down menu control. (If one is clever, one can combine the Picker with a TextField and get a Combo Box.)

I have an application that uses a Picker to select one of four choices, which seems pretty standard. But rather than have the Picker display hard-coded choices, for this application it is useful to show strings that are meaningful. That too is standard, but what if the user could change the strings?  That would be useful indeed! 

Also this application really doesn't care about the names of the choices, only that the user chose 0, 1, 2, 3 or whatever, so the selector returned by the Picker is a simple integer.

The project here includes the customized Picker control in PickerView, and the main ContentView instantiates it and supplies the strings to be displayed with the choices.

I'm a hardware design engineer who mainly works with FPGAs. I'm by no means an expert host computer application programmer or Swift/SwiftUI wizard. Surely there are better ways to this this,

## The control

The control is defined in the `PickerView` structure.

Like all of the usual controls, the Picker requires a `@State` property that is used to set the selection initially and is returned when the user makes a selection. Conveniently, that property is passed to the Picker instantiation as the `selection:` argument. The property, called `selection`, is defined as an `Int` because I have an application which really only cares about the index of the selected choice. What the choice means is interesting to the user but not the application.

Next, an array of `String` is declared. Four default strings are defined.

An initializer `init` allows the strings displayed in the Picker to be set to something interesting at instantiation. This includes being able to have more or less than four choices. The instantiation simply passes an array of `String` to the PickerView.

The `body` property of the View has two controls. As this is primarily a demo, we have a Text box that shows the value of the `selection` property (the integer) as well as the string describing it.

The magic is in the Picker instance. After the label, we pass our `@State` property `$selection` as the `selection` argument. In this case, there is nothing to write the new `selection` to the Picker, so `selection` acts as an output. We display our custom strings in the `ForEach` loop. We iterate over the possible indices into our `strings` array and each entry in the Picker is a string.

And that's all there is to it. When the view is created, the Picker is populated with the user-defined strings representing the choices, and when the user plays with the Picker, the Text control updates with the currently-selected index and the associated string.

## To do
This can be a lot more useful. A Preferences or Settings dialog can have a mechanism to allow the user to enter the strings to be displayed in the Picker, and those can all be stored in the defaults with @AppStorage. At program launch the stored strings can populate the Picker.

The `@State` property `selection` can be changed to an `@ObservedObject` that is defined as `@Published var` elsewhere in a class inheriting from `ObservableObject`. This way the program data model knows the state of the Picker, and also can initialize it from defaults.
