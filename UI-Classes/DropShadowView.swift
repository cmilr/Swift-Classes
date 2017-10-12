//
//  DropShadowView.swift
//
//  Created by Cary Miller on 9/24/17.
//  Copyright © 2017 C.Miller & Co. All rights reserved.
//

import UIKit

@IBDesignable
class DropShadowView: UIView {
	
	@IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0) {
		didSet {
			layer.shadowOffset = shadowOffset
		}
	}
	
	@IBInspectable var shadowOpacity: Float = 0 {
		didSet {
			layer.shadowOpacity = shadowOpacity
		}
	}
}
