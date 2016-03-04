//
//  TableViewCellDefault.swift
//  Pods
//
//  Created by Daniel Loewenherz on 2/10/16.
//
//

public class TableViewCellDefault: UITableViewCell, LionheartTableViewCell {
    public static var identifier: String = "DefaultCellIdentifier"

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Default, reuseIdentifier: reuseIdentifier)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
