//
//  BoardFilterTests.swift
//  BoardFilterTests
//
//  Created by Leonardo Armelin on 22/04/23.
//

import XCTest

final class BoardFilterTests: XCTestCase {
    private var boardFilterUseCase: BoardFilterUseCase!
    private var board: [any Tile]!
    
    override func setUpWithError() throws {
        boardFilterUseCase = BoardFilterUseCase()
        board = Boards.boardOne
    }

    func test_goUp_fromZero() {
        // Specific set up
        let key: KeyCode = .arrowUp
        let player: Player = .init(color: .blue, position: .init(x: 0, y: 0))

        // Operation to test
        let filteredBoard = boardFilterUseCase.filterList(for: board, with: key, using: player)
        
        // Expect to stay at the same place
        let expectedResponse: [any Tile] = [EmptyTile(position: .init(x: 0, y: 0))]
        
        XCTAssertTrue(filteredBoard.isEqual(to: expectedResponse))
    }
    
    func test_goRight_fromZero() {
        // Specific set up
        let key: KeyCode = .arrowRight
        let player: Player = .init(color: .blue, position: .init(x: 0, y: 0))

        // Operation to test
        let filteredBoard = boardFilterUseCase.filterList(for: board, with: key, using: player)
        
        // Expect to keep a list from x = 0 to x = 15 (whole board row)
        let expectedResponse: [any Tile] = [
            EmptyTile(position: .init(x: 0, y: 0)),
            PartialWall(position: .init(x: 1, y: 0), sidesBlock: [.right]),
            EmptyTile(position: .init(x: 2, y: 0)),
            EmptyTile(position: .init(x: 3, y: 0)),
            EmptyTile(position: .init(x: 4, y: 0)),
            EmptyTile(position: .init(x: 5, y: 0)),
            EmptyTile(position: .init(x: 6, y: 0)),
            EmptyTile(position: .init(x: 7, y: 0)),
            PartialWall(position: .init(x: 8, y: 0), sidesBlock: [.right]),
            EmptyTile(position: .init(x: 9, y: 0)),
            EmptyTile(position: .init(x: 10, y: 0)),
            EmptyTile(position: .init(x: 11, y: 0)),
            EmptyTile(position: .init(x: 12, y: 0)),
            EmptyTile(position: .init(x: 13, y: 0)),
            EmptyTile(position: .init(x: 14, y: 0)),
            EmptyTile(position: .init(x: 15, y: 0))
        ]
        
        XCTAssertTrue(filteredBoard.isEqual(to: expectedResponse))
    }
    
    func test_goLeft_fromMiddle() {
        // Specific set up
        let key: KeyCode = .arrowLeft
        let player: Player = .init(color: .blue, position: .init(x: 4, y: 3))

        // Operation to test
        let filteredBoard = boardFilterUseCase.filterList(for: board, with: key, using: player)
        
        // Expect to invert the list from x = 4 to x = 0
        let expectedResponse: [any Tile] = [
            EmptyTile(position: .init(x: 4, y: 3)),
            EmptyTile(position: .init(x: 3, y: 3)),
            EmptyTile(position: .init(x: 2, y: 3)),
            PartialWall(position: .init(x: 1, y: 3), sidesBlock: [.top, .right]),
            PartialWall(position: .init(x: 0, y: 3), sidesBlock: [.bottom])
        ]

        XCTAssertTrue(filteredBoard.isEqual(to: expectedResponse))
    }
    
    func test_goBottom_fromMiddle() {
        // Specific set up
        let key: KeyCode = .arrowDown
        let player: Player = .init(color: .blue, position: .init(x: 4, y: 13))

        // Operation to test
        let filteredBoard = boardFilterUseCase.filterList(for: board, with: key, using: player)
        
        // Expect to invert the list from y = 13 to y = 15
        let expectedResponse: [any Tile] = [
            EmptyTile(position: .init(x: 4, y: 13)),
            EmptyTile(position: .init(x: 4, y: 14)),
            EmptyTile(position: .init(x: 4, y: 15)),
        ]

        XCTAssertTrue(filteredBoard.isEqual(to: expectedResponse))
    }
}
