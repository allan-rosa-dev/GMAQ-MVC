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
		
		navigationController?.isNavigationBarHidden = false
		
		initializeHideKeyboard()
		
		categoryPickerView.delegate = self
		categoryPickerView.dataSource = self
		quizSizeTextField.delegate = self
		
		categoryTextField.inputView = categoryPickerView
		
		// load last time's config from UserDefaults
		let lastCategorySelected = QuestionCategory.animeAndManga
		let lastQuizSize = 10
		
		quizSizeTextField.smartInsertDeleteType = .no
		categoryPickerView.selectRow(lastCategorySelected.rawValue, inComponent: 0, animated: false)
		categoryTextField.text = lastCategorySelected.description
		quizSizeTextField.text = String(lastQuizSize)
		quizSizeSlider.value = Float(lastQuizSize)
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
	
	@IBAction func textFieldValueChanged(_ sender: UITextField) {
		guard let text = sender.text else { return }
		guard let value = Float(text) else { return }
		quizSizeSlider.setValue(value, animated: true)
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
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let quizSizeRange = 1...50
		guard let text = textField.text else { return false }
		let newText = (text as NSString).replacingCharacters(in: range, with: string) as String
		if let inputValue = Int(newText) {
			return (quizSizeRange.contains(inputValue)) ? true : false
		}
		return false
	}
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		textField.text = ""
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		prepareForEndEditing(textField)
		textField.resignFirstResponder()
		return true
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		prepareForEndEditing(textField)
		textField.resignFirstResponder()
	}
	
	//MARK: - Helper functions
	func prepareForEndEditing(_ textField: UITextField){
		guard let text = textField.text else {
			textField.text = "10"
			return
		}
		guard let value = Float(text) else {
			textField.text = "10"
			return
		}
		quizSizeSlider.setValue(value, animated: true)
	}
}
