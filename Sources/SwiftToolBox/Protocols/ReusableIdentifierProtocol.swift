//
//  File.swift
//  
//
//  Created by Ediz Turcan on 03.02.20.
//

import UIKit

protocol STBReuseIdentifierType {
    static var reuseIdentifier: String { get }
}

extension STBReuseIdentifierType {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView: STBReuseIdentifierType {}

extension UICollectionView {

    func stbRegister<T>(_ cellClass: T.Type) where T: UICollectionViewCell {
        register(cellClass, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func tsbDequeueReusableSupplementaryView<T: STBReuseIdentifierType>(ofType type: T.Type,
                                                                      kind elementKind: String,
                                                                      for indexPath: IndexPath) -> T {
        let view = dequeueReusableSupplementaryView(ofKind: elementKind,
                                                    withReuseIdentifier: T.reuseIdentifier,
                                                    for: indexPath)
        guard let typedView = view as? T else {
            fatalError("View of wrong type has been registered. Expected: \(T.self), Actual: \(Swift.type(of: view))")
        }
        return typedView
    }

    func stbDequeueReusableCell<T>(of type: T.Type, for indexPath: IndexPath) -> T where T: UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath)
        guard let typedCell = cell as? T else {
            fatalError("Cell of wrong type has been registered. Expected: \(T.self), Actual: \(Swift.type(of: cell))")
        }
        return typedCell
    }
}

extension UITableViewCell: STBReuseIdentifierType {}
extension UITableViewHeaderFooterView: STBReuseIdentifierType {}

public extension UITableView {

    func stbRegister<T>(_ cellClass: T.Type) where T: UITableViewCell {
        register(cellClass, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func stbRegister<T>(_ headerFooterViewClass: T.Type) where T: UITableViewHeaderFooterView {
        register(headerFooterViewClass, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }

    func stbDequeueReusableCell<T>(of type: T.Type, for indexPath: IndexPath) -> T where T: UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath)
        guard let typedCell = cell as? T else {
            fatalError("Cell of wrong type has been registered. Expected: \(T.self), Actual: \(Swift.type(of: cell))")
        }
        return typedCell
    }

    func stbDequeueReusableHeaderFooterView<T>(of type: T.Type) -> T where T: UITableViewHeaderFooterView {
        let view = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier)
        guard let typedView = view as? T else {
            fatalError("View of wrong type has been registered. Expected: \(T.self), Actual: \(Swift.type(of: view))")
        }
        return typedView
    }

}
