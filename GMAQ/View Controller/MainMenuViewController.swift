//
//  MainMenuViewController.swift
//  GMAQ
//
//  Created by Allan Rosa on 12/08/21.
//

import UIKit

class MainMenuViewController: UIViewController {

	@IBAction func buttonPressed(_ sender: UIButton) {
		let senderTag = ButtonTag(rawValue: sender.tag)
		switch senderTag {
			case .newGame:
				print(sender.titleLabel?.text?.description ?? "ng")
			case .highScores:
				print(sender.titleLabel?.text?.description ?? "hs")
			case .settings:
				print(sender.titleLabel?.text?.description ?? "st")
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
