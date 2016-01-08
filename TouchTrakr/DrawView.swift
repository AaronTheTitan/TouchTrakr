//
//  DrawView.swift
//  TouchTrakr
//
//  Created by Aaron Bradley on 1/4/16.
//  Copyright © 2016 AaronTheTitan. All rights reserved.
//

import UIKit

class DrawView: UIView {
  
  var currentLines = [NSValue: Line]()
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
    
    UIColor.redColor().setStroke()
    for (_, line) in currentLines {
      strokeLine(line)
    }
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    print(__FUNCTION__)
    
    for touch in touches {
      let location = touch.locationInView(self)
      let newLine = Line(begin: location, end: location)
      let key = NSValue(nonretainedObject: touch)
      currentLines[key] = newLine
    }
    
    setNeedsDisplay()
  }
  
  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    print(__FUNCTION__)
    
    for touch in touches {
      let key = NSValue(nonretainedObject: touch)
      currentLines[key]?.end = touch.locationInView(self)
    }
    
    setNeedsDisplay()
  }
  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    print(__FUNCTION__)
    
    for touch in touches {
      let key = NSValue(nonretainedObject: touch)
      if var line = currentLines[key] {
        line.end = touch.locationInView(self)
        finishedLines.append(line)
        currentLines.removeValueForKey(key)
      }
    }
    
    setNeedsDisplay()
  }
  
  override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
    print(__FUNCTION__)
    
    currentLines.removeAll()
    setNeedsDisplay()
  }
  
}
