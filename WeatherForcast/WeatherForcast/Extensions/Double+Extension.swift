//
//  Double+Extension.swift
//  Common
//
//  Created by Tuấn Bờm on 5/4/18.
//  Copyright © 2018 Tuấn Bờm. All rights reserved.
//

import Foundation

extension Double {
    func getStringTwoDecimal() -> String {
        return String(format: "%.2f", self)
    }
}