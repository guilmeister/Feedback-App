//
//  HappyExitViewController.swift
//  Feedback App
//
//  Created by Edward Guilllermo on 4/30/21.
//

import UIKit
import AVKit
import AVFoundation

class HappyExitViewController: UIViewController {

    @IBOutlet weak var backgroundGIFImageView: UIImageView!
    @IBOutlet weak var labelBackgroundImageView: UIImageView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabelBorders()
        setupButtonBorders()
        setupView()
    }
    
    func setupButtonBorders() {
        //Setup for Exit Button
        exitButton.layer.cornerRadius = 10.0
        exitButton.layer.masksToBounds = true
        exitButton.layer.borderColor = UIColor.black.cgColor
        exitButton.layer.borderWidth = 1.0
        //Setup for Sign In Button
        signInButton.layer.cornerRadius = 10.0
        signInButton.layer.masksToBounds = true
        signInButton.layer.borderColor = UIColor.black.cgColor
        signInButton.layer.borderWidth = 1.0
    }
    
    func setupLabelBorders() {
        labelBackgroundImageView.layer.cornerRadius = 10.0
        labelBackgroundImageView.clipsToBounds = true
        labelBackgroundImageView.layer.borderColor = UIColor.black.cgColor
        labelBackgroundImageView.layer.borderWidth = 1.0
    }
    
    private func setupView() {
        let path = URL(fileURLWithPath: Bundle.main.path(forResource: "HappyEndBackground", ofType: "mp4")!)
        let player = AVPlayer(url: path)
        let newLayer = AVPlayerLayer(player: player)
        
        newLayer.frame = self.backgroundGIFImageView.frame
        self.backgroundGIFImageView.layer.addSublayer(newLayer)
        newLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        player.play()
        player.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.videoDidPlayToEnd(_:)), name: NSNotification.Name(rawValue: "AVPlayerItemDidPlayToEndTimeNotification"), object: player.currentItem)
    }
    
    @objc func videoDidPlayToEnd(_ notification: Notification) {
        let player: AVPlayerItem = notification.object as! AVPlayerItem
        player.seek(to: CMTime.zero)
    }
    
    @IBAction func exitButtonClicked(_ sender: Any) {
        exit(0)
    }
}
