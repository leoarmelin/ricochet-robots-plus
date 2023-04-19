//
//  ViewExtensions.swift
//  RicochetRobotsPlus
//
//  Created by Leonardo Armelin on 18/04/23.
//

import SwiftUI

extension View {
    @ViewBuilder func `applyIf`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
