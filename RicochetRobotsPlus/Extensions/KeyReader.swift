//
//  KeyReader.swift
//  RicochetRobotsPlus
//
//  Created by Leonardo Armelin on 18/04/23.
//

import SwiftUI

struct KeyReaderModifier: ViewModifier {
    let onKeyPress: (KeyCode) -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                NSEvent.addLocalMonitorForEvents(matching: [.keyDown]) { nsevent in
                    switch nsevent.keyCode {
                    case KeyCode.arrowUp.rawValue:
                        onKeyPress(KeyCode.arrowUp)
                    case KeyCode.arrowDown.rawValue:
                        onKeyPress(KeyCode.arrowDown)
                    case KeyCode.arrowLeft.rawValue:
                        onKeyPress(KeyCode.arrowLeft)
                    case KeyCode.arrowRight.rawValue:
                        onKeyPress(KeyCode.arrowRight)
                    default:
                        break
                    }
                    
                    return nsevent
                }
            }
    }
}

extension View {
    func onKeyPress(onKeyPress: @escaping (KeyCode) -> Void) -> some View {
        self.modifier(KeyReaderModifier(onKeyPress: onKeyPress))
    }
}
