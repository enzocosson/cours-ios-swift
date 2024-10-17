//
//  ChessBoard.swift
//  CoursSwiftUi
//
//  Created by Enzo Cosson on 17/10/2024.
//

import Foundation

class ChessBoard: ObservableObject {
    @Published var board: [[ChessPiece?]] = []
    @Published var selectedPiecePosition: (row: Int, col: Int)? = nil
    @Published var possibleMoves: [(row: Int, col: Int)] = []
    @Published var isWhiteTurn = true
    @Published var gameTimeRemaining: Int = 300 // Temps de jeu en secondes (5 minutes)
    var gameTimer: Timer?

    init() {
        setupBoard()
        startTimer()
    }

    func setupBoard() {
        board = Array(repeating: Array(repeating: nil, count: 8), count: 8)

        board[0] = [
            ChessPiece(type: .rook, color: .white),
            ChessPiece(type: .knight, color: .white),
            ChessPiece(type: .bishop, color: .white),
            ChessPiece(type: .queen, color: .white),
            ChessPiece(type: .king, color: .white),
            ChessPiece(type: .bishop, color: .white),
            ChessPiece(type: .knight, color: .white),
            ChessPiece(type: .rook, color: .white)
        ]

        for i in 0..<8 {
            board[1][i] = ChessPiece(type: .pawn, color: .white)
        }


        board[7] = [
            ChessPiece(type: .rook, color: .black),
            ChessPiece(type: .knight, color: .black),
            ChessPiece(type: .bishop, color: .black),
            ChessPiece(type: .queen, color: .black),
            ChessPiece(type: .king, color: .black),
            ChessPiece(type: .bishop, color: .black),
            ChessPiece(type: .knight, color: .black),
            ChessPiece(type: .rook, color: .black)
        ]

        for i in 0..<8 {
            board[6][i] = ChessPiece(type: .pawn, color: .black)
        }
    }

    func startTimer() {
        gameTimer?.invalidate()
        gameTimeRemaining = 300

        gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.gameTimeRemaining -= 1
            if self.gameTimeRemaining <= 0 {
                self.endGame()
            }
        }
    }

    func endGame() {
        gameTimer?.invalidate()
        print("Temps écoulé ! Partie terminée.")
    }

    func selectPiece(at row: Int, col: Int) {
        if let piece = board[row][col], (isWhiteTurn && piece.color == .white) || (!isWhiteTurn && piece.color == .black) {
            selectedPiecePosition = (row, col)
            possibleMoves = calculatePossibleMoves(for: piece, at: row, col: col)
        } else {
            selectedPiecePosition = nil
            possibleMoves.removeAll()
        }
    }

    func movePiece(to row: Int, col: Int) {
        guard let selectedPosition = selectedPiecePosition else { return }
        let piece = board[selectedPosition.row][selectedPosition.col]

        board[selectedPosition.row][selectedPosition.col] = nil
        board[row][col] = piece
        selectedPiecePosition = nil
        possibleMoves.removeAll()

        isWhiteTurn.toggle()
    }

    func calculatePossibleMoves(for piece: ChessPiece, at row: Int, col: Int) -> [(row: Int, col: Int)] {
        var moves: [(row: Int, col: Int)] = []

        switch piece.type {
        case .pawn:
            moves.append(contentsOf: pawnMoves(for: piece, at: row, col: col))
        case .rook:
            moves.append(contentsOf: straightLineMoves(for: piece, at: row, col: col))
        case .bishop:
            moves.append(contentsOf: diagonalMoves(for: piece, at: row, col: col))
        case .queen:
            moves.append(contentsOf: straightLineMoves(for: piece, at: row, col: col))
            moves.append(contentsOf: diagonalMoves(for: piece, at: row, col: col))
        case .king:
            moves.append(contentsOf: kingMoves(for: piece, at: row, col: col))
        case .knight:
            moves.append(contentsOf: knightMoves(for: piece, at: row, col: col))
        }


        return moves.filter { isValidMove(for: piece, to: $0.row, col: $0.col) }
    }


    func pawnMoves(for piece: ChessPiece, at row: Int, col: Int) -> [(row: Int, col: Int)] {
        var moves: [(row: Int, col: Int)] = []
        let direction = piece.color == .white ? 1 : -1
        let startRow = piece.color == .white ? 1 : 6

        if board[row + direction][col] == nil {
            moves.append((row + direction, col))


            if row == startRow && board[row + 2 * direction][col] == nil {
                moves.append((row + 2 * direction, col))
            }
        }

        if col > 0, let targetPiece = board[row + direction][col - 1], targetPiece.color != piece.color {
            moves.append((row + direction, col - 1))
        }
        if col < 7, let targetPiece = board[row + direction][col + 1], targetPiece.color != piece.color {
            moves.append((row + direction, col + 1))
        }

        return moves
    }

    func straightLineMoves(for piece: ChessPiece, at row: Int, col: Int) -> [(row: Int, col: Int)] {
        var moves: [(row: Int, col: Int)] = []

        let directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]

        for direction in directions {
            for i in 1..<8 {
                let newRow = row + i * direction.0
                let newCol = col + i * direction.1
                if newRow < 0 || newRow >= 8 || newCol < 0 || newCol >= 8 { break }

                if let targetPiece = board[newRow][newCol] {
                    if targetPiece.color != piece.color {
                        moves.append((newRow, newCol))
                    }
                    break
                }
                moves.append((newRow, newCol))
            }
        }

        return moves
    }

    func diagonalMoves(for piece: ChessPiece, at row: Int, col: Int) -> [(row: Int, col: Int)] {
        var moves: [(row: Int, col: Int)] = []

        // Directions : diagonales
        let directions = [(1, 1), (1, -1), (-1, 1), (-1, -1)]

        for direction in directions {
            for i in 1..<8 {
                let newRow = row + i * direction.0
                let newCol = col + i * direction.1
                if newRow < 0 || newRow >= 8 || newCol < 0 || newCol >= 8 { break }

                if let targetPiece = board[newRow][newCol] {
                    if targetPiece.color != piece.color {
                        moves.append((newRow, newCol))
                    }
                    break
                }
                moves.append((newRow, newCol))
            }
        }

        return moves
    }

    func kingMoves(for piece: ChessPiece, at row: Int, col: Int) -> [(row: Int, col: Int)] {
        var moves: [(row: Int, col: Int)] = []

        let directions = [(1, 0), (-1, 0), (0, 1), (0, -1), (1, 1), (1, -1), (-1, 1), (-1, -1)]

        for direction in directions {
            let newRow = row + direction.0
            let newCol = col + direction.1

            if newRow >= 0 && newRow < 8 && newCol >= 0 && newCol < 8 {
                if let targetPiece = board[newRow][newCol] {
                    if targetPiece.color != piece.color {
                        moves.append((newRow, newCol))
                    }
                } else {
                    moves.append((newRow, newCol))
                }
            }
        }

        return moves
    }

    func knightMoves(for piece: ChessPiece, at row: Int, col: Int) -> [(row: Int, col: Int)] {
        var moves: [(row: Int, col: Int)] = []

        // Mouvements en L
        let knightMoves = [
            (2, 1), (2, -1), (-2, 1), (-2, -1),
            (1, 2), (1, -2), (-1, 2), (-1, -2)
        ]

        for move in knightMoves {
            let newRow = row + move.0
            let newCol = col + move.1

            if newRow >= 0 && newRow < 8 && newCol >= 0 && newCol < 8 {
                if let targetPiece = board[newRow][newCol] {
                    if targetPiece.color != piece.color {
                        moves.append((newRow, newCol))
                    }
                } else {
                    moves.append((newRow, newCol))
                }
            }
        }

        return moves
    }

    func isValidMove(for piece: ChessPiece, to row: Int, col: Int) -> Bool {
        if row < 0 || row >= 8 || col < 0 || col >= 8 { return false }
        if let targetPiece = board[row][col], targetPiece.color == piece.color {
            return false
        }
        return true
    }
}
