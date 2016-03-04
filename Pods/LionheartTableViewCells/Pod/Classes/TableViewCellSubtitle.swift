//
//  TableViewCellSubtitle.swift
//  Pods
//
//  Created by Daniel Loewenherz on 2/10/16.
//
//

public class TableViewCellSubtitle: UITableViewCell, LionheartTableViewCell {
    public static var identifier: String = "SubtitleCellIdentifier"

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}