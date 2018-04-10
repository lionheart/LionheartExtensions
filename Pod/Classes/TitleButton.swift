//
//  TitleButton.swift
//  LionheartExtensions
//
//  Created by Dan Loewenherz on 4/10/18.
//

import Foundation

public final class TitleButton: UIButton {
    static let centeredParagraphStyle: NSParagraphStyle = {
        let style = NSMutableParagraphStyle()
        style.setParagraphStyle(.default)
        style.alignment = .center
        return style
    }()
    
    static let normalAttributes = [
        NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17),
        NSAttributedStringKey.foregroundColor: UIColor.black,
        NSAttributedStringKey.paragraphStyle: centeredParagraphStyle
    ]
    
    static let highlightedAttributes = [
        NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17),
        NSAttributedStringKey.foregroundColor: UIColor.gray,
        NSAttributedStringKey.paragraphStyle: centeredParagraphStyle
    ]
    
    static let subtitleAttributes = [
        NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12),
        NSAttributedStringKey.foregroundColor: UIColor.darkGray,
        NSAttributedStringKey.paragraphStyle: centeredParagraphStyle
    ]
    
    @objc convenience init() {
        self.init(frame: .zero)
    }
}

// MARK: - CustomButtonType
extension TitleButton: CustomButtonType {
    public func setTitle(title: String) {
        setTitle(title: title, subtitle: nil)
    }
    
    public func setTitle(title: String, subtitle: String?) {
        let normalString = NSMutableAttributedString(string: title, attributes: TitleButton.normalAttributes)
        let highlightedString = NSMutableAttributedString(string: title, attributes: TitleButton.highlightedAttributes)
        
        if let subtitle = subtitle {
            normalString.append(NSAttributedString(string: "\n" + subtitle, attributes: TitleButton.subtitleAttributes))
            highlightedString.append(NSAttributedString(string: "\n" + subtitle, attributes: TitleButton.subtitleAttributes))
            titleLabel?.lineBreakMode = .byWordWrapping
        } else {
            titleLabel?.lineBreakMode = .byTruncatingTail
        }
        
        setAttributedTitle(normalString, for: .normal)
        setAttributedTitle(highlightedString, for: .highlighted)
        
        sizeToFit()
    }
    
    public func startAnimating() {
        fatalError()
    }
    
    public func stopAnimating() {
        fatalError()
    }
}

