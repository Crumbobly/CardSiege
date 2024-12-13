shader_type canvas_item;

uniform float outerRadius : hint_range(0.0, 5.0) = 1.0;
uniform float MainAlpha : hint_range(0.0, 1.0) = 1.0;

void fragment() {
    // Координаты для виньетки
    float x = abs(UV.x - 0.5) * 2.0;
    float y = abs(UV.y - 0.5) * 2.0;
    float vignette = sqrt(x * x + y * y) / outerRadius;
    
    // Получение исходного цвета пикселя с учетом self_modulate
    vec4 tex_color = texture(TEXTURE, UV) * COLOR;

    // Интенсивность виньетки
    float alpha = clamp(1.0 - vignette, 0.0, 1.0) * MainAlpha;
    
    // Применение виньетки, сохраняя self_modulate
    COLOR = mix(tex_color, vec4(0, 0, 0, tex_color.a), 1.0 - alpha);
}
