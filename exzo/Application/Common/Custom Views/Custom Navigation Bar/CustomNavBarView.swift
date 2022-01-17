//
//  CustomNavBarView.swift
//  exzo
//
//  Created by Deven Nathanael on 02/11/21.
//

import SwiftUI

struct CustomNavBarView: View {
    @Environment(\.presentationMode) var presentationMode
    let twoColumnsNavBar: Bool

    let title: String
    let subtitle: String?
    let showButton: NavBarButton
    var action: () -> Void

    private var backButton: some View {
        Button(action: {
            presentationMode
                .wrappedValue
                .dismiss()
        }, label: {
            Image(systemName: "chevron.left")
        })
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 28))
                .fontWeight(.bold)
        }
    }
    
    private var dateTime: some View {
        VStack {
            Text(title)
                .font(.system(size: 22))
                .fontWeight(.heavy)
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.system(size: 16))
                    .fontWeight(.black)
            }
        }
    }
    
    private var addButton: some View {
        Button(action: {
            action()
        }, label: {
            Image(systemName: "plus")
                .foregroundColor(Color.brandy)
        }).background(
            Circle()
                .fill(Color.antique)
                .frame(width: 29, height: 29)
        )
    }
    
    private var editButton: some View {
        Button(action: {
            action()
        }, label: {
            Image(systemName: "highlighter")
                .foregroundColor(Color.brandy)
        }).background(
            Circle()
                .fill(Color.antique)
                .frame(width: 29, height: 29)
        )
    }
    
    private var settingsButton: some View {
        Button(action: {
            action()
        }, label: {
            Image(systemName: "gearshape")
                .foregroundColor(Color.brandy)
        }).background(
            Circle()
                .fill(Color.antique)
                .frame(width: 29, height: 29)
        )
    }
    
    var body: some View {
        HStack {
            if twoColumnsNavBar {
                backButton
                Spacer()
                dateTime
            } else {
                titleSection
            }
            Spacer()
            if showButton == NavBarButton.addButton {
                addButton
            } else if showButton == NavBarButton.editButton {
                editButton
            } else {
                settingsButton
            }
        }
        .padding()
        .accentColor(.white)
        .foregroundColor(.white)
        .font(.headline)
        .background(
            Image("NavBar-Background")
                .resizable()
                .cornerRadius(radius: 30, corners: .bottomRight)
                .cornerRadius(radius: 30, corners: .bottomLeft)
                .ignoresSafeArea()
        )
    }
}

extension CustomNavBarView {

}

struct CustomNavBarView_Previews: PreviewProvider {
    static var previews: some View {
            VStack {
                CustomNavBarView(twoColumnsNavBar: true, title: "9 Feb 2000", subtitle: "20:00", showButton: NavBarButton.editButton) {}
                Spacer()
            }
    }
}
