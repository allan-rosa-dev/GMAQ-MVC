//
//  Constants.swift
//  GMAQ
//
//  Created by Allan Rosa on 20/08/21.
//

import Foundation

struct K {
	struct App {
		struct Defaults {
			static let lastQuizCategory = QuestionCategory.animeAndManga.description
			static let lastQuizSize = 10
		}
		
		struct View {
			struct Segue {
				static let mainMenuToGameSettings = "mainMenuToGameSettings"
				static let mainMenuToHighScores = "mainMenuToHighScores"
				static let mainMenuToSettings = "mainMenuToSettings"
				static let gameSettingsToGame = "gameSettingsToGame"
				
			}
		}
		
		struct Model {
			struct Category {
				static let generalKnowledge = "General Knowledge"
				static let books = "Books"
				static let film = "Films"
				static let music = "Music"
				static let musicalsAndTheatres = "Musicals & Theatres"
				static let television = "Television"
				static let videoGames = "Video Games"
				static let boardGames = "Board Games"
				static let scienceAndNature = "Science & Nature"
				static let computers = "Computers"
				static let mathematics = "Mathematics"
				static let mythology = "Mythology"
				static let sports = "Sports"
				static let geography = "Geography"
				static let history = "History"
				static let politics = "Politics"
				static let art = "Art"
				static let celebrities = "Celebrities"
				static let animals = "Animals"
				static let vehicles = "Vehicles"
				static let comics = "Comics"
				static let gadgets = "Gadgets"
				static let animeAndManga = "Anime & Manga"
				static let cartoonAndAnimations = "Cartoon & Animation"
				static let any = "Any Category"
			}
		}
	}
}
