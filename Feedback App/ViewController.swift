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

    @IBOutlet weak var backgroundGIFImageView: UIImageView!
    var screenTimer : Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        screenTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(nextScreen), userInfo: nil, repeats: true)
    }
    
    private func setupView() {
        let path = URL(fileURLWithPath: Bundle.main.path(forResource: "WelcomeLoadingBackground", ofType: "mp4")!)
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
    
    @objc func nextScreen() {
        let sBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signInPage = sBoard.instantiateViewController(identifier: "SignIn") as! SignInViewController
        present(signInPage, animated: true, completion: nil)
        screenTimer.invalidate()
    }
}

