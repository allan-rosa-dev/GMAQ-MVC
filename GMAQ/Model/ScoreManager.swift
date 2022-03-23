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
	private(set) var scoreboards: [QuestionCategory: Scoreboard] = [:]
	
	// MARK: - Init
	private init(){}
	
	// MARK: - Methods
	func highScoreCutoff(for category: QuestionCategory) -> Int {
		guard let scoreboard = scoreboards[category] else {
			preload(category);
			return highScoreCutoff(for: category) }
		return scoreboard.scores.last?.score ?? 0
	}
	
	func addRecord(score: Int, username: String, to category: QuestionCategory){
		// a scoreboard for said category already exists
		if let scoreboard = scoreboards[category] {
			let newScore = ScoreRecord(score: score, username: username)
			scoreboard.add(newScore)
		}
		// scoreboard doesnt exist yet
		else {
			let score = ScoreRecord(score: score, username: username)
			let scoreboard = Scoreboard(category: category.description, scores: [score])
			
			scoreboards[category] = scoreboard
		}
	}
	
	func clear(category: QuestionCategory){
		scoreboards[category]?.scores = []
	}
	
	private func preload(_ category: QuestionCategory){
		if let userDocumentsPath = FileManager.default.urls(for: .documentDirectory,
															 in: .userDomainMask).first {
			let fileName = generateFileName(for: category)
			let fileUrl = userDocumentsPath.appendingPathComponent(fileName)
			do {
				let data = try Data(contentsOf: fileUrl)
				let scoreboard = try JSONDecoder().decode(Scoreboard.self, from: data)
				scoreboards[category] = scoreboard
			}
			catch CocoaError.fileReadNoSuchFile {
				// print("Cant read file! Creating new scoreboard for category: \(category)")
				scoreboards[category] = Scoreboard(category: category.description, scores: [])
				save(category: category)
			}
			catch {
				print("Failed to load object data: \(error)")
			}
		} else {
			print("Error creating path! Creating new scoreboard entry for \(category)")
			scoreboards[category] = Scoreboard(category: category.description, scores: [])
		}
	}
	
	func load(category: QuestionCategory){
		guard let scoreboard = scoreboards[category] else { preload(category); return }
		guard !scoreboard.scores.isEmpty else { preload(category); return }
		print("Category \(category.description) is loaded:")
		print(scoreboard.scores)
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
		let categoryName = category.description.replacingOccurrences(of: " ", with: "")
		return filePrefix + categoryName + fileExt
	}
	
}
