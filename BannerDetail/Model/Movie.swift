//
//  Movie.swift
//  BannerDetail
//
//  Created by 张亚飞 on 2022/3/31.
//

import SwiftUI

struct Movie : Identifiable {
    
    var id = UUID().uuidString
    var movieTitle: String
    var artwork: String
}

var movies: [Movie] = [

    Movie(movieTitle: "Ad Astra", artwork: "p1"),
    Movie(movieTitle: "Star Wars", artwork: "p2"),
    Movie(movieTitle: "Toys Story 4", artwork: "p3"),
    Movie(movieTitle: "Loin King", artwork: "p4"),
    Movie(movieTitle: "Spider Man No Way Home", artwork: "p5"),
    Movie(movieTitle: "Chang Chi", artwork: "p6"),
    Movie(movieTitle: "Hawkeye", artwork: "p7"),
]

var sampleText = "创作海贼故事是尾田荣一郎长久以来的梦想，他小时候一直很好奇为什么没有什么漫画以海贼为主题，他顶多只知道有《北海小英雄》这部动画。他认为男孩长到某个年纪后应该就会想要出海寻宝才对。尾田从小就很想看海贼的漫画，那个时候他对自己说，如果要自己画的话，那就一定会画海贼的故事。不管作品卖不卖得掉，他都是作好了心理准备才会这么选择的，纯粹就是他自己想看而已。尾田荣一郎在初一时，第一次画了海贼漫画，而尾田对孩子冒险所抱着的想象太丰富，就一本笔记本也画不完。他认识到用“一期完”的形式来画海贼漫画是不可能的，于是他决定要在《少年JUMP》上连载海贼漫画。"
