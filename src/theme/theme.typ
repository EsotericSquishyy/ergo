// Colors
#let env_colors_list  = ("classic", "bw", "bootstrap", "gruvbox_dark")
#let env_colors       = state("theme", "bootstrap")
#let colors_dict      = (:)
#for colors_name in env_colors_list {
  colors_dict.insert(colors_name, json(colors_name + ".json"))
}
#let get_colors(theme_name, env_name, color_name, default: rgb("#000000")) = {
  if(theme_name in colors_dict) {
    if(env_name in colors_dict.at(theme_name)) {
      if(color_name in colors_dict.at(theme_name).at(env_name)) {
        return rgb(colors_dict.at(theme_name).at(env_name).at(color_name))
      }
    }
  }
  return default
}
#let ratios(theme_name, env_name, parameter_name) = {
  return float(colors_dict.at(theme_name).at(env_name).at(parameter_name)) * 100%
}
#let get_page_color(theme_name) = {
  return get_colors(theme_name, "opts", "fill", default: rgb("#ffffff"))
}
#let get_text_color(theme_name, kind) = {
  if (kind == 1) {
    return get_colors(theme_name, "opts", "text1", default: rgb("#000000"))
  } else if (kind == 2) {
    return get_colors(theme_name, "opts", "text2", default: rgb("#ffffff"))
  }
}


// Header Styling
#let env_headers_list = ("tab", "classic")
#let env_headers      = state("headers", "tab")
