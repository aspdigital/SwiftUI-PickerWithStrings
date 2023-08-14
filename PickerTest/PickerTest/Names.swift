//
//  Names.swift
//  PickerTest
//
//  Created by Andy Peters on 8/12/23.
//

/*
 * Here is where we define the picker option strings which I call "names."
 * The names are set only in the Preferences pane.
 */
import Foundation

class Names : ObservableObject {
    @Published var names = [String]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(names) {
                UserDefaults.standard.set(encoded, forKey: "PickerListNames")
                print("Names updated in storage, now: \(names)")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "PickerListNames") {
            print("In Names init")
            if let decodedItems = try? JSONDecoder().decode([String].self, from: savedItems) {
                names = decodedItems
                print("Initialized names from storage: \(names)")
            }
        }
    }
}
