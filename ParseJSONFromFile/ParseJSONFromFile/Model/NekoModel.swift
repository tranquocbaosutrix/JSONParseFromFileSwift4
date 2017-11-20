//
//  NekoModel.swift
//  ParseJSONFromFile
//
//  Created by Tran Quoc Bao on 11/20/17.
//  Copyright © 2017 Sutrix Solutions. All rights reserved.
//

struct NekoModel: Decodable {
  let nekoJapanese: String
  let nekoLatin: String
  let nekoKanji: String
  let nekoKanjiHanViet: String
  let nekoVietNamese: String
  let nekoEnglish: String
  let nekoSound: String
}

