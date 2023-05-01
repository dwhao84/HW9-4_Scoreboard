//
//  ScroeboardViewController.swift
//  HW9-4_Scoreboard
//
//  Created by Dawei Hao on 2023/4/15.
//
/*
 1.每局 11 分制，輸流發球，發球時每 2 球輪替一次。
 2.點選數字會增加分數，上方的小數字代表雙方獲勝的局數，下方的大數字代表目前局數的比分。
 目前的發球方下方顯示 Serve。
 3.點選 Reset 會將比數清空，大數字和小數字都清成 0。
 4.可在畫面上輸入雙方的名字，比方左邊顯示帥氣的 Peter，右邊顯示弱弱的 Hook 船長。
 5.更換背景。
 6.其中一方達到 11 分時獲勝，上方獲勝的局數更新。
 7.點選 Change Side 將讓左右的分數互換。 左邊的分數跑到右邊，右邊的分數跑到左邊。
 
 進階功能:
 8. 10 比 10 平手後(deuce)，發球改成每 1 球輪替一次，先多得 2 分的獲勝。
 9.點選 Rewind 會回到上一步
 */

import UIKit

class ScroeboardViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scoreNumber1: UILabel!
    @IBOutlet weak var scoreNumber2: UILabel!
    @IBOutlet weak var scoreNumber3: UILabel!
    @IBOutlet weak var scoreNumber4: UILabel!
    @IBOutlet weak var serveLabel: UILabel!
    @IBOutlet weak var rewindButton: UIButton!
    @IBOutlet weak var changeSideButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var playerName1: UILabel!
    @IBOutlet weak var playerName2: UILabel!
    
    
    var clickTheRewindButton = 0
    var serveNumberCount = 0
    var countLabel1 = 0
    var countLabel2 = 0
    
    var text = ""
    var text1 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //view backgroundcolor system Mint
        view.backgroundColor = .systemMint
        
        //Set up scoreNumber1
        scoreNumber1.text = "0"
        scoreNumber1.font = .boldSystemFont(ofSize: 60)
        scoreNumber1.frame = CGRect(x: 60, y: 386, width: 80, height: 80)
        scoreNumber1.textAlignment = .center
        scoreNumber1.textColor = .black
        scoreNumber1.isUserInteractionEnabled = true
        view.addSubview(scoreNumber1)
        
        let scoreMode = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        scoreNumber1.addGestureRecognizer(scoreMode)
        
        let scoreMode1 = UITapGestureRecognizer(target: self, action: #selector(labelTapped1))
        scoreNumber2.addGestureRecognizer(scoreMode1)
        
        //Set up scoreNumber2
        scoreNumber2.text = "0"
        scoreNumber2.font = .boldSystemFont(ofSize: 60)
        scoreNumber2.frame = CGRect(x: 257, y: 386, width: 80, height: 80)
        scoreNumber2.textAlignment = .center
        scoreNumber2.textColor = .black
        scoreNumber2.isUserInteractionEnabled = true
        view.addSubview(scoreNumber2)
        
        //Set up scoreNumber3
        scoreNumber3.text = "0"
        scoreNumber3.font = UIFont.systemFont(ofSize: 35)
        scoreNumber3.frame = CGRect(x: 119, y: 332, width: 30, height: 50)
        scoreNumber3.textAlignment = .center
        scoreNumber3.textColor = .black
        view.addSubview(scoreNumber3)
        
        //Set up scoreNumber4
        scoreNumber4.text = "0"
        scoreNumber4.font = UIFont.systemFont(ofSize: 35)
        scoreNumber4.frame = CGRect(x: 245, y: 331, width: 30, height: 50)
        scoreNumber4.textAlignment = .center
        scoreNumber4.textColor = .black
        view.addSubview(scoreNumber3)
        
        //Set up reset button
        resetButton.frame = CGRect(x: 162, y: 452, width: 68, height: 35)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.tintColor = .red
        view.addSubview(resetButton)
        
        //Set up Rewind Button
        rewindButton.frame = CGRect(x: 157, y: 366, width: 80, height: 35)
        rewindButton.setTitle("Rewind", for: .normal)
        view.addSubview(rewindButton)
        
        //Set up ChangeSide Button
        changeSideButton.frame = CGRect(x: 137, y: 409, width: 121, height: 35)
        changeSideButton.setTitle("Change Side", for: .normal)
        view.addSubview(changeSideButton)
        
        //Set up Serve label
        serveLabel.text = "Serve"
        serveLabel.font = UIFont.systemFont(ofSize: 17)
        serveLabel.frame = CGRect(x: 78, y: 459, width: 44, height: 21)
        serveLabel.textColor = .black
        
        //Set player1 label
        playerName1.text = "Player 1"
        playerName1.font = UIFont.systemFont(ofSize: 17)
        playerName1.frame = CGRect(x: 71, y: 498, width: 65, height: 21)
        playerName1.textAlignment = .center
        playerName1.textColor = .black
        view.addSubview(playerName1)
        
        //Set player2 label
        playerName2.text = "Player 2"
        playerName2.font = UIFont.systemFont(ofSize: 17)
        playerName2.frame = CGRect(x: 268, y: 498, width: 65, height: 21)
        playerName2.textAlignment = .center
        playerName2.textColor = .black
        view.addSubview(playerName2)
    }

    //FillPlayerNameViewController資料傳到這一頁的時候，顯示文字內容到scoreboard
    override func viewDidAppear(_ animated: Bool) {
        alertForWithClickKeyIn()
        playerName1.text! = text
        playerName2.text! = text1
    }
    
    //點選數字會增加分數，上方的小數字代表雙方獲勝的局數，下方的大數字代表目前局數的比分。
    //ScoreNumber1 觸擊
    @objc func labelTapped() {
        if let currentNumber = Int(scoreNumber1.text!) {
            scoreNumber1.text = "\(currentNumber + 1)"
        } else {
            scoreNumber1.text = "1"
        }
        backgroundColorChange()
        scoreOverEleven ()
        turnTheServe()
        serveNumberCount += 1
    }
    
    //ScoreNumber2 觸擊
    @objc func labelTapped1() {
        if let currentNumber = Int(scoreNumber2.text!) {
            scoreNumber2.text = "\(currentNumber + 1)"
        } else {
            scoreNumber2.text = "1"
        }
        backgroundColorChange()
        scoreOverEleven ()
        turnTheServe()
        serveNumberCount += 1
    }
    
    //設定一個function，serveLabel移至左邊
    func serveLocationToLeft () {
        serveLabel.frame = CGRect(x: 78, y: 459, width: 44, height: 21)
    }
    //設定一個function，serveLabel移至右邊
    func serveLocationToRight () {
        serveLabel.frame = CGRect(x: 275, y: 459, width: 44, height: 21)
    }
    
    //點選 Reset將比數清空，大數字和小數字都清成 0。
    //並將Serve Label移至初始畫面的左邊
    //playerLabel 1 & 2回歸原有的位置上
    @IBAction func clickTheResetButton(_ sender: Any) {
        scoreNumber1.text = "0"
        scoreNumber2.text = "0"
        scoreNumber3.text = "0"
        scoreNumber4.text = "0"
        serveLocationToLeft()
        player1Label()
        player2Label()
        view.backgroundColor = .systemMint
    }
    
    //點選 Reset將比數清空，設定將playerName1 回到原本設定的位置
    func player1Label() {
        //Set player1 label
        playerName1.text = "Player 1"
        playerName1.font = UIFont.systemFont(ofSize: 17)
        playerName1.frame = CGRect(x: 71, y: 498, width: 65, height: 21)
        playerName1.textAlignment = .center
        playerName1.textColor = .black
        view.addSubview(playerName1)
    }
    //點選Reset將比數清空，設定將playerName2 回到原本設定的位置
    func player2Label() {
        //Set player2 label
        playerName2.text = "Player 2"
        playerName2.font = UIFont.systemFont(ofSize: 17)
        playerName2.frame = CGRect(x: 268, y: 498, width: 65, height: 21)
        playerName2.textAlignment = .center
        playerName2.textColor = .black
        view.addSubview(playerName2)
    }
     
    //點擊Label之後更換背景顏色
    func backgroundColorChange() {
        // 設定 slider 會隨機產生不同數字
        let redSlider = CGFloat.random(in: 0...255)
        let greenSlider = CGFloat.random(in: 0...255)
        let blueSlider = CGFloat.random(in: 0...255)
        
        // 檢查 scoreNumber1 的值是否在 1 到 11 的範圍內
        if let scoreNumber1Int = Int(scoreNumber1.text!), (1...11).contains(scoreNumber1Int) {
            view.backgroundColor = UIColor(red: redSlider/255, green: greenSlider/255, blue: blueSlider/255, alpha: 1)
        }
        // 檢查 scoreNumber2 的值是否為 "1...11"
        if let scoreNumber2Int = Int(scoreNumber2.text!), (1...11).contains(scoreNumber2Int) {
            view.backgroundColor = UIColor(red: redSlider/255, green: greenSlider/255, blue: blueSlider/255, alpha: 1)
        }
    }
    
    //當點選scoreLabel1超過11分時
    func scoreOverEleven () {
        if let score1 = Int(scoreNumber1.text!), let score2 = Int(scoreNumber2.text!), let score3 = Int(scoreNumber3.text!), let score4 = Int(scoreNumber4.text!) {
            if (score1 >= 10 && score2 >= 10 && abs(score1 - score2) >= 2) || (score1 == 11 && score2 <= 9) || (score2 == 11 && score1 <= 9) {
                if score1 > score2 {
                    let newQuaqter = score3 + 1
                    let winScore = scoreNumber1
                    _ = winScore
                    scoreNumber3.text = String(newQuaqter)
                    serveSideChange()
                    alertForWins()
                    print("player 1 win")
                    scoreNumber1.text = "0"
                    scoreNumber2.text = "0"
                } else if score2 > score1 {
                    let newQuaqter = score4 + 1
                    _ = score1
                    _ = scoreNumber1.text
                    scoreNumber4.text = String(newQuaqter)
                    serveSideChange()
                    alertForWins()
                    print("player 2 win")
                    scoreNumber1.text = "0"
                    scoreNumber2.text = "0"
                }
            } else if score1 >= 10 && score1 == score2 {
                print("Deuce")
                serveSideChange()
            }
        }
    }
    
    //點選 Change Side 讓左右的分數互換以及serve的位置也互換
    @IBAction func clickTheChangeSideButton(_ sender: Any) {
        //比分互換
        let scoreChange = scoreNumber1.text
        scoreNumber1.text = scoreNumber2.text
        scoreNumber2.text = scoreChange
        //節數互換
        let quarterChange = scoreNumber3.text
        scoreNumber3.text = scoreNumber4.text
        scoreNumber4.text = quarterChange
        //Player的名字互換
        let playerNameChange = playerName1.text
        playerName1.text = playerName2.text
        playerName2.text = playerNameChange
        //Serve的位置互換
        if serveLabel.frame.origin.x == 78 {
            UIView.animate(withDuration: 0.001) {
                self.serveLabel.frame.origin.x = 275
            }
        } else {
            UIView.animate(withDuration: 0.001) {
                self.serveLabel.frame.origin.x = 78
            }
        }
    }
    
    //每局 11 分制，輸流發球，發球時每 2 球輪替一次。
    func turnTheServe () {
        if serveNumberCount % 2 == 0 {
            serveSideChange()
        }
    }
    //建立上方2球輪替一次的function
    //用if else寫法將serveLabel由左移至右，當％不滿足2的時候，再由右移至左，位置互換。
    func serveSideChange () {
        if serveLabel.frame == CGRect(x: 78, y: 459, width: 44, height: 21) {
            serveLocationToRight()
        } else if  serveLabel.frame == CGRect(x: 275, y: 459, width: 44, height: 21) {
            serveLocationToLeft()
        }
    }
    //新增一個alertController
    func alertForWins() {
        //建立一個alert Controller，並包含標題和內文
        let controller = UIAlertController(title: "贏球了!", message: "恭喜拿下這局的勝利", preferredStyle: .alert)
        //建立一個Ok的Action當對方贏球的時候，並寫上Ok, 風格為預設值。
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        //將Action內容加入controller上
        controller.addAction(okAction)
        //用present呈現controller的action和內容
        self.present(controller, animated: true)
    }
    
    func alertForWithClickKeyIn() {
        let keyInController = UIAlertController(title: "輸入成功!", message: "開始遊戲!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        keyInController.addAction(okAction)
        self.present(keyInController, animated: true)
    }
    //點擊一次RewindButton之後，將變成往上一步，點擊兩次之後重新歸0
    //@IBAction func clickTheRewindButton(_ sender: UIButton) {

    //}
}

