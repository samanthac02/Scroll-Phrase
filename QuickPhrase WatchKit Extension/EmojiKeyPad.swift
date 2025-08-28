//
//  EmojiKeyPad.swift
//  QuickPhrase WatchKit Extension
//
//  Created by Samantha Chang on 1/30/21.
//

import SwiftUI

extension Array {
    func chunks(size: Int) -> [ArraySlice<Element>] {
        var chunks: [ArraySlice<Element>] = [ArraySlice<Element>]()
        for index in stride(from: 0, to:self.count - 1, by: size) {
            var chunk = ArraySlice<Element>()
            let end = index + size
            
            if end >= self.count {
                chunk = self[index..<self.count]
            }
            else {
                chunk = self[index..<end]
            }
            
            chunks.append(chunk)
            
            if (end + 1) == self.count{
                let remainingChunk = self[end..<self.count]
                chunks.append(remainingChunk)
            }
        }
        return chunks
    }
}

struct EmojiKeyPad: View {
    let emojis: [String] = ["😊", "😂", "🤣", "😭", "😀", "😍", "😘", "😜", "🙏", "⭐️", "❤️", "👋", "👨", "👩", "👧", "🧒", "💩", "🤡", "😈", "🤠", "🐶", "🐱", "🐵", "🐔", "🐸", "🐷", "🦄", "🐙", "🌸", "⚡️", "🔥", "🍔", "🍚", "🍕", "☕️", "🍆", "🥤", "🍎", "🍑", "🍌", "🥑", "🌯", "🏝", "🏠", "🚗", "✈️", "🚲", "🚀", "🏀", "⚽️", "🏈", "⚾️", "🎼", "🎾", "🏃‍♂️", "⛳️", "🏒", "🧘", "☎️", "🛎", "🛌", "☔️", "🔑", "🚿", "⏰", "🛀"]
    @State private var sliderValue: CGFloat = 4
    
    @Binding var icon: String
    @Binding var buttonText: String
    @Binding var activeSheet: ActiveSheet?
    
    var body: some View {
        List(self.emojis.chunks(size: Int(self.sliderValue)), id: \.self) { chunk in
            ForEach(chunk, id: \.self) { emoji in
                Text(emoji).font(.title)
                    .onTapGesture {
                        icon = emoji
                        buttonText = icon
                        activeSheet = nil
                    }
            }
        }

    }
}
