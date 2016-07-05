//
//  ButtonCell.swift
//  ButtonWithDifferentAction
//
//  Created by macc on 16/7/5.
//  Copyright © 2016年 ZhengGuiJie. All rights reserved.
//

import UIKit
import SnapKit

private let identifier = "Cell"
class ButtonCell: UITableViewCell {
        /// 姓名
    private lazy var nameLabel = UILabel()
        /// 关注按钮
    private lazy var focusBtn = UIButton()

    private weak var delegate: FocusDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 暴露给外部的方法
extension ButtonCell {
    /**
     加载cell
     
     - parameter tableView: tableView
     - parameter atControl: 控制器
     */
    class func loadButtonCellAtTableView<VC: UIViewController where VC: FocusDelegate>(tableView: UITableView, control atControl: VC) -> ButtonCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? ButtonCell
        if cell == nil {
            cell = ButtonCell(style: .Default, reuseIdentifier: identifier)
        }
        cell?.delegate = atControl
        return cell!
    }
    /**
     显示cell信息
     
     - parameter tupe: 元组
     */
    func showCellInfoWithTupe(tupe: (title: String, isFocus: Bool)) {
        nameLabel.text = tupe.title
        setFocusButtonActionWithIsFocus(tupe.isFocus)
    }
    /**
     设置关注按钮的action
     */
    func setFocusButtonActionWithIsFocus(isFocus: Bool) {
        //先移除按钮上的操作行为--再根据不同情境添加不同的action
        focusBtn.removeTarget(nil, action: nil, forControlEvents: .TouchUpInside)
        switch isFocus {
        case true:
            //关注了，设置选中状态。。
            focusBtn.selected = true
            focusBtn.backgroundColor = UIColor.orangeColor()
            //此时添加，取消关注行为
            focusBtn.addTarget(self, action: .cancelFocus, forControlEvents: .TouchUpInside)
        case false:
            //未关注，设置未选中状态
            focusBtn.selected = false
            focusBtn.backgroundColor = UIColor.grayColor()
            //此时添加，添加关注行为
            focusBtn.addTarget(self, action: .focus, forControlEvents: .TouchUpInside)
        }
    }
}

// MARK: - 私有方法---不准备暴露给外部
private extension ButtonCell {
    func setUpUI() {
        //MARK: -先约束button，是为了nameLabel的最右边的那个约束-
        contentView.addSubview(focusBtn)
        focusBtn.snp_makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.top.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-15)
            make.width.equalTo(60)
        }
        focusBtn.setTitle("关注", forState: .Normal)
        focusBtn.setTitle("已关注", forState: .Selected)
        
        
       contentView.addSubview(nameLabel)
        nameLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.top.equalTo(contentView)
            make.left.equalTo(contentView).offset(20)
            make.right.lessThanOrEqualTo(focusBtn.snp_left).offset(-20)
        }
        nameLabel.textAlignment = .Left
    }
}


private extension ButtonCell {
    @objc func focusUserSender(sender: UIButton) {
        delegate?.didClickFocusButton(focusBtn)
    }
    
    @objc func cancelFocusUserSender(sender: UIButton) {
        delegate?.didClickCancelFocusButton(focusBtn)
    }
}

protocol FocusDelegate: class {
    func didClickFocusButton(button: UIButton)
    func didClickCancelFocusButton(button: UIButton)
}

// MARK: - 这样写是为了让代码更swift
private extension Selector {
    static let focus = #selector(ButtonCell.focusUserSender(_:))
    static let cancelFocus = #selector(ButtonCell.cancelFocusUserSender(_:))
}