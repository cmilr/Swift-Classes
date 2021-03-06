//
//  RoundedButton.swift
//
//  Created by Cary Miller on 9/23/17.
//  Copyright © 2017 C.Miller & Co. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
   
   // MARK: - Properties
   @IBInspectable var cornerRadius: CGFloat = 0{
      didSet{
         self.layer.cornerRadius = cornerRadius
      }
   }
   
   @IBInspectable var borderWidth: CGFloat = 0{
      didSet{
         self.layer.borderWidth = borderWidth
      }
   }
   
   @IBInspectable var borderColor: UIColor = UIColor.clear{
      didSet{
         self.layer.borderColor = borderColor.cgColor
      }
   }
}
