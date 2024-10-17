import Foundation

enum PieceType {
    case pawn, rook, knight, bishop, queen, king
}

enum PieceColor {
    case white, black
}

class ChessPiece: Identifiable {
    let id = UUID()
    var type: PieceType
    var color: PieceColor
    
    init(type: PieceType, color: PieceColor) {
        self.type = type
        self.color = color
    }
    

    var symbol: String {
        switch (color, type) {
        case (.white, .pawn): return "♙"
        case (.white, .rook): return "♖"
        case (.white, .knight): return "♘"
        case (.white, .bishop): return "♗"
        case (.white, .queen): return "♕"
        case (.white, .king): return "♔"
        case (.black, .pawn): return "♟︎"
        case (.black, .rook): return "♜"
        case (.black, .knight): return "♞"
        case (.black, .bishop): return "♝"
        case (.black, .queen): return "♛"
        case (.black, .king): return "♚"
        }
    }
}
