//
//  SimpleTableViewController.swift
//  LionheartExtensions
//
//  Created by Daniel Loewenherz on 3/4/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import UIKit
import LionheartTableViewCells
import KeyboardAdjuster

protocol TableViewSection {
    static var title: String? { get }

    // A mapping of sections to TableViewRow enums
    static var rows: [TableViewRowEnum] { get }
}

protocol TableViewRow {
    static var count: Int { get }
    var cell: LionheartTableViewCell.Type { get }
    init?(rawValue: Int)
}

typealias TableViewHandler = UIViewController -> Void

enum TableViewRowEnum {
    case Default(String?, TableViewHandler?)
    case Subtitle(String?, String?, TableViewHandler?)
    case Value1(String?, String?, TableViewHandler?)
    case Value2(String?, String?, TableViewHandler?)
    case Custom(LionheartTableViewCell.Type, (UITableViewCell) -> UITableViewCell, TableViewHandler?)
}

enum TableViewSectionEnum {
    case Default(String?, [TableViewRowEnum])

    var count: Int {
        switch self {
        case .Default(_, let rows):
            return rows.count
        }
    }

    var rows: [TableViewRowEnum] {
        if case .Default(_, let rows) = self {
            return rows
        }
        else {
            return []
        }
    }

    subscript(index: Int) -> TableViewRowEnum? {
        if case .Default(_, let rows) = self {
            return rows[index]
        }
        else {
            return nil
        }
    }

    var TableViewCellClasses: [LionheartTableViewCell.Type] {
        var types: [LionheartTableViewCell.Type] = []
        for row in rows {
            switch row {
            case .Default, .Custom:
                types.append(TableViewCellDefault.self)

            case .Subtitle:
                types.append(TableViewCellSubtitle.self)

            case .Value1:
                types.append(TableViewCellValue1.self)

            case .Value2:
                types.append(TableViewCellValue2.self)
            }
        }
        return types
    }
}

protocol TableViewSectionContainer {
    static var sections: [TableViewSectionEnum] { get }
}

class BaseTableViewController: UIViewController, KeyboardAdjuster {
    var keyboardAdjusterConstraint: NSLayoutConstraint?
    var keyboardAdjusterAnimated: Bool? = false
    var tableView: UITableView!

    init(style: UITableViewStyle = .Grouped) {
        super.init(nibName: nil, bundle: nil)

        tableView = UITableView(frame: CGRect.zero, style: style)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self as? UITableViewDelegate
        tableView.dataSource = self as? UITableViewDataSource
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        activateKeyboardAdjuster()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        deactivateKeyboardAdjuster()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)

        tableView.fillWidthOfSuperview()
        tableView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        keyboardAdjusterConstraint = view.bottomAnchor.constraintEqualToAnchor(tableView.bottomAnchor)
    }
}

class SimpleTableViewController<SectionType: TableViewSectionContainer>: BaseTableViewController, UITableViewDataSource, UITableViewDelegate {
    required init() {
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        var registeredClassIdentifiers: Set<String> = Set()
        for section in SectionType.sections {
            for type in section.TableViewCellClasses {
                if !registeredClassIdentifiers.contains(type.identifier) {
                    tableView.registerClass(type as! UITableViewCell.Type, forCellReuseIdentifier: type.identifier)
                    registeredClassIdentifiers.insert(type.identifier)
                }
            }
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return SectionType.sections.count
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SectionType.sections[section].count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let section = SectionType.sections[indexPath.section]
        if let row = section[indexPath.row] {
            switch row {
            case .Default(let title, _):
                let cell = tableView.dequeueReusableCellWithIdentifier(TableViewCellDefault.identifier, forIndexPath: indexPath)
                cell.textLabel?.text = title
                return cell

            case .Subtitle(let title, let detail, _):
                let cell = tableView.dequeueReusableCellWithIdentifier(TableViewCellSubtitle.identifier, forIndexPath: indexPath)
                cell.textLabel?.text = title
                cell.detailTextLabel?.text = detail
                return cell

            case .Value1(let title, let detail, _):
                let cell = tableView.dequeueReusableCellWithIdentifier(TableViewCellValue1.identifier, forIndexPath: indexPath)
                cell.textLabel?.text = title
                cell.detailTextLabel?.text = detail
                return cell

            case .Value2(let title, let detail, _):
                let cell = tableView.dequeueReusableCellWithIdentifier(TableViewCellValue2.identifier, forIndexPath: indexPath)
                cell.textLabel?.text = title
                cell.detailTextLabel?.text = detail
                return cell

            case .Custom(let CellType, let callback, _):
                let cell = tableView.dequeueReusableCellWithIdentifier(CellType.identifier, forIndexPath: indexPath)
                return callback(cell)
            }
        }
        else {
            return tableView.dequeueReusableCellWithIdentifier(TableViewCellDefault.identifier, forIndexPath: indexPath)
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section = SectionType.sections[indexPath.section]
        if let row = section[indexPath.row] {
            switch row {
            case .Default(_, let handler?):
                handler(self)

            case .Subtitle(_, _, let handler?):
                handler(self)

            case .Value1(_, _, let handler?):
                handler(self)

            case .Value2(_, _, let handler?):
                handler(self)

            case .Custom(_, _, let handler?):
                handler(self)
                
            default:
                break
            }
        }
    }
}