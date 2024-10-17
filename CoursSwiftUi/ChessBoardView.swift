//
//  ChessBoardView.swift
//  CoursSwiftUi
//
//  Created by Enzo Cosson on 17/10/2024.
//

import SwiftUI

struct ChessBoardView: View {
    @ObservedObject var chessBoard = ChessBoard()

    var body: some View {
        VStack {
            Text("Temps restant : \(chessBoard.gameTimeRemaining) secondes")
                .font(.title)
                .foregroundColor(.red)
                .padding()

            Text(chessBoard.isWhiteTurn ? "Tour des Blancs" : "Tour des Noirs")
                .font(.headline)
                .foregroundColor(.blue)

            ForEach(0..<8, id: \.self) { row in
                HStack {
                    ForEach(0..<8, id: \.self) { col in
                        ChessSquareView(chessBoard: chessBoard, row: row, col: col)
                    }
                }
            }
        }
    }
}

struct ChessSquareView: View {
    @ObservedObject var chessBoard: ChessBoard
    var row: Int
    var col: Int

    var body: some View {
        ZStack {
            Rectangle()
                .fill((row + col) % 2 == 0 ? Color.gray : Color.white)
                .frame(width: 50, height: 50)

            if let piece = chessBoard.board[row][col] {
                Text(piece.symbol)  // Utilise la propriété 'symbol'
                    .font(.largeTitle)
                    .foregroundColor(piece.color == .white ? .black : .red)
                    .onTapGesture {
                        chessBoard.selectPiece(at: row, col: col)
                    }
            }

            if chessBoard.possibleMoves.contains(where: { $0.row == row && $0.col == col }) {
                Rectangle()
                    .fill(Color.orange.opacity(0.5))
                    .frame(width: 50, height: 50)
                    .onTapGesture {
                        chessBoard.movePiece(to: row, col: col)
                    }
            }
        }
    }
}


struct ChessBoardView_Previews: PreviewProvider {
    static var previews: some View {
        ChessBoardView()
    }
}
