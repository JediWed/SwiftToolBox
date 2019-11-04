//
//  File.swift
//  
//
//  Created by Turcan, Ediz on 04.11.19.
//

import UIKit

private protocol STBTargetActionType: class {
    var actionSelector: Selector { get }
}

public class STBTargetAction<T: NSObjectProtocol>: NSObject, STBTargetActionType {
    fileprivate let actionSelector: Selector = #selector(STBTargetAction<T>.action(_:))
    fileprivate let actionBlock: (T) -> Void
    fileprivate weak var target: T?
    @objc
    fileprivate func action(_ sender: NSObjectProtocol) {
        guard let sender = sender as? T else { return }
        actionBlock(sender)
    }
    init(target: T? = nil, actionBlock: @escaping (T) -> Void) {
        self.actionBlock = actionBlock
    }
}

public extension STBTargetAction where T: UIControl {
    func stbRemove() {
        if let target = target {
            target.stbRemoveAction(self)
        }
    }
}

private class STBTargetActionHolder {
    fileprivate static var targetActionHolder = "targetActionList"
    fileprivate var targetActions: [STBTargetActionType] = []
}

private extension NSObjectProtocol {
    @nonobjc
    var targetActionHolder: STBTargetActionHolder {
        get {
            let asc = objc_getAssociatedObject(self,
                                               &STBTargetActionHolder.targetActionHolder)
            if let holder = asc as? STBTargetActionHolder {
                return holder
            } else {
                let holder = STBTargetActionHolder()
                self.targetActionHolder = holder
                return holder
            }
        }
        set {
            objc_setAssociatedObject(self,
                                     &STBTargetActionHolder.targetActionHolder,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }

    }
}

public extension UIControl {

    @discardableResult
    func stbAddActionForControlEvents<T: UIControl>(_ controlEvents: UIControl.Event,
                                                   action: @escaping (T) -> Void) -> STBTargetAction<T> {
        let action = STBTargetAction(target: self as? T, actionBlock: action)
        addTarget(action, action: action.actionSelector, for: controlEvents)
        targetActionHolder.targetActions.append(action)
        return action
    }

    func stbRemoveAllActions() {
        removeTarget(nil, action: nil, for: .allEvents)
        targetActionHolder.targetActions = []
    }

    func stbRemoveAction<T>(_ action: STBTargetAction<T>) {
        if let index = targetActionHolder.targetActions.firstIndex(where: {$0 === action}) {
            removeTarget(action, action: action.actionSelector, for: UIControl.Event.allEvents)
            targetActionHolder.targetActions.remove(at: index)

        }
    }

}

public extension UIButton {
    @discardableResult
    func stbAddAction<T: UIControl>(_ action: @escaping (T) -> Void) -> STBTargetAction<T> {
        return self.stbAddActionForControlEvents(.touchUpInside, action: action)
    }
}

public extension UISwitch {
    @discardableResult
    func stbAddAction<T: UIControl>(_ action: @escaping (T) -> Void) -> STBTargetAction<T> {
        return self.stbAddActionForControlEvents(.valueChanged, action: action)
    }
}
