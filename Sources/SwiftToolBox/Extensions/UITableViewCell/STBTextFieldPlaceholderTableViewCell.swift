//
//  File.swift
//  
//
//  Created by Turcan, Ediz on 01.07.21.
//

import UIKit

public class STBTextFieldPlaceholderTableViewCell: UITableViewCell {

    public var delegate: UITextFieldDelegate? {
        didSet {
            self.textField.delegate = delegate
        }
    }
    
    public var title: String = ""

    public let textField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.accessibilityIdentifier = "stbtextfieldplaceholdertableviewcell_textfield"
        return textField
    }()

    public var onChange: (String) -> Void = { _ in }
    private var textFieldTargetAction: STBTargetAction<UITextField>?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        textLabel?.isHidden = true
        detailTextLabel?.isHidden = true
        textField.placeholder = title

        textFieldTargetAction = textField.stbAddActionForControlEvents(.editingChanged) { [unowned self] (textField: UITextField) in
                self.onChange(textField.text ?? "")
        }

        self.contentView.addSubview(textField)

        addConstraints([
            NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal,
                               toItem: contentView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: textField, attribute: .leading, relatedBy: .equal,
                               toItem: contentView, attribute: .trailing, multiplier: 1, constant: .stbSpacingCellHorizontalPadding),
            NSLayoutConstraint(item: textField, attribute: .trailing, relatedBy: .equal,
                               toItem: contentView, attribute: .trailing, multiplier: 1, constant: -.stbSpacingCellHorizontalPadding),
            NSLayoutConstraint(item: textField, attribute: .bottom, relatedBy: .equal,
                               toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0)
            ])
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("Do not use this initializer")
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if !selected {
            textField.resignFirstResponder()
        }
    }

    public override func becomeFirstResponder() -> Bool {
        textField.becomeFirstResponder()
        return super.becomeFirstResponder()
    }

}
