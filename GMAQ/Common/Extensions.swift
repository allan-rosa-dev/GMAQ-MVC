//
//  Extensions.swift
//  GMAQ
//
//  Created by Allan Rosa on 12/08/21.
//

import UIKit

extension String {
	func base64Encoded() -> String? {
		return data(using: .utf8)?.base64EncodedString()
	}
	
	func base64Decoded() -> String? {
		guard let data = Data(base64Encoded: self) else { return nil }
		return String(data: data, encoding: .utf8)
	}
}

enum AssetsColor {
	case red
	case green
	case blue
	case white
	case black
}

extension UIColor {
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

extension UIButton {
	func configure(with answer: Answer){
		self.setTitle(answer.text, for: .normal)
		self.isHidden = false
		self.backgroundColor = UIColor.appColor(.blue)
		self.titleLabel?.tintColor = UIColor.appColor(.white)
	}
}


extension UIView {
	func provideVisualFeedback(duration: TimeInterval = 0.2, scale: CGFloat = 0.8) {
		// Shrink
		UIView.animate(withDuration: duration/2, delay: 0.0, options: [.curveLinear],
					   animations: {
						self.transform = CGAffineTransform(scaleX: scale, y: scale)
					   }, completion: { _ in
						// Revert back to original size
						UIView.animate(withDuration: duration/2, delay: 0.0, options: [.curveLinear], animations: {
							self.transform = .identity
						})
					})
	}
}

extension UIViewController {
	func initializeHideKeyboard(){
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		view.addGestureRecognizer(tap)
	}
	
	@objc private func dismissKeyboard(){
		view.endEditing(true)
	}
	
//	func addKeyboardObservers(){
//		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//	}
//	
//	@objc fileprivate func keyboardWillShow(_ notification: Notification){
//		let vc = UIViewController
//		if (  == nil) { return }
//		guard let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) else { return }
//		
//	}
}
