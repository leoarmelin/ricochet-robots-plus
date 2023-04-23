//
//  TileView.swift
//  RicochetRobotsPlus
//
//  Created by Leonardo Armelin on 22/04/23.
//

import SwiftUI

struct TileView: View {
    let tile: any Tile
    let size: CGFloat = 30
    
    var partialWall: PartialWall? {
        tile as? PartialWall
    }
    
    var body: some View {
        Rectangle()
            .fill(partialWall?.color ?? tile.color)
            .applyIf(partialWall?.sidesBlock.contains(.top) == true) {
                $0.overlay(Rectangle().fill(.gray).frame(width: 30, height: 4), alignment: .top)
            }
            .applyIf(partialWall?.sidesBlock.contains(.bottom) == true) {
                $0.overlay(Rectangle().fill(.gray).frame(width: 30, height: 4), alignment: .bottom)
            }
            .applyIf(partialWall?.sidesBlock.contains(.left) == true) {
                $0.overlay(Rectangle().fill(.gray).frame(width: 4, height: 30), alignment: .leading)
            }
            .applyIf(partialWall?.sidesBlock.contains(.right) == true) {
                $0.overlay(Rectangle().fill(.gray).frame(width: 4, height: 30), alignment: .trailing)
            }
            .frame(width: size, height: size)
    }
}