//
//  Background.swift
//  Arista
//
//  Created by Bruno Evrard on 14/01/2025.
//

import SwiftUI

struct BackgroundImageModifier: ViewModifier {
    var imageName: String

    func body(content: Content) -> some View {
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            
            content
        }
    }
}

extension View {
    func backgroundImage(_ imageName: String) -> some View {
        self.modifier(BackgroundImageModifier(imageName: imageName))
    }
}
