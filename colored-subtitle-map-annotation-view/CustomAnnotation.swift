//
//  CustomAnnotation.swift
//  colored-subtitle-map-annotation-view
//
//  Created by Eric Mentele on 4/27/16.
//  Copyright © 2016 Eric Mentele. All rights reserved.
//

import Foundation
import MapKit

class CustomAnnotation: MKPointAnnotation {
    var titleLabel: String
    var subtitleLabel: NSAttributedString?
    
    init(titleLabel: String, subtitleLabel: NSMutableAttributedString?) {
        self.titleLabel = titleLabel
        self.subtitleLabel = subtitleLabel
    }
}