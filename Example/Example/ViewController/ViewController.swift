//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2023/12/11.
//  ~/Library/Caches/org.swift.swiftpm/

import UIKit
import WWScrollableMaskImageView

final class ViewController: UIViewController {

    @IBOutlet weak var maskView: WWScrollableMaskImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let originalImage = UIImage(named: "OriginalImage")
        let maskImage = UIImage(named: "MaskImage")
        let barImage = UIImage(named: "Bar")
        let barNinePngImage = barImage?.resizableImage(withCapInsets: UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0), resizingMode: .stretch)
        
        maskView.setting(originalImage: maskImage, maskImage: originalImage, maskViewWidth: maskView.frame.width * 0.5 - 16, barImage: barNinePngImage, barContentMode: .scaleToFill, barColor: .clear)
    }
}
