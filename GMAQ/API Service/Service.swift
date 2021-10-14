//
//  Service.swift
//  GMAQ
//
//  Created by Allan Rosa on 12/08/21.
//

import Foundation

// MARK: - Service
struct OpentdbAPIService {
	
	static let shared = OpentdbAPIService()
	
	let apiURL = "https://opentdb.com/api.php?encode=base64"
	
	func createQuiz(numberOfQuestions: Int, category: QuestionCategory, difficulty: QuestionDifficulty, completion: @escaping (Quiz) -> ()) {

		var url = apiURL + "&amount=\(numberOfQuestions)"
		url += "&category=\(category.rawValue + 9)" // reason for +9: General Knowledge is id 9 under the API, and category in our model starts at index 0
		
		if difficulty != .any {
			url += "&difficulty=\(difficulty.description)"
		}
		
		fetchData(urlString: url) { (result: Result<QuestionQuery,Error>) in
			switch result {
				case .success(let questionQuery):
					var questions: [Question] = []
					questionQuery.results.forEach { questionResult in
						questions.append(Question(questionResult))
					}
					completion(Quiz(from: questions))
					
				case .failure(let err):
					print("--- Failed to fetch data ---")
					print(err.localizedDescription)
					return
			}
		}
	}
}

// MARK: - fetchData
/// Fetches and decodes JSON data from a given *urlString*, returning a Swift5 Result object
private func fetchData<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> ()) {
	
	guard let url = URL(string: urlString) else { return }
	
	URLSession.shared.dataTask(with: url) { (data, resp, err) in
		if let err = err {
			completion(.failure(err))
			return
		}
		do {
			let decodedData = try JSONDecoder().decode(T.self, from: data!)
			completion(.success(decodedData))
		} catch let jsonError {
			completion(.failure(jsonError))
		}
	}.resume()
}
