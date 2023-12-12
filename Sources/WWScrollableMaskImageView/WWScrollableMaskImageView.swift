//
//  WWScrollableMaskImageView.swift
//  WWScrollableMaskImageView
//
//  Created by William.Weng on 2023/12/8.
//

import UIKit

@IBDesignable
open class WWScrollableMaskImageView: UIView {
    
    @IBInspectable var maskViewWidth: CGFloat = 0 { didSet { widthConstraint.constant = maskViewWidth }}
    @IBInspectable var barColor: UIColor = .black
    @IBInspectable var barImage: UIImage?
    @IBInspectable var originalImage: UIImage?
    @IBInspectable var maskImage: UIImage?

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var originalImageView: UIImageView!
    @IBOutlet weak var maskImageView: UIImageView!
    @IBOutlet weak var barImageView: UIImageView!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var scrollableMaskView: UIView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromXib(with: .module)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViewFromXib(with: .module)
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        initSetting()
        gestureSetting()
    }
    
    /// [IB Designables: Failed to render and update auto layout status](https://stackoverflow.com/questions/46723683/ib-designables-failed-to-render-and-update-auto-layout-status)
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        contentView.prepareForInterfaceBuilder()
    }
    
    @objc func barViewDidSwipe(_ gesture: UIPanGestureRecognizer) {
        barViewSwipeAction(gesture)
    }
}

// MARK: - 公開工具
public extension WWScrollableMaskImageView {
    
    /// 設定Bar圖片設定
    /// - Parameters:
    ///   - barImage: UIImage?
    ///   - contentMode: UIView.ContentMode
    ///   - barColor: UIColor?
    func setting(barImage: UIImage?, contentMode: UIView.ContentMode = .scaleAspectFill, barColor: UIColor = .black) {
        
        self.barImage = barImage
        self.barColor = barColor
        self.barImageView.contentMode = contentMode
        self.setNeedsDisplay()
    }
}

// MARK: - 小工具
private extension WWScrollableMaskImageView {
    
    /// 初始化Xib設定
    /// - Parameters:
    ///   - bundle: Bundle?
    ///   - nibName: String?
    func initViewFromXib(with bundle: Bundle? = nil, nibName: String? = nil) {
        
        let xibBundle = bundle ?? Bundle(for: Self.self)
        let xibName = nibName ?? String(describing: Self.self)
        
        xibBundle.loadNibNamed(xibName, owner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    /// 初始化畫面設定
    func initSetting() {
        barImageView.image = barImage
        barImageView.backgroundColor = barColor
        maskImageView.image = maskImage
        originalImageView.image = originalImage
        originalImageView.mask = scrollableMaskView
    }
    
    /// [滑動手勢設定](https://blog.csdn.net/kmyhy/article/details/79087418)
    func gestureSetting() {
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(Self.barViewDidSwipe(_:)))
        
        barView.isUserInteractionEnabled = true
        barView.addGestureRecognizer(panGesture)
    }
    
    /// [滑動手勢動作處理](https://juejin.cn/post/6844903466200989709)
    /// - Parameter gesture: UIPanGestureRecognizer
    func barViewSwipeAction(_ gesture: UIPanGestureRecognizer) {
        
        let radius = barView.frame.width * 0.5
        let point = gesture.location(in: originalImageView)
        let barImageViewOrigin = CGPoint(x: point.x - radius, y: barView.frame.origin.y)
        
        if (point.x < 0) { return }
        if (point.x > contentView.frame.width) { return }
        
        scrollableMaskView.frame = CGRect(origin: .zero, size: CGSize(width: point.x, height: scrollableMaskView.frame.height))
        barView.frame = CGRect(origin: barImageViewOrigin, size: barView.frame.size)
    }
}
