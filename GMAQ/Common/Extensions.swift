//
//  Extensions.swift
//  GMAQ
//
//  Created by Allan Rosa on 12/08/21.
//

import UIKit

// MARK: - String
extension String {
	func base64Encoded() -> String? {
		return data(using: .utf8)?.base64EncodedString()
	}
	
	func base64Decoded() -> String? {
		guard let data = Data(base64Encoded: self) else { return nil }
		return String(data: data, encoding: .utf8)
	}
}

// MARK: - UIColor
extension UIColor {
	
	enum AssetsColor {
		case red
		case green
		case blue
		case white
		case black
	}
	
	static func appColor(_ name: AssetsColor) -> UIColor? {
		switch name {
			case .red:
				return UIColor(named: "theme-color/red")
			case .green:
				return UIColor(named: "theme-color/green")
			case .blue:
				return UIColor(named: "theme-color/blue")
			case .white:
				return UIColor(named: "theme-color/white")
			case .black:
				return UIColor(named: "theme-color/black")
		}
	}
}



// MARK: - UIButton
extension UIButton {
	func configure(with answer: Answer){
		self.setTitle(answer.text, for: .normal)
		self.isHidden = false
		self.backgroundColor = UIColor.appColor(.blue)
		self.titleLabel?.tintColor = UIColor.appColor(.white)
	}
}

// MARK: - UIView
extension UIView {
	func provideVisualFeedback(duration: TimeInterval = 0.2, scale: CGFloat = 0.8, color: UIColor?) {
		// Shrink
		UIView.animate(withDuration: duration/2, delay: 0.0, options: [.curveLinear],
					   animations: {
						self.transform = CGAffineTransform(scaleX: scale, y: scale)
						self.alpha = 0
					   }, completion: { _ in
						// Revert back to original size
						UIView.animate(withDuration: duration/2, delay: 0.0, options: [.curveLinear], animations: {
							self.alpha = 1
							self.transform = .identity
						}, completion: { completed in
							if completed {
								self.backgroundColor = color
							}
						})
					})
	}
}

// MARK: - UIViewController
extension UIViewController {
	// Keyboard handlers
	func initializeHideKeyboard(){
		let tapSelf: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		view.addGestureRecognizer(tapSelf)
	}
	
	@objc private func dismissKeyboard(){
		view.endEditing(true)
	}
}
