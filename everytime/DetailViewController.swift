//
//  DetailViewController.swift
//  everytime
//
//  Created by 차윤범 on 2022/07/24.
//

import Foundation
import UIKit

final class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    private let texts = [
        """
        윈도우 노트북 쓰는데 갑자기 이상해졌어요
        바탕화면에 있는 거 삭제하면 아이콘은 그대로 남아 있고, 실행하려고 하면 이미 삭제된 파일이라고 떠요
        폴더나 파일 이름을 바꾸려고 하면 그 위치에 없는 파일이라면서 안 돼요
        크롬에서 다운로드한 파일 바탕화면으로 가게 해놨는데 바탕화면에서 안 보여요
        """,
        "오늘 컴구 첫수업 듣고 고민하는 사람 얼마나 있냐",
        "요즘 D.P 이야기 많이하길래 dynamic programming이 대중의 수면위로 올라온줄안 애붕이 있나?",
        """
        윈도우 노트북 쓰는데 갑자기 이상해졌어요
        바탕화면에 있는 거 삭제하면 아이콘은 그대로 남아 있고, 실행하려고 하면 이미 삭제된 파일이라고 떠요
        폴더나 파일 이름을 바꾸려고 하면 그 위치에 없는 파일이라면서 안 돼요
        크롬에서 다운로드한 파일 바탕화면으로 가게 해놨는데 바탕화면에서 안 보여요
        """,
        "오늘 컴구 첫수업 듣고 고민하는 사람 얼마나 있냐",
        "요즘 D.P 이야기 많이하길래 dynamic programming이 대중의 수면위로 올라온줄안 애붕이 있나?",
    ]
    
    
    private let replyTextView = ReplyTextView()
    private let mainViewController = MainViewController()
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.replyTextView)
//        self.tableView.setContentHuggingPriority(.defaultLow, for: .vertical)
//
//        self.replyTextView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.replyTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
          
            self.replyTextView.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 8),
            self.replyTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            self.replyTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            self.replyTextView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            
            //self.replyTextView.heightAnchor.constraint(equalToConstant: 44)
            
        ])
        self.tableView.backgroundColor = .white
        
        self.navigationItem.titleView = NavigationTitleView()
        self.tableView.register(DetailContentView.self, forHeaderFooterViewReuseIdentifier: "DetailContentView")
        self.tableView.register(DetailReplyCell.self, forCellReuseIdentifier: "DetailReplyCell")
        self.tableView.reloadData()
        self.tableView.separatorStyle = .none
        self.tableView.layoutIfNeeded()

        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "more_title"), style: .plain, target: self, action: nil)
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
        
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
        
    
    
    private func setupGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tap)
      }
      
      @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        view.endEditing(true)
      }
      
      private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
      }
      
      private func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
      }
      
      @objc func keyboardWillShow(_ notificatoin: Notification) {
        let duration = notificatoin.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notificatoin.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let keyboardSize = (notificatoin.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let height = keyboardSize.height - view.safeAreaInsets.bottom
        
          UIView.animate(withDuration: duration){
             
              self.view.layoutIfNeeded()
          }
        /*
            애니메이션 처리
        */
      }
      
      @objc func keyboardWillHide(_ notificatoin: Notification) {
        
        let duration = notificatoin.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notificatoin.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        
          UIView.animate(withDuration: duration){
             
              self.view.layoutIfNeeded()
          }
        /*
            애니메이션 처리
        */
      }
    
    @objc func viewDidTap(gesture: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.texts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailReplyCell", for: indexPath) as! DetailReplyCell
        cell.setupData(text: self.texts[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DetailContentView") as! DetailContentView
       
        return view
    }
    
    
    
}
