//
//  PickerView.swift
//  PickerTest
//
//  Created by Andy Peters on 8/11/23.
//

import SwiftUI

/* For this, we want to show customizable strings in the picker. This strings are
 * stored in an array.
 * We want the index into the array of the string chosen by the picker, because
 * for the monitor controller application that's what gets sent to the hardware.
 * Also our hardware only has four inputs, so we hard-code our array size.
 */
struct PickerView: View {
    
    @State private var selection : Int = 0
       
    private var strings : [String] = ["Input 1", "Input 2", "Input 3", "Input 4"]
    
    /*
     * This initializer accepts an array of strings and overwrites the defaults.
     */
    init(instr : [String]) {
        strings = instr
    }
    
    var body: some View {
        Text("Selected: \(selection) = \(strings[selection])")
        
        Picker("Input:", selection: $selection) {
            /* We want to return the index of the selected entry in the
             * picker list. But we want to show the string that corresponds
             * to that selection. */
            ForEach((0..<strings.count), id: \.self) { i in
                Text(strings[i])
            }
        }
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView(instr: ["1", "2", "3", "4"])
    }
}