//
//  ContentView.swift
//  PickerTest
//
//  Created by Andy Peters on 8/11/23.
//

import SwiftUI

struct ContentView: View {
    
    /* Fetch the current names used to populate the picker. */
    @EnvironmentObject var pickerNames : Names
    
    //let initstrings : [String] = ["Turntable", "Main DAC", "EVO", "CD Player"]
    
    var body: some View {
        VStack {
            PickerView(instr: pickerNames.names)
     //       PickerView(instr: initstrings)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
