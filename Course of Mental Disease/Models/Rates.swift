//
//  Rates.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 01.04.2025.
//

import Foundation

struct Rates {
    
    enum Apetite: Int8, CustomStringConvertible, Identifiable, CaseIterable {
        
        case absence = -3
        case worse = -2
        case less = -1
        case usual = 0
        case much = 1
        case more = 2
        case excess = 3
        
        var description : String {
            switch self {
            case .absence: return "У меня вообще нет аппетита"
            case .worse: return "Мой аппетит намного меньше обычного"
            case .less: return "Я ем немного меньше обычного"
            case .usual: return "Мой аппетит не изменился"
            case .much: return "Я ем немного больше обычного"
            case .more: return "Мой аппетит намного больше обычного"
            case .excess: return "Я всё время хочу есть"
            }
        }
        var id: Self { self }
    }
    
    enum Sleep: Int8, CustomStringConvertible, Identifiable, CaseIterable {
        
        case absence = -3
        case worse = -2
        case less = -1
        case usual = 0
        case much = 1
        case more = 2
        case excess = 3
        
        var description : String {
            switch self {
            case .absence: return "Я просыпаюсь через каждый час или два"
            case .worse: return "Я сплю намного меньше, чем обычно"
            case .less: return "Я сплю немного меньше обычного"
            case .usual: return "Я сплю так же, как и раньше"
            case .much: return "Я сплю немного больше обычного"
            case .more: return "Я сплю намного больше, чем обычно"
            case .excess: return "Я сплю большую часть дня"
            }
        }
        var id: Self { self }
    }
    
    enum Energy: Int8, CustomStringConvertible, Identifiable, CaseIterable {
        
        case absence = -3
        case worse = -2
        case less = -1
        case usual = 0
        case much = 1
        case more = 2
        case excess = 3
        
        var description : String {
            switch self {
            case .absence: return "У меня ни на что не хватает сил"
            case .worse: return "Мне не хватает сил на очень многое"
            case .less: return "У меня меньше энергии, чем обычно"
            case .usual: return "Я энергичен так же, как всегда"
            case .much: return "У меня больше энергии, чем обычно"
            case .more: return "Меня переполняет энергия"
            case .excess: return "Я постоянно активен и не нуждаюсь в отдыхе"
            }
        }
        var id: Self { self }
    }
    
    enum Libido: Int8, CustomStringConvertible, Identifiable, CaseIterable {
        
        case absence = -3
        case worse = -2
        case less = -1
        case usual = 0
        case much = 1
        case more = 2
        case excess = 3
        
        var description : String {
            switch self {
            case .absence: return "Я полностью утратил сексуальный интерес"
            case .worse: return "Сейчас секс интересует меня гораздо меньше"
            case .less: return "Секс интересует меня меньше, чем обычно"
            case .usual: return "Я не заметил изменений в интересе к сексу"
            case .much: return "Секс интересует меня больше, чем обычно"
            case .more: return "Я проявляю большую сексуальную активность"
            case .excess: return "Я чувствую выраженную гиперсексуальность"
            }
        }
        var id: Self { self }
    }

}
