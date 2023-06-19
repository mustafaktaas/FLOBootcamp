//
//  Author.swift
//  UnluAlintilarOdev
//
//  Created by Mustafa Aktas on 19.06.2023.
//

import Foundation

struct Quote {
    let quote: String
    let authorName: String
    let gender: String
}

let quotes: [Quote] = [
    Quote(quote: "I'm not here to be perfect, I'm here to be real.", authorName: "Lady Gaga", gender: "Woman"),
    Quote(quote: "I'm not interested in money. I just want to be wonderful.", authorName: "Marilyn Monroe", gender: "Woman"),
    Quote(quote: "The only thing that feels better than winning is winning when nobody thought you could.", authorName: "Hank Aaron", gender: "Male"),
    Quote(quote: "Success is not final, failure is not fatal: It is the courage to continue that counts.", authorName: "Winston Churchill", gender: "Male"),
    Quote(quote: "If you can dream it, you can do it.", authorName: "Walt Disney", gender: "Male"),
    Quote(quote: "If you want something done, ask a busy person to do it.", authorName: "Laura Ingalls Wilder", gender: "Woman"),
    Quote(quote: "If your actions inspire others to dream more, learn more, do more and become more, you are a leader.", authorName: "John Quincy Adams", gender: "Male"),
    Quote(quote: "The best way to find out if you can trust somebody is to trust them.", authorName: "Ernest Hemingway", gender: "Male"),
    Quote(quote: "The only Limit to our realization of tomorrow will be our doubts of today.", authorName: "Franklin D. Roosevelt", gender: "Male"),
    Quote(quote: "We may encounter many defeats but we must not be defeated.", authorName: "Maya Angelou", gender: "Woman"),
    Quote(quote: "The most important thing is to enjoy your life - to be happy - it's all that matters.", authorName: "Steve Jobs", gender: "Male"),
    Quote(quote: "Your time is limited, don't waste it living someone else's life.", authorName: "Steve Jobs", gender: "Male"),
    Quote(quote: "The best way to find out what you want in life is to try a lot of things.", authorName: "Oprah Winfrey", gender: "Woman"),
    Quote(quote: "In order to be truly happy, you must pursue your dreams and goals.", authorName: "Oprah Winfrey", gender: "Woman"),
    Quote(quote: "You can have anything you want if you are willing to give up everything you have.", authorName: "Oprah Winfrey", gender: "Woman"),
    Quote(quote: "Don't let anyone tell you what you can't do. Follow your dreams and persist.", authorName: "Barack Obama", gender: "Male"),
    Quote(quote: "If you want something you've never had, you must be willing to do something you've never done.", authorName: "Unknown", gender: "Unknown"),
    Quote(quote: "Everything happens for a reason.", authorName: "Unknown", gender: "Unknown"),
    Quote(quote: "You only live once, but if you do it right, once is enough.", authorName: "Mae West", gender: "Woman"),
    Quote(quote: "Life is what we make it and how we make it – whether we realize it or not.", authorName: "Napoleon Hill", gender: "Male"),
    Quote(quote: "The road to success is always under construction.", authorName: "Lily Tomlin", gender: "Woman"),
    Quote(quote: "I'm not a self-made man. I've had a lot of help.", authorName: "Stan Lee", gender: "Male"),
    Quote(quote: "If you don't build your dream, someone else will hire you to help them build theirs.", authorName: "Tony Gaskins", gender: "Male"),
    Quote(quote: "You've got to be in it to win it.", authorName: "Tony Robbins", gender: "Male"),
    Quote(quote: "Success is stumbling from failure to failure with no loss of enthusiasm.", authorName: "Winston Churchill", gender: "Male"),
    Quote(quote: "People often say that motivation doesn't last. Well, neither does bathing. That's why we recommend it daily.", authorName: "Zig Ziglar", gender: "Male"),
    Quote(quote: "If you want to make your dreams come true, the first thing you have to do is wake up.", authorName: "J.M. Power", gender: "Male"),
    Quote(quote: "The only limit to our realization of tomorrow will be our doubts of today.", authorName: "Franklin D. Roosevelt", gender: "Male"),
    Quote(quote: "We may encounter many defeats but we must not be defeated.", authorName: "Maya Angelou", gender: "Woman"),
    Quote(quote: "Be persistent and never give up hope.", authorName: "George Lucas", gender: "Male"),
    Quote(quote: "The best way to find out if you can trust somebody is to trust them.", authorName: "Ernest Hemingway", gender: "Male"),
    Quote(quote: "The only way to do great work is to love what you do.", authorName: "Steve Jobs", gender: "Male"),
    Quote(quote: "If you want to live a happy life, tie it to a goal, not to people or things.", authorName: "Albert Einstein", gender: "Male"),
    Quote(quote: "If you can't handle me at my worst, then you sure as hell don't deserve me at my best.", authorName: "Marilyn Monroe", gender: "Woman"),
    Quote(quote: "I can't change the direction of the wind, but I can adjust my sails to always reach my destination.", authorName: "Jimmy Dean", gender: "Male"),
    Quote(quote: "The only Limit to our realization of tomorrow will be our doubts of today.", authorName: "Franklin D. Roosevelt", gender: "Male"),
    Quote(quote: "Don't let yesterday take up too much of today.", authorName: "Will Rogers", gender: "Male"),
    Quote(quote: "It is never too late to be what you might have been.", authorName: "George Eliot", gender: "Male"),
    Quote(quote: "Don't walk in front of me; I may not follow. Don't walk behind me; I may not lead. Walk beside me; just be my friend.", authorName: "Albert Camus", gender: "Male"),
    Quote(quote: "I can accept failure, everyone fails at something. But I can't accept not trying.", authorName: "Michael Jordan", gender: "Male"),
    Quote(quote: "I have a dream.", authorName: "Martin Luther King Jr.", gender: "Male"),
    Quote(quote: "The greatest glory in living lies not in never falling, but in rising every time we fall.", authorName: "Nelson Mandela", gender: "Male"),
    Quote(quote: "The way to get started is to quit talking and begin doing.", authorName: "Walt Disney", gender: "Male"),
    Quote(quote: "So we beat on, boats against the current, borne back ceaselessly into the past.", authorName: "F. Scott Fitzgerald", gender: "Male"),
    Quote(quote: "A journey of a thousand miles begins with a single step.", authorName: "Lao Tzu", gender: "Male"),
    Quote(quote: "Don't judge each day by the harvest you reap but by the seeds that you plant.", authorName: "Robert Louis Stevenson", gender: "Male"),
    Quote(quote: "If you want to make your dreams come true, the first thing you have to do is wake up.", authorName: "J.M. Power", gender: "Male"),
    Quote(quote: "I can't change the direction of the wind, but I can adjust my sails to always reach my destination.", authorName: "Jimmy Dean", gender: "Male"),
    Quote(quote: "Believe you can and you're halfway there.", authorName: "Theodore Roosevelt", gender: "Male"),
    Quote(quote: "The best and most beautiful things in the world cannot be seen or even heard, but must be felt with the heart.", authorName: "Helen Keller", gender: "Woman")
]

extension Quote {
    static func randomQuote() -> Quote {
        let randomIndex = Int.random(in: 0..<quotes.count)
        return quotes[randomIndex]
    }
}
