//
//  ViewController.swift
//  ParseJSONFromFile
//
//  Created by Tran Quoc Bao on 11/20/17.
//  Copyright © 2017 Sutrix Solutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // MARK: IBOutlets
  @IBOutlet var minnaLessonTableView: UITableView!
  
  // MARK: Variables
  var minnaNihongoLessons: [NekoModel]!
  
  struct StoryBoard {
    static let minnaNihongoCellIdentifier = "MinnaNihongoCellIdentifier"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.initView()
    self.readDataFromJSONFile(fileName: "Neko-Minna-Nihongo-Lesson-01") { error in
      if let error = error {
        print(error)
      } else {
        self.minnaLessonTableView.reloadData()
      }
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // MARK: Functions
  func readDataFromJSONFile(fileName: String, completion: (Error?) -> ()) {
    guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else { return }
    let url = URL(fileURLWithPath: path)
    do {
      let data = try Data(contentsOf: url)
      do {
        let minnaNihongoData = try JSONDecoder().decode([NekoModel].self, from: data)
        self.minnaNihongoLessons = [NekoModel]()
        for minnaItem in minnaNihongoData {
          self.minnaNihongoLessons.append(minnaItem)
        }
        completion(nil)
      } catch let error {
        completion(error)
      }
    } catch let error {
      completion(error)
    }
  }

  func initView() {
    self.minnaLessonTableView.estimatedRowHeight = 500
    self.minnaLessonTableView.rowHeight = UITableViewAutomaticDimension
  }
  
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.minnaNihongoLessons.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.minnaNihongoCellIdentifier, for: indexPath)
    let minnaLesson = self.minnaNihongoLessons[indexPath.row]
    let minnaLessString = """
                            Japanese: "\(minnaLesson.nekoJapanese)"
                            Latin: "\(minnaLesson.nekoLatin)"
                            Kanji: "\(minnaLesson.nekoKanji)"
                            KanjiHanViet: "\(minnaLesson.nekoKanjiHanViet)"
                            VietNamese: "\(minnaLesson.nekoVietNamese)"
                            English: "\(minnaLesson.nekoEnglish)"
                            Sound: "\(minnaLesson.nekoSound)"
                          """
    if let label = cell.viewWithTag(100) as? UILabel {
      label.text = minnaLessString
    }
    return cell
  }
}

