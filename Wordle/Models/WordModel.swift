//
//  Word.swift
//  Wordle
//
//  Created by 90310013 on 3/3/24.
//

import Foundation

class WordModel {
  static func reset() -> String {
    if let filePath = Bundle.main.path(forResource: "answers", ofType: "txt"), let fileContents = try? String(contentsOfFile: filePath) {
      let lines = fileContents.split(separator: "\n")
      return lines.randomElement()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    } else {
      return ""
    }
  }
  
  static func isStringContained(_ searchString: String, inResourceFileNamed fileName: String, withExtension fileExtension: String) -> Bool {
    guard let filePath = Bundle.main.path(forResource: fileName, ofType: fileExtension),
          let fileContents = try? String(contentsOfFile: filePath) else {
      return false
    }
    return fileContents.contains(searchString)
  }
}
