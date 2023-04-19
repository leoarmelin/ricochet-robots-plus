//
//  Wall.swift
//  RicochetRobotsPlus
//
//  Created by Leonardo Armelin on 18/04/23.
//

import SwiftUI

struct Wall: Tile, InteractProtocol {
    let color: Color = .red
    var position: Position
    
    func onInteract(with key: KeyCode) -> [Position] {
        interactAsWall(with: key)
    }
}
