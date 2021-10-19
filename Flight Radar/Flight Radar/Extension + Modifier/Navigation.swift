//
//  NavigationBarHidden.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/19/21.
//

import SwiftUI

struct NavigationBarHidden: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea([.top, .bottom])
    }
}

struct NavigationBarInTabBarHidden: ViewModifier {
    func body(content: Content) -> some View {
        content
            .edgesIgnoringSafeArea([.top])
            .navigationBarHidden(true)
    }
}

//struct Navigation: View {
//    let distination: View
//
//    var body: some View {
//        NavigationLink(destination: distination, label: <#T##() -> _#>)
//    }
//}
