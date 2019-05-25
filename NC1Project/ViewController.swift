//
//  ViewController.swift
//  NC1Project
//
//  Created by Elisabeth Jessica Valencia on 19/05/19.
//  Copyright © 2019 Elisabeth Jessica Valencia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pgBar: UIProgressView!
    @IBOutlet weak var objectMe: UIImageView!
    @IBOutlet weak var safeAreaView: UIView!
    
    @IBOutlet weak var bomb: UIImageView!
    @IBOutlet weak var explode: UIImageView!
    @IBOutlet weak var command: UIImageView!
    
    
    
    //buat replay game nya
    @IBAction func back(_ sender: UIStoryboardSegue) {
        timer?.invalidate()
        timer = nil
        
        // ini buat ngilangin semua yg ada di viewnya
        safeAreaView.subviews.forEach( { $0.removeFromSuperview() } )
        view.subviews.forEach({ $0.removeFromSuperview() })
        
        // ini manggil lagi semua yg ada di view nya setelah di remove
        pgBar.progress = 0.0
        view.addSubview(objectMe)
        view.addSubview(safeAreaView)
        view.addSubview(pgBar)
        view.addSubview(bomb)
        view.addSubview(explode)
        view.addSubview(command)
        
        // manggil lagi timer nya
        setupTimer()
        
    }
    
    var timer: Timer?
    
    // cara supaya status bar nya jadi light
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ini supaya objectnya bulat
        //objectMe.layer.cornerRadius = objectMe.frame.width/2
        
        // recognize tap
        let tapGesture = UITapGestureRecognizer (target: self , action: #selector(moveAnimation))
        objectMe.addGestureRecognizer(tapGesture)
        
        // manggil timer untuk mulai
        if timer == nil {
            setupTimer()
        }
        
        // gimana supaya ketika mulai tap, instruksinya hilang:(
       /*  if tapGesture.shouldReceiveTouch =  {
            self.command.alpha = 1
            
        } else {
           self.command.alpha = 0
        } */
        
        // ini kasih instruksi di awal pas buka apps nya
       if pgBar.progress == Float(0.1) {
           self.command.alpha = 1
       }
    
    }
    
    
    // ini untuk setup timer
    func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(handlingPgBar), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    
    // ini function progress bar nya / TIMER
    @objc func handlingPgBar() {
     
        if pgBar.progress == 1 {
            timer?.invalidate()
            self.bomb.alpha = 0
            self.explode.alpha = 1
            self.command.alpha = 0
            
            // ini untuk perform segue yg otomatis setelah timernya full
            self.performSegue(withIdentifier: "GameOver", sender: self)
            
        } else {
            pgBar.progress += 0.1
            self.bomb.alpha = 1
            self.explode.alpha = 0
            self.command.alpha = 0
    
        }
        
        // ini CARA UNTUK MEMBESARKAN PROGRESS BAR NYA
        pgBar.transform = CGAffineTransform(scaleX: 1, y: 8)
        
    }
    
    /* INI DIPAKAI KALO MAU PAKE TOUCH DULU SEBELUM PINDAH KE LAYAR GAME OVER
    //trigger touch dimanapun saat timernya abis
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
        //ketika progress sudah penuh
      if pgBar.progress == 1{
          performSegue(withIdentifier: "GameOver", sender: self)
        }
    } */
    
    // ini animation ketika di klik objectnya
    @objc func moveAnimation() {
    
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.changePosition()
        }) { (isFinished) in
            
        }
        
        // ini untuk tambahin si benda lain (bloodcell) ketika si object (mikroba) di klik
        let rand = Float.random(in: 1...10)
        let asw = Float(objectMe.frame.minX)
        _ = rand + asw
        let asd: UIImageView = UIImageView(frame: CGRect(x: CGFloat(asw), y: objectMe.layer.position.y, width: 135, height: 135))
        asd.image = UIImage(named: "bloodcell")
        self.safeAreaView.addSubview(asd)
    }
    
    // ini objectMe(mikroba) posisi nya pindah kemana
    func changePosition(){
        let randomX = Int.random(in: 1...300)
        let randomY = Int.random(in: 1...500)
        
        objectMe.frame = CGRect(x: CGFloat(randomX), y: CGFloat(randomY), width: 145, height: 150.0)
        
    }

}

