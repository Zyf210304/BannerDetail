//
//  Home.swift
//  BannerDetail
//
//  Created by 张亚飞 on 2022/3/31.
//

import SwiftUI

struct Home: View {
    
    //Mark: Animated View Properties
    @State var currentIndex: Int = 0
    @State var currentTab: String = "Films"
    
    //Mark : detal view properties
    @State var detailMovie: Movie?
    @State var showDetailView: Bool = false
    //FOR MATCHED CEOMETRY EFFECT STORING CURRENT CARD SIZE
    @State var currentCardSize: CGSize = .zero
    
    //Environment Values
    @Environment(\.colorScheme) var scheme
    @Namespace var animation
    
    var body: some View {
        
        ZStack {
            
            //BG
            BGView()
            
            //Mark Main View Content
            VStack {
                
                //custom Nav Bar
                NavBar()
                
                //Check out the Snap Carousel Video
                SnapCarousel(spacing: 20, trailingSpace: 110, index: $currentIndex, items: movies) { movie in
                    
                    GeometryReader { proxy in
                        
                        let size = proxy.size
                        
                        Image(movie.artwork)
                            .resizable()
                        //fill改成fit bug没了 但是还是不懂为什么好了
                            .aspectRatio(contentMode: .fit)
                            .frame(width: size.width, height: size.height)
                            .cornerRadius(15)
                            .matchedGeometryEffect(id: movie.id ,in: animation)
                        //在一个图片上 点击图片 上半部分没问题 下半部分显示下一个的详情
                            .onTapGesture {
                                
                                print(movie.artwork)
                                
                                currentCardSize = size
                                detailMovie = movie
                                withAnimation(.easeInOut) {
                                    
                                    print(movie.movieTitle)
                                    showDetailView = true
                                }
                            }
                    }
                    //since carousel is moved the current card to a little bit up
                    //using padding to aviod the undercovering the top element
                    .padding(.top, 70)
                }
                
                // cursom indicator
                CustomIndictor()
                
                HStack {
                    
                    Text("Popular")
                        .font(.title3.bold())
                        
                    Spacer()
                    
                    Button("See More"){}
                        .font(.system(size: 16, weight: .semibold))
                }
                .padding()
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 15) {
                        
                        ForEach(movies){ movie in
                            
                            Image(movie.artwork)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 120)
                                .cornerRadius(15)
                        }
                    }
                }
            }
            .overlay {
                
                if let movie = detailMovie, showDetailView {
                    
                    DetailView(movie: movie, showDetailView: $showDetailView, detailMovie: $detailMovie, currentCardSize: $currentCardSize, animation: animation)
                    
                }
            }
        }
    }
    
    //MARK: Custom Indicator
    @ViewBuilder
    func CustomIndictor()-> some View {
        
        HStack(spacing:5) {
            
            ForEach(movies.indices, id: \.self) { index in
                
                Circle()
                    .fill(currentIndex == index ? .blue : .gray.opacity(0.5))
                    .frame(width: currentIndex == index ? 10 : 6, height: currentIndex == index ? 10 : 6)
                
            }
        }
        .animation(.easeInOut, value: currentIndex)
    }
    
    
    //MARK: Custom Nav Bar
    @ViewBuilder
    func NavBar() -> some View {
        
        HStack(spacing:0) {
            
            ForEach(["Films", "Localities"], id: \.self) { tab in
                
                Button {
                    
                    withAnimation {
                        
                        currentTab = tab
                    }
                    
                } label: {
                    
                    Text(tab)
                        .foregroundColor(.white)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 20)
                        .background{
                            if currentTab == tab {

                                Capsule()
                                    .fill(.regularMaterial)
                                    .environment(\.colorScheme, .dark)
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                }

            }
        }
        .padding()
    }
    
    //MARK: Blurred BG
    @ViewBuilder
    func BGView() -> some View {
        
        GeometryReader { proxy in
            
//            let size = proxy.size
            TabView(selection: $currentIndex) {
                
                ForEach(movies.indices, id: \.self) { index in
                    
                    Image(movies[index].artwork)
                        .resizable()
                        .aspectRatio(contentMode: ContentMode.fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut, value: currentIndex)
            
            let color: Color = (scheme == .dark ? .black : .white)
            //Custom gradient
            LinearGradient(colors: [
                .black,
                .clear,
                color.opacity(0.15),
                color.opacity(0.5),
                color.opacity(0.8),
                color,
                color
            ], startPoint: .top, endPoint: .bottom)
            
            //Blurred overlay
            Rectangle()
                .fill(.ultraThinMaterial)
            
        }
        .ignoresSafeArea()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .preferredColorScheme(.dark)
    }
}
