//
//  GetBoardTileUseCase.swift
//  RicochetRobotsPlus
//
//  Created by Leonardo Armelin on 22/04/23.
//

struct GetBoardTileUseCase {
    func getTile(for board: [any Tile], on position: Position) -> any Tile {
        return board.first { tile in tile.position == position }!
    }
}
