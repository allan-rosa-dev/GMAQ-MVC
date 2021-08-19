//
//  QuestionDifficulty.swift
//  GMAQ
//
//  Created by Allan Rosa on 12/08/21.
//

import Foundation

// MARK: - QuestionDifficulty
enum QuestionDifficulty: Int, CaseIterable, CustomStringConvertible {
	
	case easy
	case medium
	case hard
	case none
	
	init(_ value: String){
		switch value.lowercased() {
			case "easy": self = .easy
			case "medium": self = .medium
			case "hard": self = .hard
			default: self = .none
		}
	}
	
	var description: String {
		switch self {
			case .easy: return "Easy"
			case .medium: return "Medium"
			case .hard: return "Hard"
			case .none: return ""
		}
	}
}
