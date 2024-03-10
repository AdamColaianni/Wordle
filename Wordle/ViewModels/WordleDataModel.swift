//
//  WordleDataModel.swift
//  Wordle
//
//  Created by 90310013 on 2/26/24.
//

import SwiftUI

class WordleDataModel: ObservableObject {
  @Published var guesses: [Guess] = Array(repeatElement(Guess(), count: 6))
  @Published var alertText: String?
  @Published var greenedKeysList: [String] = []
  @Published var yellowedKeysList: [String] = []
  @Published var grayedKeysList: [String] = []
  
  var typedWord: [String] = []
  var index: Int = 0
  var selectedGuessWord: String = ""
  var inPlay: Bool = true
  
  init() {
    newGame()
  }
  
  func newGame() {
    typedWord = []
    self.index = 0
    selectedGuessWord = WordModel.getNewWord()
    print(selectedGuessWord)
    greenedKeysList.removeAll()
    yellowedKeysList.removeAll()
    grayedKeysList.removeAll()
    inPlay = true
    for index in 0..<6 {
      guesses[index].reset()
    }
  }
  
  func submit() {
    if !inPlay {
      showAlert(with: "Start a new game.")
      return
    }
    
    if !(typedWord.count == 5) {
      showAlert(with: "Enter a full word")
      return
    }
    
    if !WordModel.isWordAllowed(typedWord.joined()) {
      showAlert(with: "Not a valid word.")
      return
    }
    
    if typedWord.joined() == selectedGuessWord {
      inPlay = false
    }
    
    setColors()
    guesses[index].submitted = true
    self.typedWord = []
    
    if self.index < 5 {
      self.index += 1
    } else {
      inPlay = false
      showAlert(with: "Game over, the word was \(selectedGuessWord)")
    }
  }
  
  func setColors() {
    var rowColors: [Color] = [.gray, .gray, .gray, .gray, .gray]
    var typedWordCopy: [String] = typedWord
    var selectedWordCopy: [String] = selectedGuessWord.map { String($0) }
    
    for (index, letter) in selectedWordCopy.enumerated() {
      if String(letter) == String(typedWordCopy[index]) {
        greenedKeysList.append(String(letter))
        rowColors[index] = .green
        typedWordCopy[index] = ""
        selectedWordCopy[index] = ""
      }
    }
    
    for (index, letter) in typedWordCopy.enumerated() {
      if (letter != "") && (selectedWordCopy.contains(String(letter))) {
        yellowedKeysList.append(String(letter))
        rowColors[index] = .yellow
        typedWordCopy[index] = ""
        if let foundIndex = selectedWordCopy.firstIndex(of: letter) {
          selectedWordCopy[foundIndex] = ""
        }
      }
    }

    for letter in typedWordCopy {
      if String(letter) != "" {
        grayedKeysList.append(String(letter))
      }
    }
    
    guesses[self.index].colors = rowColors
  }
  
  func updateRows() {
    guesses[self.index].word = typedWord.joined(separator: "")
  }
  
  func pressedKey(letter: String) {
    if !inPlay {
      return
    }
    
    if typedWord.count < 5 {
      typedWord.append(letter)
    }
    updateRows()
  }
  
  func pressedBackspace() {
    if !inPlay {
      return
    }
    
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
