//
//  ContentView.swift
//  Memorize
//
//  Created by Flaizz on 07/05/24.
//

import SwiftUI

struct ContentView: View {
    let animalsTheme = Theme(name: "Animals",
                             icon: "cat.fill",
                             color: .cyan,
                             emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵"])
    let appleProductsTheme = Theme(name: "Apple products",
                                   icon: "apple.logo", 
                                   color: .gray,
                                   emojis: ["🖥️", "🖱️", "💻", "📱", "🎧", "⌨️", "⌚️"])
    let sportsTheme = Theme(name: "Sports",
                            icon: "figure.baseball",
                            color: .red,
                            emojis: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🥏", "🎱", "🏓", "🥊"])
    
    @State var emojis = [String]()
    @State var cardAccentColor = Color.clear
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            themeSelectorView
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: cardWidth, maximum: cardWidth + 10.0))]) {
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3,
                                 contentMode: .fit)
            }
        }
        .foregroundStyle(cardAccentColor)
    }
    
    var themeSelectorView: some View {
        let themes = [animalsTheme, appleProductsTheme, sportsTheme]
        
        return HStack(spacing: 40) {
            ForEach(0..<themes.count, id: \.self) { index in
                themeButton(for: themes[index])
            }
        }
    }
    
    func themeButton(for theme: Theme) -> some View{
        Button(action: {
            let numberOfPairs = Int.random(in: 2..<theme.emojis.count)
            let newEmojis = theme.emojis.shuffled().prefix(numberOfPairs)
            emojis = (newEmojis + newEmojis).shuffled()
            cardAccentColor = theme.color
        }, label: {
            VStack {
                Image(systemName: theme.icon)
                    .font(.title)
                Text(theme.name)
                    .font(.caption)
            }
        })
    }
    
    var cardWidth: CGFloat {
        let cardsPerRow = sqrt(Double(emojis.count))
        if cardsPerRow == 2.0 {
            return 140.0
        } else if cardsPerRow <= 3.0 {
            return 122.5
        } else if cardsPerRow <= 4.0 {
            return 105.0
        } else if cardsPerRow <= 5.0 {
            return 87.5
        } else {
            return 70.0
        }
    }
}

struct CardView: View {
    @State var isFaceUp: Bool = false
    let content: String
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            
            Group {
                base.foregroundStyle(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content)
                    .font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            
            base.opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

struct Theme {
    let name: String
    let icon: String
    let color: Color
    let emojis: [String]
}

#Preview {
    ContentView()
}
