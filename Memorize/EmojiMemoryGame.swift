//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Flaizz on 15/05/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let themes = [Theme(name: "Moon phases",
                                       emojis:  ["🌕", "🌖", "🌗", "🌘", "🌑", "🌒", "🌓", "🌔"],
                                       numberOfPairs: 6,
                                       color: .yellow),
                                 Theme(name: "Animals",
                                       emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵"],
                                       numberOfPairs: 14,
                                       color: .cyan),
                                 Theme(name: "Apple products",
                                       emojis: ["🖥️", "🖱️", "💻", "📱", "🎧", "⌨️", "⌚️"],
                                       numberOfPairs: 4,
                                       color: .gray),
                                 Theme(name: "Sports",
                                       emojis: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🥏", "🎱", "🏓", "🥊", "🥋", "🎳", "⛳️", "🥌"],
                                       numberOfPairs: 12,
                                       color: .red),
                                 Theme(name: "Weather", 
                                       emojis: ["☀️", "🌤️", "⛅️", "🌥️", "☁️", "🌦️", "🌧️", "⛈️", "🌩️", "🌨️"],
                                       numberOfPairs: 8, 
                                       color: .blue),
                                 Theme(name: "Music instruments",
                                       emojis: ["🎹", "🪇", "🥁", "🪘", "🎷", "🎺", "🪗", "🎸", "🪕", "🎻", "🪈"],
                                       numberOfPairs: 10,
                                       color: .purple)]
     
    private static func createMemoryGame(from theme: Theme) -> MemoryGame<String> {
        let shuffledEmojis = theme.emojis.shuffled()
        return MemoryGame(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            if shuffledEmojis.indices.contains(pairIndex) {
                return shuffledEmojis[pairIndex]
            } else {
                return "🚨"
            }
        }
    }
    
    private(set) var currentTheme: Theme
    @Published private var model: MemoryGame<String>
    
    init() {
        currentTheme = EmojiMemoryGame.themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(from: currentTheme)
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intents
    
    func newGame() {
        currentTheme = EmojiMemoryGame.themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(from: currentTheme)
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    struct Theme {
        let name: String
        let emojis: [String]
        let numberOfPairs: Int
        let color: Color
    }
}

