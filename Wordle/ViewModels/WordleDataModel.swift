//
//  WordleDataModel.swift
//  Wordle
//
//  Created by 90310013 on 2/26/24.
//

import SwiftUI

class WordleDataModel: ObservableObject {
  @Published var guesses: [String] = ["", "", "", "", "", ""]
  var greenedKeysList: [String] = []
  var yellowedKeysList: [String] = []
  var grayedKeysList: [String] = []
  var index: Int = 0
  @Published var typedWord: [String] = []
  var selectedWord: String = ""
  @Published var alertText: String?
  
  init() {
    newGame()
  }
  
  func newGame() {
    selectedWord = WordModel.getNewWord()
  }
  
  func submit() {
    if self.index < 5 {
      self.index += 1
    }
    self.typedWord = []
  }
  
  func updateRows() {
    guesses[self.index] = typedWord.joined(separator: "")
  }
  
  func pressedKey(letter: String) {
    if typedWord.count < 5 {
      typedWord.append(letter)
    }
    updateRows()
  }
  
  func pressedBackspace() {
    if typedWord.count > 0 {
      typedWord.remove(at: typedWord.count - 1)
    }
    updateRows()
  }
  
  func showAlert(with text: String?) {
    withAnimation {
      alertText = text
    }
    withAnimation(Animation.linear(duration: 0.2).delay(3)) {
      alertText = nil
    }
  }
  
  func getColorOf(letter: String) -> Color {
    if greenedKeysList.contains(letter) {
      return Color(.green)
    } else if yellowedKeysList.contains(letter) {
      return Color(.yellow)
    } else if grayedKeysList.contains(letter) {
      return Color(.gray)
    }
    return Color(.white)
  }
}
