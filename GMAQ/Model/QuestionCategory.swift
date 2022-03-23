//
//  QuestionCategory.swift
//  GMAQ
//
//  Created by Allan Rosa on 12/08/21.
//

import Foundation

// MARK: - QuestionCategory
enum QuestionCategory: Int, CaseIterable, CustomStringConvertible {
	case generalKnowledge
	case books
	case film
	case music
	case musicalsAndTheatres
	case television
	case videoGames
	case boardGames
	case scienceAndNature
	case computers
	case mathematics
	case mythology
	case sports
	case geography
	case history
	case politics
	case art
	case celebrities
	case animals
	case vehicles
	case comics
	case gadgets
	case animeAndManga
	case cartoonAndAnimations
	case any
	
	init(_ value: String){
		let subString = value.split(separator: ":")
		var newValue = value
		if subString.count > 1 {
			newValue = subString[1].description
			newValue.removeFirst() // removes the leading whitespace after ":"
		}
		switch newValue {
			case "General Knowledge": self = .generalKnowledge
			case "Books": self = .books
			case "Film": self = .film
			case "Music": self = .music
			case "Musicals & Theatres": self = .musicalsAndTheatres
			case "Television": self = .television
			case "Video Games": self = .videoGames
			case "Board Games": self = .boardGames
			case "Science & Nature": self = .scienceAndNature
			case "Computers": self = .computers
			case "Mathematics": self = .mathematics
			case "Mythology": self = .mythology
			case "Sports": self = .sports
			case "Geography": self = .geography
			case "History": self = .history
			case "Politics": self = .politics
			case "Art": self = .art
			case "Celebrities": self = .celebrities
			case "Animals": self = .animals
			case "Vehicles": self = .vehicles
			case "Comics": self = .comics
			case "Gadgets": self = .gadgets
			case "Japanese Anime & Manga": self = .animeAndManga
			case "Cartoon & Animations": self = .cartoonAndAnimations
			default:
				print("Error initializing \(QuestionCategory.Type.self) with \(value)")
				self = .any
		}
	}
	
	var description: String {
		switch self {
			case .generalKnowledge: return "General Knowledge"
			case .books: return "Books"
			case .film: return "Film"
			case .music: return "Music"
			case .musicalsAndTheatres: return "Musicals & Theatres"
			case .television: return "Television"
			case .videoGames: return "Video Games"
			case .boardGames: return "Board Games"
			case .scienceAndNature: return "Science & Nature"
			case .computers: return "Computers"
			case .mathematics: return "Mathematics"
			case .mythology: return "Mythology"
			case .sports: return "Sports"
			case .geography: return "Geography"
			case .history: return "History"
			case .politics: return "Politics"
			case .art: return "Art"
			case .celebrities: return "Celebrities"
			case .animals: return "Animals"
			case .vehicles: return "Vehicles"
			case .comics: return "Comics"
			case .gadgets: return "Gadgets"
			case .animeAndManga: return "Japanese Anime & Manga"
			case .cartoonAndAnimations: return "Cartoon & Animations"
			case .any: return "Any Category"
		}
	}
	
}
