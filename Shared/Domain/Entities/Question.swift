//
//  QuestionModel.swift
//  Mini3_AsthmaApp
//
//  Created by Jonathan Aaron Wibawa on 17/08/24.
//

import Foundation

struct Option {
    let text: String
    let score: Int
}

struct Question {
    let text: String
    let options: [Option]
    
    static func generateQuestions() -> [Question] {
        return [
            Question(
                text: "In the past 4 weeks, how often did your asthma prevent you from getting as much done at work, school or at home?",
                options: [
                    Option(text: "All of the time", score: 1),
                    Option(text: "Most of the time", score: 2),
                    Option(text: "Some of the time", score: 3),
                    Option(text: "A little of the time", score: 4),
                    Option(text: "None of the time", score: 5)
                ]
            ),
            Question(
                text: "During the past 4 weeks, how often have you had shortness of breath?",
                options: [
                    Option(text: "More than once a day", score: 1),
                    Option(text: "Once a day", score: 2),
                    Option(text: "3-6 times a week", score: 3),
                    Option(text: "Once or twice a week", score: 4),
                    Option(text: "Not at all", score: 5)
                ]
            ),
            Question(
                text: "During the past 4 weeks, how often did your asthma symptoms wake you up at night?",
                options: [
                    Option(text: "4 or more nights a week", score: 1),
                    Option(text: "2-3 nights a week", score: 2),
                    Option(text: "Once a week", score: 3),
                    Option(text: "Once or twice", score: 4),
                    Option(text: "Never", score: 5)
                ]
            ),
            Question(
                text: "During the past 4 weeks, how often have you used your rescue inhaler or nebulizer medication?",
                options: [
                    Option(text: "Several times per day", score: 1),
                    Option(text: "Once per day", score: 2),
                    Option(text: "2-3 times per week", score: 3),
                    Option(text: "Once per week or less", score: 4),
                    Option(text: "Not at all", score: 5)
                ]
            ),
            Question(
                text: "How would you rate your asthma control during the past 4 weeks?",
                options: [
                    Option(text: "Not controlled", score: 1),
                    Option(text: "Poorly controlled", score: 2),
                    Option(text: "Somewhat controlled", score: 3),
                    Option(text: "Well controlled", score: 4),
                    Option(text: "Completely controlled", score: 5)
                ]
            )
        ]
    }
}



