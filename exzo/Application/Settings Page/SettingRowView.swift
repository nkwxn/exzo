//
//  SettingRowView.swift
//  exzo
//
//  Created by Deven Nathanael on 11/11/21.
//

import SwiftUI

struct SettingRowView: View {
    let settingIcon: String
    let settingTitle: String
    var showChevron: Bool = false
    var body: some View {
        Image(systemName: settingIcon)
        Text(settingTitle)
//        HStack {
//            Image(systemName: settingIcon)
//            Text(settingTitle)
//            Spacer()
//            if showChevron {
//                Image(systemName: "chevron.right")
//            }
//        }
//        .foregroundColor(.black)
    }
}
