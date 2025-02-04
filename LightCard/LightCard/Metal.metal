//
//  Metal.metal
//  LightCard
//
//  Created by Minsang Choi on 2/3/25.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI.h>
using namespace metal;

[[ stitchable ]] half4 splash(float2 position, SwiftUI::Layer l, float4 boundingRect, float2 dragp, float strength) {
    
    float2 size = float2(boundingRect[2],boundingRect[3]);
    float2 uv = position / size;
    float2 udp = dragp / size;
    float2 d = uv - udp;
    float radius = strength;
    float curl = 0.1;
    
    float2 force = 0.5 * d;
    force /= length(force) + 0.0001;
    force *= curl * d.x;
    force.y *= 0.5;

    
    float2 newpos = uv;
    
    half3 color = l.sample(newpos * size).rgb;

    half3 splat = exp(-dot(d, d) / radius) * color;
    half3 newcolor = color + splat;
        

    return half4(newcolor,1);
}
