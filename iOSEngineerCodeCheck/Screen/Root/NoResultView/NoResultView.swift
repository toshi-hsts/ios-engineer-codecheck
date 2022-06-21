//
//  NoResultView.swift
//  iOSEngineerCodeCheck
//
//  Created by ToshiPro01 on 2022/06/22.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

class NoResultView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }

    private func loadNib() {
        let view = Bundle.main.loadNibNamed("NoResultView",
                                            owner: self,
                                            options: nil)?.first as? UIView

        view?.frame = self.bounds
        self.addSubview(view!)
    }
}
