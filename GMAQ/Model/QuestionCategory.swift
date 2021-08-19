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
	case none
	
	init(_ value: String){
		switch value.lowercased() {
			case "generalKnowledge": self = .generalKnowledge
			case "books": self = .books
			case "film": self = .film
			case "music": self = .music
			case "musicalsAndTheatres": self = .musicalsAndTheatres
			case "television": self = .television
			case "videoGames": self = .videoGames
			case "boardGames": self = .boardGames
			case "scienceAndNature": self = .scienceAndNature
			case "computers": self = .computers
			case "mathematics": self = .mathematics
			case "mythology": self = .mythology
			case "sports": self = .sports
			case "geography": self = .geography
			case "history": self = .history
			case "politics": self = .politics
			case "art": self = .art
			case "celebrities": self = .celebrities
			case "animals": self = .animals
			case "vehicles": self = .vehicles
			case "comics": self = .comics
			case "gadgets": self = .gadgets
			case "animeAndManga": self = .animeAndManga
			case "cartoonAndAnimations": self = .cartoonAndAnimations
			default: self = .none
		}
	}
	
	var description: String {
		switch self {
			case .generalKnowledge: return "General Knowledge"
			case .books: return "Books"
			case .film: return "Films"
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
			case .animeAndManga: return "Anime & Manga"
			case .cartoonAndAnimations: return "Cartoon & Animation"
			case .none: return ""
		}
	}
	
}
