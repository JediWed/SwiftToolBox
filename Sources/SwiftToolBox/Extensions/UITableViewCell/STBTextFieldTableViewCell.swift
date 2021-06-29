//
//  File.swift
//  
//
//  Created by Turcan, Ediz on 29.06.21.
//

import UIKit

public class STBTextFieldTableViewCell: UITableViewCell {

    public var delegate: UITextFieldDelegate? {
        didSet {
            self.textField.delegate = delegate
        }
    }

    public let textField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.accessibilityIdentifier = "stbtextfieldtableviewcell_textfield"
        return textField
    }()

    public let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.allowsDefaultTighteningForTruncation = false
        label.accessibilityIdentifier = "stbtextfieldtableviewcell_titlelabel"
        return label
    }()

    public var onChange: (String) -> Void = { _ in }
    private var textFieldTargetAction: STBTargetAction<UITextField>?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        textLabel?.isHidden = true
        detailTextLabel?.isHidden = true

        textFieldTargetAction = textField.stbAddActionForControlEvents(.editingChanged) { [unowned self] (textField: UITextField) in
                self.onChange(textField.text ?? "")
        }

        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(textField)

        addConstraints([
            NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal,
                               toItem: contentView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: contentView,
                               attribute: .leading, multiplier: 1, constant: .stbSpacingCellHorizontalPadding),
            NSLayoutConstraint(item: titleLabel, attribute: .bottom, relatedBy: .equal,
                               toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal,
                               toItem: contentView, attribute: .trailing, multiplier: 0.5, constant: 0),
            NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal,
                               toItem: contentView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: textField, attribute: .leading, relatedBy: .equal,
                               toItem: titleLabel, attribute: .trailing, multiplier: 1, constant: .stbSpacingSmall),
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
