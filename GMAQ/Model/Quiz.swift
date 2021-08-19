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
	var currentQuestionIndex: Int = 0
	var currentQuestion: Question {
		questions[currentQuestionIndex]
	}
	
	mutating func analyzeAnswer(_ answer: Answer){
		if answer.isCorrect {
			self.score += 1
		}
		else {
			self.score -= 1 // >:)
		}
		currentQuestionIndex += 1
		
		if currentQuestionIndex > questions.count {
			//finish quiz
		}
	}
	
	
}
