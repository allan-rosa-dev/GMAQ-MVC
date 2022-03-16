//
//  Scoreboard.swift
//  GMAQ
//
//  Created by Allan Rosa on 17/01/22.
//

import Foundation

struct Scoreboard: Codable {
	let category: String
	var scores: [ScoreRecord] // Implement a SortedArray type and make this adopt it so performance increases
	
	mutating func add(_ record: ScoreRecord){
		scores.append(record)
		scores.sort { $0.score > $1.score }
	}
}

