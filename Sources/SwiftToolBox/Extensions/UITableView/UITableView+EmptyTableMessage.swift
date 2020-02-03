//
//  File.swift
//  
//
//  Created by Ediz Turcan on 03.02.20.
//

import UIKit

public extension UITableView {
    func tbSetEmptyMessage(_ message: String) {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0),
                          size: CGSize(width: self.bounds.size.width * 0.75, height: self.bounds.size.height * 0.75))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func tbRemoveEmptyMessage() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
