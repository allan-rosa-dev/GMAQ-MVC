//
//  Extensions.swift
//  GMAQ
//
//  Created by Allan Rosa on 12/08/21.
//

import Foundation

extension String {
	func base64Encoded() -> String? {
		return data(using: .utf8)?.base64EncodedString()
	}

	func base64Decoded() -> String? {
		guard let data = Data(base64Encoded: self) else { return nil }
		return String(data: data, encoding: .utf8)
	}
}
