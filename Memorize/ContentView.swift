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
                             emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵"])
    let appleProductsTheme = Theme(name: "Apple products",
                                   icon: "apple.logo",
                                   emojis: ["🖥️", "🖱️", "💻", "📱", "🎧", "⌨️", "⌚️"])
    let sportsTheme = Theme(name: "Sports",
                            icon: "figure.baseball",
                            emojis: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🥏", "🎱", "🏓", "🥊"])
    
    @State var emojis = [String]()
    
    var body: some View {
        VStack {
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
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3,
                                 contentMode: .fit)
            }
        }
        .foregroundStyle(.orange)
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
            let numberOfPairs = Int.random(in: 4..<theme.emojis.count)
            let newEmojis = theme.emojis.shuffled().prefix(numberOfPairs)
            emojis = (newEmojis + newEmojis).shuffled()
        }, label: {
            VStack {
                Image(systemName: theme.icon)
                    .font(.title)
                Text(theme.name)
                    .font(.caption)
            }
        })
    }
}

struct CardView: View {
    @State var isFaceUp: Bool = true
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
    let emojis: [String]
}

#Preview {
    ContentView()
}
