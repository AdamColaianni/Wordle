//
//  GuessRow.swift
//  Wordle
//
//  Created by 90310013 on 2/18/24.
//

import SwiftUI

class GuessRowViewModel: ObservableObject {
  @Published var squish: Bool = false
  @Published var fill: Bool = false
  @Published var colors: [Color] = Array(repeating: .black, count: 5)
  @Published var word: [String]
  
  init(word: [String]) {
    self.word = word
  }

  func animate(colors: [Color]) {
    withAnimation(.easeInOut(duration: 0.25)) {
      self.squish.toggle()
    } completion: {
      self.colors = colors
      self.fill.toggle()
      withAnimation(.easeInOut(duration: 0.25)) {
        self.squish.toggle()
      }
    }
  }
  
  func reset() {
    animate(colors: Array(repeating: .black, count: 5))
  }

  func displayedWord() -> some View {
    HStack(spacing: 10) {
      ForEach(0..<5) { index in
        Image(systemName: index < self.word.count ? String(self.word[index]) + ".square" + (self.fill ? ".fill" : "") : "square")
          .resizable()
          .frame(width: 60.0, height: 60.0)
          .foregroundColor(self.colors[index])
          .scaleEffect(x: 1, y: self.squish ? 0.0 : 1.0)
      }
    }
  }
}

struct GuessRowView: View {
  @ObservedObject var viewModel: GuessRowViewModel
//  @State var word: [String]

  init(viewModel: GuessRowViewModel) {
    self.viewModel = viewModel
//    self.word = word
  }

  var body: some View {
    VStack {
      viewModel.displayedWord()
    }
  }
}

extension GuessRowView {
  static func `default`() -> GuessRowView {
    let viewModel = GuessRowViewModel(word: [])
    return GuessRowView(viewModel: viewModel)
  }
}

struct GuessRowView_Previews: PreviewProvider {
  static var previews: some View {
    GuessRowView.default()
  }
}
