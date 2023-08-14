//
//  NameSetupPreferences.swift
//  PickerTest
//
//  Created by Andy Peters on 8/12/23.
//

/*
 * In this view, we present a way to modify the names shown in our picker.
 *
 * A TextField lets the user enter a new string for the currently-selected picker
 * option. We are also shown the index into the picker for which this string
 * is displayed.
 *
 * Three buttons control the operation.
 * [Update] means "accept this string as the name for this picker index"
 * [Insert] means "Insert this string to the array used by the picker at the current index."
 * [Delete] means "remove this string and index from the picker entirely."
 * [Clear] means "delete everything and start again"
 */
import SwiftUI

struct NameSetupPreferencesView: View {
    
    /* Names is fetched from defaults storage at startup */
    @EnvironmentObject var names : Names
    
    /* Selection is the active (selected) index of the picker*/
    @State private var selection : Int = 0
    
    /* Populate the text field */
    @State private var textFieldContents : String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter a name", text: $textFieldContents)
                    .help("This is the string you want to add to the picker")
                Text("Index = \(selection)")
            }
            .frame(width: 220, height: 20)
            HStack {
                Button("Update", action: updateThisInPicker)
                    .help("Accept this string as the name for this picker index")
                Button("Insert", action: insertIntoPicker)
                    .help("Insert this string to the array at the current index")
                Button("After", action: addAfterIntoPicker)
                    .help("Add this string after the current index")
                Button("Delete", action: deleteFromPicker)
                    .help("Remove the entry at the current index")
                Button("Clear All", action: clearPicker)
                    .help("Clear the picker entirely")
            }
            HStack {
                Picker("picker", selection: $selection) {
                    ForEach((0..<names.names.count), id: \.self) { i in
                        Text(names.names[i])
                    }
                    .id(names.names)
                    .onChange(of: selection) { tag in
                        /* Handle the case where we've cleared the array here
                         * with our "Clear All" button. When that happens
                         * assigning textFieldContents from the array crashes
                         * us because there's nothing to get. */
                        if names.names.isEmpty {
                            textFieldContents = ""
                        } else {
                            textFieldContents = names.names[selection]
                        }
                    }
                }
            }
        }
    }
    
    func updateThisInPicker () {
        print("In updateThisInPicker")
        /* If there are no entries in the array, we need to append.
         * Otherwise we change the string at selection. */
        print("Number of entries in our picker array: \(names.names.count)")
        print("Current selector = \(selection)")
        if names.names.count == 0 {
            names.names.append(textFieldContents)
            print("We just added \(names.names[selection]) at \(selection)")
        } else {
            names.names[selection] = textFieldContents
            print("We just renamed \(names.names[selection]) at \(selection)")
        }
        print("After update, number of entries in our picker array: \(names.names.count)")
    }
    
    func insertIntoPicker () {
        print("In insertIntoPicker")
        /* If there are no entries in the picker, we need to append.
         * If there are already entries in the picker, we insert this text
         * into the current location, bumping everything up.
         */
        print("Number of entries in our picker array: \(names.names.count)")
        print("Current selection: \(selection)")
        if names.names.count == 0 {
            names.names.append(textFieldContents)
            print("We just added \(names.names[selection]) at \(selection)")
        } else {
            names.names.insert(textFieldContents, at: selection)
            print("We just inserted \(names.names[selection]) at \(selection)")
        }
        print("After insert, number of entries in our picker array: \(names.names.count)")
        /* Update the text field to show what's at the current selection */
        textFieldContents = names.names[selection]
    }
    
    func addAfterIntoPicker () {
        /* if there is nothing in the picker, simply append.
         * If there are already entries, insert the new string after the
         * current selection.
         */
        print("In addAfterIntoPicker")
        if names.names.count == 0 {
            names.names.append(textFieldContents)
        } else {
            selection += 1
            names.names.insert(textFieldContents, at: selection)
        }
        print("Inserted \(textFieldContents) at \(selection)")
    }
    
    func deleteFromPicker() {
        /* to prevent out of range errors that occur when we delete the last entry in
         * the picker and the selecter is still pointing to it, make sure we update
         * the selector before deleting it. */
        print("In deleteFromPicker")
        
        /* don't attempt to remove anything if the picker is empty */
        guard !names.names.isEmpty else { return }
        
        /* Will we be empty after removal? If so update selection and the text field
         * appropriately so we don't show garbage. */

        if names.names.count == 1 {
            /* here, selection must be 0, as it's the only possible option for a
             * one-entry array */
            textFieldContents = ""
            names.names.remove(at: selection)
            print("After removal, picker is empty. selection = \(selection), textFieldContents = \(textFieldContents), array = \(names.names)")
        } else {
            /* will we delete the entry at the end of the picker?
             * if so, we want to set the selector to the entry before that one, and
             * also fill the text box with the contents of that new selector. */
            if selection == names.names.count - 1 {
                selection -= 1
                textFieldContents = names.names[selection]
                names.names.remove(at: names.names.count - 1)
                print("we deleted entry at end of list, so\n\tselection = \(selection)\n\tcount = \(names.names.count)\n\ttextfield = \(textFieldContents)\n\tarray = \(names.names)")
            } else {
                /* we're somewhere in the midddle of the array, so we can remove the
                 * currently selected item without trouble. The selector remains the same
                 * so the text field and picker will auto update properly. */
                names.names.remove(at: selection)
            }
        }
    }
    
    func clearPicker() {
        /* empty the array! Maybe we want an alert. */
        if !names.names.isEmpty {
            print("Deleting all elements of the array")
            names.names.removeSubrange(0..<names.names.count)
            /* clear the text edit field and reset the index, so the user is
             * not confused. */
            textFieldContents = ""
            selection = 0
        }
    }
}

struct NameSetupPreferences_Previews: PreviewProvider {
    static var previews: some View {
        NameSetupPreferencesView()
    }
}
