//
//  String.swift
//  LifeHacksApp
//
//  Created by zombietux on 30/01/2019.
//  Copyright © 2019 zombietux. All rights reserved.
//

import Foundation

extension String {
    var htmlString: NSAttributedString? {
        guard let htmlData = self.data(using: .unicode) else {
            return nil
        }
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        return try? NSAttributedString(data: htmlData, options: options, documentAttributes: nil)
    }
}
