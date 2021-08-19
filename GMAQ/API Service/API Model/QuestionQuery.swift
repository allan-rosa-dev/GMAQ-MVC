//
//  QuestionQuery.swift
//  GMAQ
//
//  Created by Allan Rosa on 12/08/21.
//

import Foundation

// MARK: - QuestionQuery
struct QuestionQuery: Decodable {
	let response_code: Int
	let results: [QuestionResult]
}
