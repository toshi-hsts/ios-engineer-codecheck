//
//  LoadingView.swift
//  iOSEngineerCodeCheck
//
//  Created by ToshiPro01 on 2022/06/21.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

class LodingView: UIView {

    @IBOutlet weak private var loadingFrameView: UIView!
    @IBOutlet weak private var indicator: UIActivityIndicatorView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
        setup()
    }

    private func loadNib() {
        let view = Bundle.main.loadNibNamed("LoadingView",
                                            owner: self,
                                            options: nil)?.first as? UIView

        view?.frame = self.bounds
        self.addSubview(view!)
    }

    private func setup() {
        self.backgroundColor = .gray.withAlphaComponent(0.2)
        loadingFrameView.layer.cornerRadius = 18
    }

    func startAnimatingIndicator() {
        indicator.startAnimating()
    }

    func stopAnimatingIndicator() {
        indicator.stopAnimating()
    }
}
