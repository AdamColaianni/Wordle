//
//  GuessRow.swift
//  Wordle
//
//  Created by 90310013 on 2/18/24.
//

import SwiftUI

struct GuessRowView: View {
  @Binding var guess: Guess
  @State var displayedColors: [Color] = Array(repeating: .letterbox, count: 5)
  @State var squish: Bool = false
  @State var fill: Bool = false

  func animate() {
    withAnimation(.easeInOut(duration: 0.25)) {
      self.squish.toggle()
    } completion: {
      self.displayedColors = guess.colors
      self.fill.toggle()
      withAnimation(.easeInOut(duration: 0.25)) {
        self.squish.toggle()
      }
    }
  }
  
  var body: some View {
    VStack {
      HStack(spacing: 10) {
        ForEach(0..<5) { index in
          Image(systemName: index < guess.word.count ? String(Array(guess.word)[index]) + ".square" + (self.fill ? ".fill" : "") : "square")
            .resizable()
            .frame(width: 60.0, height: 60.0)
            .foregroundColor(self.displayedColors[index])
            .scaleEffect(x: 1, y: self.squish ? 0.0 : 1.0)
        }
      }
    }
    .onChange(of: guess.submitted) {
      animate()
    }
  }
}

struct testGuessRowView_Previews: PreviewProvider {
  static var previews: some View {
    GuessRowView(guess: .constant(Guess()))
  }
}
