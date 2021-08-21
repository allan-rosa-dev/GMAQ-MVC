//
//  GameSettingsViewController.swift
//  GMAQ
//
//  Created by Allan Rosa on 12/08/21.
//

import UIKit

class GameSettingsViewController: UIViewController {

	@IBOutlet weak var categoryTextField: UITextField!
	@IBOutlet weak var quizSizeTextField: UITextField!
	@IBOutlet weak var quizSizeSlider: UISlider!
	
	var categoryPickerView = UIPickerView()
	var quiz = Quiz(questions: [])
	private var quizSize = 10
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		categoryPickerView.delegate = self
		categoryPickerView.dataSource = self
		
		categoryTextField.inputView = categoryPickerView
		// load last time's config from UserDefaults
		
		categoryTextField.text = QuestionCategory.animeAndManga.description
		quizSizeTextField.text = String(quizSize)
		quizSizeSlider.value = Float(quizSize)
    }
	
	@IBAction func startQuizButtonPressed(_ sender: Any) {
		guard let quizCategory = QuestionCategory(rawValue: categoryPickerView.selectedRow(inComponent: 0)) else { return }
		let quizDifficulty = QuestionDifficulty.any
		
		print("Asking API for Quiz: \(quizSize) questions of \(quizCategory.description).")
		OpentdbAPIService.shared.createQuiz(numberOfQuestions: quizSize,
											category: quizCategory,
											difficulty: quizDifficulty) { quiz in
			DispatchQueue.main.async {
				self.quiz = quiz
				self.performSegue(withIdentifier: K.App.View.Segue.gameSettingsToGame, sender: self)
			}
		}
	}
	
	@IBAction func quizSizeSliderValueHasChanged(_ sender: UISlider) {
		quizSize = Int(sender.value)
		quizSizeTextField.text = String(quizSize)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let destinationVC = segue.destination as! GameViewController
		destinationVC.quiz = self.quiz
	}
}

//MARK: - PickerView
extension GameSettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
extension GameSettingsViewController: UITextFieldDelegate {
	func textFieldDidEndEditing(_ textField: UITextField) {
		textField.resignFirstResponder()
	}
}
