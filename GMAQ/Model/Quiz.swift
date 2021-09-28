//
//  Quiz.swift
//  GMAQ
//
//  Created by Allan Rosa on 17/08/21.
//

import Foundation

protocol QuizDelegate {
	func quizDidFinish(_ quiz: Quiz)
}

class Quiz {
	let questions: [Question]
	var score: Int
	var currentQuestionIndex: Int
	var playerAnswers: [Answer]
	var delegate: QuizDelegate?
	
	var currentQuestion: Question {
		guard questions.count > 0 && currentQuestionIndex < questions.count else { return Question() }
		return questions[currentQuestionIndex]
	}
	var isOver: Bool {
		guard currentQuestionIndex >= questions.count else { return false }
		return true
	}
	
	init(from questions: [Question]){
		self.questions = questions
		self.score = 0
		self.currentQuestionIndex = 0
		self.playerAnswers = []
	}
	
	
	func updateProgress(with answer: Answer){
		playerAnswers.append(answer) // creating the backlog for the player answers to be shown on quiz breakdown
		if answer.isCorrect {
			self.score += 1
		}
		else {
			self.score -= 1
		}
		currentQuestionIndex += 1
		
		if isOver {
			delegate?.quizDidFinish(self)
		}
	}
}
