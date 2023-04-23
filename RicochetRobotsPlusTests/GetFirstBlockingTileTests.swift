//
//  GetFirstBlockingTileTests.swift
//  RicochetRobotsPlusTests
//
//  Created by Leonardo Armelin on 23/04/23.
//

import XCTest

final class GetFirstBlockingTileTests: XCTestCase {
    private var getFirstBlockingTileUseCase: GetFirstBlockingTileUseCase!
    private var boardFilterUseCase: BoardFilterUseCase!
    private var board: [any Tile]!
    
    override func setUpWithError() throws {
        getFirstBlockingTileUseCase = GetFirstBlockingTileUseCase()
        boardFilterUseCase = BoardFilterUseCase()
        board = Boards.boardOne
    }

    func test_partialWall_outside() throws {
        let key: KeyCode = .arrowRight
        let player: Player = .init(color: .blue, position: .init(x: 0, y: 0))
        let filteredBoard = boardFilterUseCase.filterList(for: board, with: key, using: player)
        let tile = getFirstBlockingTileUseCase.getFirstBlockingTile(for: filteredBoard, with: key, using: player)
        
        XCTAssertTrue(tile?.isEqual(to: board[1]) == true)
    }
    
    func test_partialWall_over() throws {
        let key: KeyCode = .arrowRight
        let player: Player = .init(color: .blue, position: .init(x: 1, y: 0))
        let filteredBoard = boardFilterUseCase.filterList(for: board, with: key, using: player)
        let tile = getFirstBlockingTileUseCase.getFirstBlockingTile(for: filteredBoard, with: key, using: player)
        
        XCTAssertTrue(tile?.isEqual(to: board[1]) == true)
    }
    
    func test_partialWall_ignore() throws {
        let key: KeyCode = .arrowLeft
        let player: Player = .init(color: .blue, position: .init(x: 1, y: 0))
        let filteredBoard = boardFilterUseCase.filterList(for: board, with: key, using: player)
        let tile = getFirstBlockingTileUseCase.getFirstBlockingTile(for: filteredBoard, with: key, using: player)
        
        XCTAssertTrue(tile?.isEqual(to: board[0]) == true)
    }
    
    func test_wall() throws {
        let key: KeyCode = .arrowDown
        let player: Player = .init(color: .blue, position: .init(x: 7, y: 0))
        let filteredBoard = boardFilterUseCase.filterList(for: board, with: key, using: player)
        let tile = getFirstBlockingTileUseCase.getFirstBlockingTile(for: filteredBoard, with: key, using: player)
        
        XCTAssertTrue(tile?.isEqual(to: board[119]) == true)
    }
    
    func test_nothing() throws {
        let key: KeyCode = .arrowDown
        let player: Player = .init(color: .blue, position: .init(x: 5, y: 0))
        let filteredBoard = boardFilterUseCase.filterList(for: board, with: key, using: player)
        let tile = getFirstBlockingTileUseCase.getFirstBlockingTile(for: filteredBoard, with: key, using: player)
        
        XCTAssertTrue(tile?.isEqual(to: board[245]) == true)
    }
}
