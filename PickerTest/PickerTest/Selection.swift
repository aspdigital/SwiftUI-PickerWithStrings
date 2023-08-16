//
//  Selection.swift
//  PickerTest
//
//  Created by Andy Peters on 8/13/23.
//

/*
 * This is where we define the user's selection from the picker.
 * The Picker view doesn't display the selected item (the index into the picker)
 * because that selection is used "elsewhere."
 *
 * For our demo the Picker will select a new choice, and in the view that
 * includes the picker we'll have a text box displaying the choice.
 *
 * Assume that the selection doesn't persist after closing the application.
 */

import Foundation

class Selection : ObservableObject {
    @Published var selection : Int
    
    init() {
        self.selection = 0
    }
    
    init(sel: Int) {
        self.selection = sel
    }
}


