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
    
    func onInteract(with key: KeyCode, for player: Player) -> [Position] {
        interactAsWall(with: key)
    }
}

extension Wall {
    static func == (lhs: Wall, rhs: Wall) -> Bool {
        lhs.position == rhs.position
    }
}
