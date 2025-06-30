//
//  CustomTabbarView.swift
//  SwiftfullThinkingAdvancedLearning
//
//  Created by Akram Husseini on 23/06/2025.
//

import SwiftUI

struct CustomTabbarView: View {
    
    let tabs: [TabBarItem]
    @Binding var seleciton: TabBarItem
    @Namespace private var namespace
    @State var localSelection: TabBarItem
    
    var body: some View {
        tabBarVersion2
            .onChange(of: seleciton) { oldValue, newValue in
                withAnimation {
                    localSelection = newValue
                }

            }
    }
}

#Preview {
    
    let tabs: [TabBarItem] = [
        .home,  .favorites,.profile
    ]
    VStack {
        Spacer()
        CustomTabbarView(tabs: tabs, seleciton: .constant(tabs.first!), localSelection: tabs.first!)
    }
}


extension CustomTabbarView {
    
    private func tabVIew(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
            Text(tab.title)
                .font(
                    .system(
                        size: seleciton == tab ? 11 : 10,
                        weight: seleciton == tab ? .bold : .regular,
                        design: .rounded
                    )
                )
        }
        .foregroundColor(localSelection == tab ?  tab.color : Color.gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(localSelection == tab ? tab.color.opacity(0.2) : Color.clear)
        .cornerRadius(10)
    }
    
    private func swifthToTab(newTab: TabBarItem) {
            seleciton = newTab
    }
    
    private var tabBarVersion1: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
            tabVIew(tab: tab)
                    .onTapGesture {
                        swifthToTab(newTab: tab)
                    }
            }
        }
        .padding(6)
        .background(Color.white.ignoresSafeArea(edges: .bottom))
    }
    
}

extension CustomTabbarView {
    
    private func tabView2(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
            Text(tab.title)
                .font(
                    .system(
                        size: seleciton == tab ? 11 : 10,
                        weight: seleciton == tab ? .bold : .regular,
                        design: .rounded
                    )
                )
        }
        .foregroundColor(localSelection == tab ?  tab.color : Color.gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(alignment: .bottom) {
            ZStack {
                if localSelection == tab {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(tab.color)
                        .frame(width: 30, height: 3)
                        .matchedGeometryEffect(id: "background_rectangle", in: namespace)
                        .padding(.bottom, 0)
                }
            }
        }
    }
    
    private var tabBarVersion2: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
            tabView2(tab: tab)
                    .onTapGesture {
                        swifthToTab(newTab: tab)
                    }
            }
        }
        .padding(6)
        .background(Color.white.ignoresSafeArea(edges: .bottom))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
    
}

