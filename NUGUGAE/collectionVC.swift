//
//  collectionVC.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/07/25.
//

import UIKit

class collectionVC: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    private var diaryList = [Diary]() {
        didSet {
            self.saveDiaryList()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        self.loadDiaryList()
    }
    
    private func configureCollectionView() {
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let wireDiaryViewContoller = segue.destination as? WriteDiaryViewController {
        wireDiaryViewContoller.delegate = self
    }
}

    private func saveDiaryList() {
      let date = self.diaryList.map {
        [
          "title": $0.title,
          "contents": $0.contents,
          "date": $0.date,
          "isStar": $0.isStar
        ]
      }
      let userDefaults = UserDefaults.standard
      userDefaults.set(date, forKey: "diaryList")
    }

    private func loadDiaryList() {
      let userDefaults = UserDefaults.standard
      guard let data = userDefaults.object(forKey: "diaryList") as? [[String: Any]] else { return }
      self.diaryList = data.compactMap {
        guard let title = $0["title"] as? String else { return nil }
        guard let contents = $0["contents"] as? String else { return nil }
        guard let date = $0["date"] as? Date else { return nil }
        guard let isStar = $0["isStar"] as? Bool else { return nil }
        return Diary(title: title, contents: contents, date: date, isStar: isStar)
      }
      self.diaryList = self.diaryList.sorted(by: {
        $0.date.compare($1.date) == .orderedDescending
      })
    }
    private func dateToString(date: Date) -> String {
      let formatter = DateFormatter()
      formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
      formatter.locale = Locale(identifier: "ko_KR")
      return formatter.string(from: date)
    }
}

extension ViewController: UICollectionViewDataSource{
    //collection뷰 위치에 표시할 셀을 표시하는 메소드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.diaryList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiaryCell", for: indexPath) as? DiaryCell else { return UICollectionViewCell() }
        let diary = self.diaryList[indexPath.row]
        cell.titleLable.text = diary.title
        cell.dateLable.text = self.dateToString(date: diary.date)
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (UIScreen.main.bounds.width / 2) - 20, height: 200)
  }
}

extension ViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let viewContoller = self.storyboard?.instantiateViewController(identifier: "DiaryDetailViewController") as? DiaryDetailViewController else { return }
    let diary = self.diaryList[indexPath.row]
    viewContoller.diary = diary
    viewContoller.indexPath = indexPath
    viewContoller.delegate = self
    self.navigationController?.pushViewController(viewContoller, animated: true)
  }
}

extension ViewController: WriteDiaryViewDelegate {
  func didSelectReigster(diary: Diary) {
    self.diaryList.append(diary)
    self.diaryList = self.diaryList.sorted(by: {
      $0.date.compare($1.date) == .orderedDescending
    })
    self.collectionView.reloadData()
  }
}
extension ViewController: DiaryDetailViewDelegate {
    func didSelectDelegate(indexPath: IndexPath) {
        self.diaryList.remove(at: indexPath.row)
        self.collectionView.deleteItems(at: [indexPath])
    }
}
import UIKit

class ViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    private var diaryList = [Diary]() {
        didSet {
            self.saveDiaryList()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        self.loadDiaryList()
    }
    
    private func configureCollectionView() {
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let wireDiaryViewContoller = segue.destination as? WriteDiaryViewController {
        wireDiaryViewContoller.delegate = self
    }
}

    private func saveDiaryList() {
      let date = self.diaryList.map {
        [
          "title": $0.title,
          "contents": $0.contents,
          "date": $0.date,
          "isStar": $0.isStar
        ]
      }
      let userDefaults = UserDefaults.standard
      userDefaults.set(date, forKey: "diaryList")
    }

    private func loadDiaryList() {
      let userDefaults = UserDefaults.standard
      guard let data = userDefaults.object(forKey: "diaryList") as? [[String: Any]] else { return }
      self.diaryList = data.compactMap {
        guard let title = $0["title"] as? String else { return nil }
        guard let contents = $0["contents"] as? String else { return nil }
        guard let date = $0["date"] as? Date else { return nil }
        guard let isStar = $0["isStar"] as? Bool else { return nil }
        return Diary(title: title, contents: contents, date: date, isStar: isStar)
      }
      self.diaryList = self.diaryList.sorted(by: {
        $0.date.compare($1.date) == .orderedDescending
      })
    }
    private func dateToString(date: Date) -> String {
      let formatter = DateFormatter()
      formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
      formatter.locale = Locale(identifier: "ko_KR")
      return formatter.string(from: date)
    }
}

extension collectionVC: UICollectionViewDataSource{
    //collection뷰 위치에 표시할 셀을 표시하는 메소드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.diaryList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiaryCell", for: indexPath) as? DiaryCell else { return UICollectionViewCell() }
        let diary = self.diaryList[indexPath.row]
        cell.titleLable.text = diary.title
        cell.dateLable.text = self.dateToString(date: diary.date)
        return cell
    }
}

extension collectionVC: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (UIScreen.main.bounds.width / 2) - 20, height: 200)
  }
}

extension collectionVC: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let viewContoller = self.storyboard?.instantiateViewController(identifier: "DiaryDetailViewController") as? DiaryDetailViewController else { return }
    let diary = self.diaryList[indexPath.row]
    viewContoller.diary = diary
    viewContoller.indexPath = indexPath
    viewContoller.delegate = self
    self.navigationController?.pushViewController(viewContoller, animated: true)
  }
}

extension collectionVC: WriteDiaryViewDelegate {
  func didSelectReigster(diary: Diary) {
    self.diaryList.append(diary)
    self.diaryList = self.diaryList.sorted(by: {
      $0.date.compare($1.date) == .orderedDescending
    })
    self.collectionView.reloadData()
  }
}
extension collectionVC: DiaryDetailViewDelegate {
    func didSelectDelegate(indexPath: IndexPath) {
        self.diaryList.remove(at: indexPath.row)
        self.collectionView.deleteItems(at: [indexPath])
    }
}
