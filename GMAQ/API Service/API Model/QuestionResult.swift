//
//  QuestionResult.swift
//  GMAQ
//
//  Created by Allan Rosa on 12/08/21.
//

import Foundation

// MARK: - QuestionResult
struct QuestionResult: Decodable {
	let category, type, difficulty, question: String
	let correct_answer: String
	let incorrect_answers: [String]
}
