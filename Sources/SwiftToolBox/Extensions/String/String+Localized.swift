//
//  File.swift
//  
//
//  Created by Turcan, Ediz on 04.11.19.
//

import Foundation

public extension String {
    func stbLocalized(forClass: AnyClass?) -> String {
        if let cls = forClass {
            return NSLocalizedString("\(String(describing: cls)).\(self)", comment: "")
        } else {
            return NSLocalizedString(self, comment: "")
        }
    }
}
