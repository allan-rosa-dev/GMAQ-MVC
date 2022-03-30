//
//  Scoreboard.swift
//  GMAQ
//
//  Created by Allan Rosa on 17/01/22.
//

import Foundation

class Scoreboard: Codable {
	let category: String
	var scores: [ScoreRecord] // Implement a SortedArray type and make this adopt it so performance increases
	
	init(category: String, scores: [ScoreRecord]){
		self.category = category
		self.scores = scores
	}
	
	// A SortedArray type would increase the performance on this method with proper implementation
	func add(_ record: ScoreRecord) {
		if scores.count == 10 {
			scores.append(record)
			scores.sort{ $0.score > $1.score }
			scores.removeLast()
		}
		else {
			scores.append(record)
			scores.sort{ $0.score > $1.score }
		}
	}
}
