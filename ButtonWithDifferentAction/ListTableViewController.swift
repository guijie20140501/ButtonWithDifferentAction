//
//  ListTableViewController.swift
//  ButtonWithDifferentAction
//
//  Created by macc on 16/7/5.
//  Copyright © 2016年 ZhengGuiJie. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    private lazy var viewModel = ListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ListTableViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     return viewModel.cellForRowAtIndexPath(indexPath, control: self)
     }
}

// MARK: - FocusDelegate
extension ListTableViewController: FocusDelegate {
    func didClickFocusButton(button: UIButton) {
        viewModel.focusWithSender(button, tableView: tableView)
    }
    func didClickCancelFocusButton(button: UIButton) {
        viewModel.cancelFocusWithSender(button, tableView: tableView)
    }
}

private extension ListTableViewController {
    func setUpUI() {
        title = "列表"
    }
}
