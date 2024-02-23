//
//  GuessGrid.swift
//  Wordle
//
//  Created by 90310013 on 2/21/24.
//

import SwiftUI

class GuessGridViewModel: ObservableObject {
  @Published var guessRowsArray: [GuessRowViewModel] = Array(repeating: GuessRowViewModel(word: []), count: 6)
  
//  init() {}

  func display() -> some View {
    VStack {
      ForEach(0..<6) {index in
        self.guessRowsArray[index].displayedWord()
      }
    }
  }

  func submit() {}
}

struct GuessGridView: View {
  @ObservedObject var viewModel: GuessGridViewModel
  
  init(viewModel: GuessGridViewModel) {
    self.viewModel = viewModel
    //    self.word = word
  }
  
  var body: some View {
    viewModel.display()
  }
}

extension GuessGridView {
  static func `default`() -> GuessGridView {
    let viewModel = GuessGridViewModel()
    return GuessGridView(viewModel: viewModel)
  }
}

struct GuessGridView_Previews: PreviewProvider {
  static var previews: some View {
    GuessGridView.default()
  }
}
