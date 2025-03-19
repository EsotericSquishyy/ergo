// Colors
#let env_colors_list  = ("classic", "bw", "bootstrap", "gruvbox_dark")
#let env_colors       = state("theme", "bootstrap")
#let colors_dict      = (:)
#for colors_name in env_colors_list {
  colors_dict.insert(colors_name, json(colors_name + ".json"))
}
#let colors(theme_name, env_name, color_name) = {
  return rgb(colors_dict.at(theme_name).at(env_name).at(color_name))
}
#let ratios(theme_name, env_name, parameter_name) = {
  return float(colors_dict.at(theme_name).at(env_name).at(parameter_name)) * 100%
}
#let get_page_color(theme_name) = {
  return rgb(colors_dict.at(theme_name).at("fill", default: "#fff"))
}
#let get_text_color(theme_name, kind) = {
  if (kind == 1) {
    return rgb(colors_dict.at(theme_name).at("text1", default: "#000"))
  } else if (kind == 2) {
    return rgb(colors_dict.at(theme_name).at("text2", default: "#fff"))
  }
}


// Header Styling
#let env_headers_list = ("tab", "classic")
#let env_headers      = state("headers", "tab")
