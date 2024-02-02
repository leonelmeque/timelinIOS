import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    func capitalizeFirstLetters() -> String {
        var words = self.split(separator: " ")
        for (index, word) in words.enumerated() {
            words[index] = word.prefix(1).uppercased() + word.lowercased().dropFirst()
        }

        return words.joined(separator: " ")
    }
}
