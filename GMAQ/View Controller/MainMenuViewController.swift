//
//  MainMenuViewController.swift
//  GMAQ
//
//  Created by Allan Rosa on 12/08/21.
//

import UIKit

class MainMenuViewController: UIViewController {

	@IBAction func buttonPressed(_ sender: UIButton) {
		// sender.provideVisualFeedback()
		let senderTag = ButtonTag(rawValue: sender.tag)
		switch senderTag {
			case .newGame:
				performSegue(withIdentifier: K.App.View.Segue.mainMenuToGameSettings, sender: self)
			case .highScores:
				performSegue(withIdentifier: K.App.View.Segue.mainMenuToHighScores, sender: self)
			case .settings:
				performSegue(withIdentifier: K.App.View.Segue.mainMenuToSettings, sender: self)
			case .none:
				print("Shouldnt happen")
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()		
	}
}

private enum ButtonTag: Int {
	case newGame = 0
	case highScores = 1
	case settings = 2
}
