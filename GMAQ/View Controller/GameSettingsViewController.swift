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
	
	var isRequestingQuiz: Bool = false
	
	var categoryPickerView = UIPickerView()
	var quiz = Quiz(from: [])
	private var quizSize: Int = 1
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		navigationController?.isNavigationBarHidden = false
		initializeHideKeyboard()
		configureUI()
    }
	
	func configureUI(){
		categoryPickerView.delegate = self
		categoryPickerView.dataSource = self
		quizSizeTextField.delegate = self
		// load last time's config from UserDefaults - default to generalKnowledge / 10 in case of error/first launch
		let lastCategorySelected: QuestionCategory
		if let quizDefaultCategory = UserDefaults.standard.string(forKey: K.App.Defaults.lastQuizCategory) {
			lastCategorySelected = QuestionCategory(quizDefaultCategory)
		}
		else {
			lastCategorySelected = QuestionCategory.generalKnowledge
		}
		
		let quizMinSize = 5
		let quizMaxSize = 50
		let quizRange = quizMinSize...quizMaxSize
		let quizDefaultSize = UserDefaults.standard.integer(forKey: K.App.Defaults.lastQuizSize)
		let lastQuizSize = quizRange.contains(quizDefaultSize) ? quizDefaultSize : quizMinSize
		quizSize = lastQuizSize
		
		categoryTextField.text = lastCategorySelected.description
		categoryTextField.inputView = categoryPickerView
		categoryPickerView.selectRow(lastCategorySelected.rawValue, inComponent: 0, animated: false)
		
		quizSizeSlider.minimumValue = Float(quizMinSize)
		quizSizeSlider.maximumValue = Float(quizMaxSize)
		quizSizeSlider.value = Float(lastQuizSize)
		quizSizeTextField.text = String(lastQuizSize)
	}
	
	@IBAction func startQuizButtonPressed(_ sender: Any) {
		guard let quizCategory = QuestionCategory(rawValue: categoryPickerView.selectedRow(inComponent: 0)) else { return }
		guard !isRequestingQuiz else { return }
		isRequestingQuiz = true
		 let quizDifficulty = QuestionDifficulty.any
		// print("Asking API for Quiz: \(quizSize) questions of \(quizCategory.description).")
		
		OpentdbAPIService.shared.createQuiz(numberOfQuestions: quizSize,
											category: quizCategory,
											difficulty: quizDifficulty) { quiz in
			DispatchQueue.main.async {
				self.quiz = quiz
				self.isRequestingQuiz = false
				self.performSegue(withIdentifier: K.App.View.Segue.gameSettingsToGame, sender: self)
			}
		}
		
		/* using a local json */
//		if let path = Bundle.main.path(forResource: "SampleQuiz", ofType: "json") {
//			do {
//				let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//				let questionQuery = try JSONDecoder().decode(QuestionQuery.self, from: data)
//				var questions: [Question] = []
//				questionQuery.results.forEach { questionResult in
//					questions.append(Question(questionResult))
//				}
//				quiz = Quiz(from: questions)
//				performSegue(withIdentifier: K.App.View.Segue.gameSettingsToGame, sender: self)
//
//			} catch {
//				print("error decoding question")
//			}
//		}
//		else { print("path error") }
	}
	
	
	@IBAction func quizSizeSliderValueHasChanged(_ sender: UISlider) {
		let stepIncrement: Float = 5
		let roundedValue = round(sender.value / stepIncrement) * stepIncrement
		sender.value = roundedValue
		quizSize = Int(sender.value)
		quizSizeTextField.text = String(quizSize)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		UserDefaults.standard.set(quizSize, forKey: K.App.Defaults.lastQuizSize)
		UserDefaults.standard.set(quiz.category.description, forKey: K.App.Defaults.lastQuizCategory)
		
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
	}
}

//MARK: - UITextFieldDelegate
extension GameSettingsViewController: UITextFieldDelegate {
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let minValue = Int(quizSizeSlider.minimumValue)
		let maxValue = Int(quizSizeSlider.maximumValue)
		let quizSizeRange = minValue...maxValue
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
		quizSize = Int(text) ?? quizSize
	}
}
