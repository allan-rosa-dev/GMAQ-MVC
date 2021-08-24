//
//  GameResultViewController.swift
//  GMAQ
//
//  Created by Allan Rosa on 12/08/21.
//

import UIKit

class GameResultViewController: UIViewController {

	var quiz = Quiz(questions: [])
	@IBOutlet weak var resultsLabel: UILabel!
	@IBOutlet weak var quizBreakdownTableView: UITableView!
	
	@IBOutlet weak var nameTextField: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		initializeHideKeyboard()
		
		
	
    }
	
	fileprivate func setupView(){
		
	}
	
	@IBAction func buttonClicked(_ sender: UIButton) {
		// Segue to highscores with name (from nameTextField and score)
	}
	
	private func analyzeScore(_ score: Int){
		let evaluation = score/quiz.questions.count
	}
}

//MARK: - UITableViewDelegate & DataSource
extension GameResultViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return quiz.questions.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// create cell
		return UITableViewCell()
	}
}
