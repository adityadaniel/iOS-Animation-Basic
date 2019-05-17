//
//  ViewController.swift
//  iOS Animation
//
//  Created by Daniel Aditya Istyana on 16/05/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var randomHeight: () -> CGFloat = { () in
        return CGFloat.random(in: 0...700)
    }
    
    var randomWidth: () -> CGFloat = { () in
        return CGFloat.random(in: 0...300)
    }
    
    @IBOutlet weak var redView: UIView!
    
    
    @IBOutlet weak var animationTypeSegmentedControl: UISegmentedControl! {
        didSet {
            animationTypeSegmentedControl.tintColor = .red
            animationTypeSegmentedControl.layer.cornerRadius = 12
        }
    }
    
    
    @IBAction func animationTypeSegmentedControlTapped(_ sender: UISegmentedControl) {
        print(animationTypeSegmentedControl.selectedSegmentIndex)
    }
    
    override func viewDidLoad() {
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(startAnimation))
        gesture.numberOfTapsRequired = 1
        
        redView.bringSubviewToFront(animationTypeSegmentedControl)
        
        redView.isUserInteractionEnabled = true
        redView.addGestureRecognizer(gesture)
        
        super.viewDidLoad()
        
    }
    
    @objc func startAnimation() {
        if animationTypeSegmentedControl.selectedSegmentIndex == 0 {
            redView.layer.removeAllAnimations()
            animateBounce()
        } else if animationTypeSegmentedControl.selectedSegmentIndex == 1 {
            redView.layer.removeAllAnimations()
            animateSlide()
        } else {
            redView.layer.removeAllAnimations()
            animatePop()
        }
    }
    
    func animatePop() {
        redView.layer.cornerRadius = redView.bounds.height / 2
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            let frame = self.redView.frame
            self.redView.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: 0, height: 0)
        }) { _ in
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: [.curveEaseInOut], animations: {
                self.redView.frame = CGRect(x: self.randomWidth(), y: self.randomHeight(), width: 200, height: 200)
                self.redView.backgroundColor = self.createRandomColor()
            }, completion: nil)
        }
    }
    
    func animateBounce() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [.curveLinear], animations: {
            self.redView.frame = CGRect(x: self.randomWidth(), y: self.randomHeight(), width: 200, height: 200)
            print(self.randomHeight, self.randomWidth)
            self.redView.backgroundColor = self.createRandomColor()
        }, completion: nil)
    }
    
    func animateSlide() {
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
            self.redView.frame = CGRect(x: self.randomWidth(), y: self.randomHeight(), width: 200, height: 200)
            self.redView.backgroundColor = self.createRandomColor()
            
        }, completion: nil)
    }
    
    func createRandomColor() -> UIColor {
        return UIColor(red: CGFloat.random(in: 0...255)/255, green: CGFloat.random(in: 0...255)/255, blue: CGFloat.random(in: 0...255)/255, alpha: 1.0)
    }
}
