//
//  HighScoreViewController.swift
//  GMAQ
//
//  Created by Allan Rosa on 12/08/21.
//

import UIKit

class HighScoreViewController: UIViewController {

	var scoreboard = Scoreboard(category: QuestionCategory.animeAndManga.description,
				   scores: [ScoreRecord(score: 998, username: "EL POGGER"),
							ScoreRecord(score: 777, username: "Dood"),
							ScoreRecord(score: 10, username: "XxX_ShAd0wN_0F_DarKne55_XxX")])
	var selectedCategory = QuestionCategory.animeAndManga
	let pickerView = UIPickerView()
	
	@IBOutlet weak var categoryTextField: UITextField!
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
        super.viewDidLoad()

		pickerView.delegate = self
		pickerView.dataSource = self

		categoryTextField.delegate = self
		categoryTextField.clearsOnBeginEditing = true
		categoryTextField.allowsEditingTextAttributes = false
		categoryTextField.inputView = pickerView
		categoryTextField.text = QuestionCategory.generalKnowledge.description
		
		navigationController?.isNavigationBarHidden = false
		configureTableView()
    }
    
	fileprivate func configureTableView(){
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(HighScoreCell.self, forCellReuseIdentifier: String(describing: HighScoreCell.self))
		tableView.register(HighScoreHeader.self, forHeaderFooterViewReuseIdentifier: String(describing: HighScoreHeader.self))
		
		updateCategory()
		
		if #available(iOS 15.0, *) { // Remove the top padding above the header
			tableView.sectionHeaderTopPadding = 0
		} else {
			// Fallback on earlier versions
		}
	}
	
	fileprivate func updateCategory(){
		let currentCategory = QuestionCategory(categoryTextField.text!)
		ScoreManager.shared.load(category: currentCategory)
		guard let unwrappedScoreboard = ScoreManager.shared.scoreboards[currentCategory] else { return }
		scoreboard = unwrappedScoreboard
		tableView.reloadData()
	}
}

//MARK: - TableViewDelegate & DataSource
extension HighScoreViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return scoreboard.scores.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HighScoreCell.self)) as? HighScoreCell else { return UITableViewCell() }
		cell.configureView(withScoreRecord: scoreboard.scores[indexPath.row])
		return cell
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: HighScoreHeader.self)) as? HighScoreHeader else { return UITableViewHeaderFooterView() }
		return header
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 50
	}
}

//MARK: - PickerView
extension HighScoreViewController: UIPickerViewDelegate, UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1 // single column
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return QuestionCategory.allCases.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return QuestionCategory.allCases[row].description
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		categoryTextField.text = QuestionCategory.allCases[row].description
		categoryTextField.resignFirstResponder()
	}
}

//MARK: - UITextFieldDelegate
extension HighScoreViewController: UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		textField.text = ""
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		updateCategory()
		textField.resignFirstResponder()
	}
}
