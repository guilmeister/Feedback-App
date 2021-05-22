//
//  ViewController.swift
//  Feedback App
//
//  Created by Edward Guilllermo on 4/20/21.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var startingLogo: UIImageView!
    var screenTimer: Timer!
    let loadingIndicator: ProgressView = {
        let progress = ProgressView(colors: [.red, .systemGreen, .systemBlue], lineWidth: 5)
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTimer()
        setupLogo()
        setupAnimation()
    }
    
    func setupLogo() {
        //Function that sets up the properties for UIImageView Objects
        startingLogo.layer.masksToBounds = true
        startingLogo.layer.cornerRadius = startingLogo.bounds.width / 2
    }
    
    func setupAnimation() {
        //Function that sets up the animation properties for the ProgressView class
        self.view.addSubview(loadingIndicator)
        loadingIndicator.animateStroke()
        loadingIndicator.animateRotation()
        self.setupUI()
        loadingIndicator.isAnimating = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.loadingIndicator.isAnimating = false
        }
    }
    
    private func setupUI() {
        //Function that sets up the UI properties for the ViewController class
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        //self.view.backgroundColor = myColor
        self.view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor
                .constraint(equalTo: self.view.centerXAnchor),
            loadingIndicator.centerYAnchor
                .constraint(equalTo: self.view.centerYAnchor),
            loadingIndicator.widthAnchor
                .constraint(equalToConstant: 250),
            loadingIndicator.heightAnchor
                .constraint(equalTo: self.loadingIndicator.widthAnchor)
        ])
    }
    
    func setupTimer() {
        //Function that sets up the timer for loading
        screenTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(nextScreen), userInfo: nil, repeats: true)
    }
    
    @objc func nextScreen() {
        //Function that instantiates to the SignInViewController
        let sBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signInPage = sBoard.instantiateViewController(identifier: "SignIn") as! SignInViewController
        present(signInPage, animated: true, completion: nil)
        screenTimer.invalidate()
    }
}

