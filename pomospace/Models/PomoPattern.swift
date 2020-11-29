//
//  PomoPattern.swift
//  pomospace
//
//  Created by Justin Pak on 11/27/20.
//  Copyright © 2020 Justin Pak. All rights reserved.
//

import SwiftUI

enum Pattern: String {
    case twentyfive = "25-25-25-25"
    case fifty = "25-25-50"
}

struct PomoPattern : View {
    var pattern: String
}
