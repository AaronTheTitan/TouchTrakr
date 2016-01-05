//
//  DrawView.swift
//  TouchTrakr
//
//  Created by Aaron Bradley on 1/4/16.
//  Copyright © 2016 AaronTheTitan. All rights reserved.
//

import UIKit

class DrawView: UIView {
  var currentLine: Line?
  var finishedLines = [Line]()
  
  
  func strokeLine(line: Line) {
    let path = UIBezierPath()
    path.lineWidth = 10
    path.lineCapStyle = CGLineCap.Round
    
    path.moveToPoint(line.begin)
    path.addLineToPoint(line.end)
    path.stroke()
  }
  
  override func drawRect(rect: CGRect) {
    // draw finished lines in black
    UIColor.blackColor().setStroke()
    for line in finishedLines {
      strokeLine(line)
    }
    
    if let line = currentLine {
      // if there is a line currently being drawn, do it in red
      UIColor.redColor().setStroke()
      strokeLine(line)
    }
  }
}
