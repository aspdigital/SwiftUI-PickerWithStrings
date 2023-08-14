//
//  PreferencesView.swift
//  PickerTest
//
//  Created by Andy Peters on 8/12/23.
//

import SwiftUI

struct PreferencesView: View {

    var body: some View {
        TabView {
            NameSetupPreferencesView()
        }
        .frame(width: 400, height: 250)
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
