//
//  PickerTestApp.swift
//  PickerTest
//
//  Created by Andy Peters on 8/11/23.
//

import SwiftUI

@main
struct PickerTestApp: App {
    
    @StateObject var names = Names(key: "PickerListNames")
    
    var body: some Scene {
        Window("Picker Test App", id: "main") {
            ContentView(sel: Selection(sel: 0))
                .environmentObject(names)
        }
        Settings {
            PreferencesView()
                .environmentObject(names)
        }
    }
}
