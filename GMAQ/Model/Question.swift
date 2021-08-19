//
//  Question.swift
//  GMAQ
//
//  Created by Allan Rosa on 12/08/21.
//

import Foundation

// MARK: - Question
struct Question {
	let text: String
	let difficulty: QuestionDifficulty
	let category: QuestionCategory
	let answers: [Answer]
	var isMultiple: Bool { answers.count > 2 ? true : false }
	
	init(_ apiResult: QuestionResult) {
		text = apiResult.question.base64Decoded()!
		difficulty = QuestionDifficulty(apiResult.difficulty)
		category = QuestionCategory(apiResult.category)
		// we have to decode the strings because the api returns encoded strings
		var ans = [Answer(text: apiResult.correct_answer.base64Decoded() ?? "", isCorrect: true)]
		apiResult.incorrect_answers.forEach { encodedString in
			let decodedString = encodedString.base64Decoded() ?? ""
			ans.append(Answer(text: decodedString, isCorrect: false))
		}
		answers = ans.shuffled() // shuffling so the answer isnt always in the first position ;)
	}
	
	init() {
		self.text = "What is Lorem Ipsum?"
		self.difficulty = .easy
		self.category = .generalKnowledge
		self.answers = [Answer(text: "Dummy Text", isCorrect: true), Answer(text: "Real Text", isCorrect: false)]
	}
}
