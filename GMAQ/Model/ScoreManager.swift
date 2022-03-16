//
//  ScoreManager.swift
//  GMAQ
//
//  Created by Allan Rosa on 01/02/22.
//

import Foundation

class ScoreManager {
	// MARK: - Properties
	static let shared = ScoreManager()
	private var scoreboards: [QuestionCategory: Scoreboard] = [:]
	
	// MARK: - Init
	private init(){}
	
	// MARK: - Methods
	func addRecord(score: Int, username: String, to category: QuestionCategory){
		// a scoreboard for said category already exists
		if let scoreboard = scoreboards[category] {
			
		}
		// scoreboard doesnt exist yet
		else {
			let score = ScoreRecord(score: score, username: username)
			let scoreboard = Scoreboard(category: category.description, scores: [score])
			
			scoreboards[category] = scoreboard
		}
	}
	
	func load(category: QuestionCategory){
		if let userDocumentsPath = FileManager.default.urls(for: .documentDirectory,
															 in: .userDomainMask).first {
			let fileName = generateFileName(for: category)
			let fileUrl = userDocumentsPath.appendingPathComponent(fileName)
			print("Loading file [\(fileName)] in [\(fileUrl)]")
			do {
				let data = try Data(contentsOf: fileUrl)
				let scoreboard = try JSONDecoder().decode(Scoreboard.self, from: data)
				
				scoreboards[category] = scoreboard
			}
			catch {
				print("Failed to load object data: \(error)")
			}
		}
	}
	
	func save(category: QuestionCategory){
		do {
			let jsonScoreData = try JSONEncoder().encode(scoreboards[category])
			
			print(jsonScoreData)
			
			if let userDocumentsPath = FileManager.default.urls(for: .documentDirectory,
																   in: .userDomainMask).first {

				let fileName = generateFileName(for: category)
				let destinationUrl = userDocumentsPath.appendingPathComponent(fileName)
				print("Saving file [\(fileName)] to:")
				print("\(destinationUrl)")
				
				try jsonScoreData.write(to: destinationUrl, options: .atomic)
			}
		}
		catch {
			print("Error while saving: ")
			debugPrint(error)
			print("-------")
		}
	}
	
	private func generateFileName(for category: QuestionCategory) -> String {
		let filePrefix = "highscore_"
		let fileExt = ".json"
		return filePrefix + category.description + fileExt
	}
	
}
