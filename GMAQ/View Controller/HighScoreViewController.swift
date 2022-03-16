//
//  HighScoreViewController.swift
//  GMAQ
//
//  Created by Allan Rosa on 12/08/21.
//

import UIKit

class HighScoreViewController: UIViewController {

	let scoreboard = Scoreboard(category: QuestionCategory.animeAndManga.description,
				   scores: [ScoreRecord(score: 999, username: "AAA"),
							ScoreRecord(score: 777, username: "Dood"),
							ScoreRecord(score: 10, username: "XxX_ShAd0wN_0F_DarKne55_XxX")]
				  )
	/*
	let scoreboard = Scoreboard(category: QuestionCategory.boardGames.description,
				   scores: [ScoreRecord(score: 9999999, username: "Chu"),
							ScoreRecord(score: 20, username: "Noob"),
							ScoreRecord(score: 3, username: "G4m3r Gr1LL UwU"),
						   ScoreRecord(score: 1, username: "Po_GG_eR")]
				  )
	 */
	
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
        super.viewDidLoad()

		navigationController?.isNavigationBarHidden = false
		configureTableView()
    }
    
	fileprivate func configureTableView(){
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(HighScoreCell.self, forCellReuseIdentifier: String(describing: HighScoreCell.self))
		tableView.register(HighScoreHeader.self, forHeaderFooterViewReuseIdentifier: String(describing: HighScoreHeader.self))
		
		if #available(iOS 15.0, *) { // Remove the top padding above the header
			tableView.sectionHeaderTopPadding = 0
		} else {
			// Fallback on earlier versions
		}
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
