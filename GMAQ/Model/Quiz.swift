//
//  Quiz.swift
//  GMAQ
//
//  Created by Allan Rosa on 17/08/21.
//

import Foundation

struct Quiz {
	let questions: [Question]
	var score: Int = 0
	var currentQuestionIndex: Int = 0 {
		didSet {
			if currentQuestionIndex > questions.count {
				print("Finished Quiz. Score = \(score)")
			}
		}
	}
	var currentQuestion: Question {
		if questions.count > 0 && currentQuestionIndex < questions.count {
			return questions[currentQuestionIndex]
		}
		else {
			print("< Empty Question >")
			return Question()
		}
	}
	
	mutating func analyzeAnswer(_ answer: Answer) -> Bool{
		currentQuestionIndex += 1
		if answer.isCorrect {
			self.score += 1
			return true
		}
		else {
			self.score -= 1 // >:)
			return false
		}
	}
}
