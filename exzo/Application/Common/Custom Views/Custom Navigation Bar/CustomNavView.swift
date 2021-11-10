//
//  CustomNavView.swift
//  exzo
//
//  Created by Deven Nathanael on 08/11/21.
//

import SwiftUI

struct CustomNavView<Content: View>: View {
    
//    var navButtonPressed: () -> Void
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationView {
            CustomNavBarContainerView {
                content
            }
            .navigationBarHidden(true)
//            .navigationBarTitleDisplay
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CustomNavView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavView {
            ScrollView {
                Text("ASDJKASJKANSKJNAJKSDNJKANKJANJKASNKDJNASKJDNAJKNDJKASNDKJANKDJANSJKDNASKJDNKAJSND")
                Text("ASDJKASJKANSKJNAJKSDNJKANKJANJKASNKDJNASKJDNAJKNDJKASNDKJANKDJANSJKDNASKJDNKAJSND")
                Text("ASDJKASJKANSKJNAJKSDNJKANKJANJKASNKDJNASKJDNAJKNDJKASNDKJANKDJANSJKDNASKJDNKAJSND")
                Text("ASDJKASJKANSKJNAJKSDNJKANKJANJKASNKDJNASKJDNAJKNDJKASNDKJANKDJANSJKDNASKJDNKAJSND")
                Text("ASDJKASJKANSKJNAJKSDNJKANKJANJKASNKDJNASKJDNAJKNDJKASNDKJANKDJANSJKDNASKJDNKAJSND")
                Text("ASDJKASJKANSKJNAJKSDNJKANKJANJKASNKDJNASKJDNAJKNDJKASNDKJANKDJANSJKDNASKJDNKAJSND")
                Text("ASDJKASJKANSKJNAJKSDNJKANKJANJKASNKDJNASKJDNAJKNDJKASNDKJANKDJANSJKDNASKJDNKAJSND")
                Text("ASDJKASJKANSKJNAJKSDNJKANKJANJKASNKDJNASKJDNAJKNDJKASNDKJANKDJANSJKDNASKJDNKAJSND")
            }
        }
    }
}
