//
//  ListViewModel.swift
//  ButtonWithDifferentAction
//
//  Created by macc on 16/7/5.
//  Copyright © 2016年 ZhengGuiJie. All rights reserved.
//

import UIKit

class ListViewModel: NSObject {

        /// 为了安全,全部private,属性不暴露给外部。。。
    private lazy var listArr = [(title: String, isFocus: Bool)]()
    
    override init() {
        super.init()
        listArr = Array(count: 100, repeatedValue: ("伊利丹", false))
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ListViewModel  {
    func numberOfRows() -> Int {
        return listArr.count
    }

    func cellForRowAtIndexPath<VC: UITableViewController where VC: FocusDelegate>(indexPath: NSIndexPath, control atControl: VC) -> UITableViewCell {
        let cell = ButtonCell.loadButtonCellAtTableView(atControl.tableView, control: atControl)
        cell.showCellInfoWithTupe(listArr[indexPath.row])
        return cell
    }
}

// MARK: - 按钮行为
extension ListViewModel {
    /**
     关注
     */
    func focusWithSender(sender: UIButton, tableView atTableView: UITableView) {
        guard let contentView = sender.superview,
            let cell = contentView.superview as? ButtonCell,
            let indexPath = atTableView.indexPathForCell(cell) else {
                return
        }
        listArr[indexPath.row].isFocus = true
        cell.setFocusButtonActionWithIsFocus(true)
    }
    
    /**
     取消关注
     */
    func cancelFocusWithSender(sender: UIButton, tableView atTableView: UITableView) {
        guard let contentView = sender.superview,
            let cell = contentView.superview as? ButtonCell,
            let indexPath = atTableView.indexPathForCell(cell) else {
                return
        }
       listArr[indexPath.row].isFocus = false
        cell.setFocusButtonActionWithIsFocus(false)
    }
}