//
//  EmptyTile.swift
//  RicochetRobotsPlus
//
//  Created by Leonardo Armelin on 18/04/23.
//

import SwiftUI

struct EmptyTile: Tile, InteractProtocol {
    var color: Color = .black
    var position: Position
    var player: Player? = nil
    
    func onInteract(with key: KeyCode) -> [Position] {
        if player != nil {
            return interactAsWall(with: key)
        }
        return [self.position]
    }
}
