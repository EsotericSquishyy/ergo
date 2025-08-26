#let ergo-colors-list = ("bootstrap", "bw", "gruvbox-dark", "ayu-light")
#let ergo-colors      = (:)

// Initialize colors
#for colors-name in ergo-colors-list {
  ergo-colors.insert(colors-name, json(colors-name + ".json"))
}

// Helper to check if string is valid color
#let is-hex-color(s) = {
  if not s.starts-with("#") {
    return false
  }
  let hex-part = s.slice(1)
  let len = hex-part.len()
  if not (3, 4, 6, 8).contains(len) {
    return false
  }
  for c in hex-part {
    if not "0123456789abcdefABCDEF".contains(c) {
      return false
    }
  }
  return true
}

// Checks if dict is valid colorscheme
#let valid-colors(colors) = {
  let proof-envs = (
    "theorem",
    "lemma",
    "corollary",
    "proposition",
    "problem",
    "exercise",
  )
  let statement-envs = (
    "note",
    "definition",
    "remark",
    "notation",
    "example",
    "concept",
    "computational-problem",
    "algorithm",
    "runtime",
  )
  let none-or-invalid-color(env-colors, color-name) = {
    let env-color = env-colors.at(color-name, default: none)
    return env-color == none or not is-hex-color(env-color)
  }

  for proof-env in proof-envs {
    let proof-colors = colors.at(proof-env, default: none)
    if proof-colors == none { return false }
    if (none-or-invalid-color(proof-colors, "bgcolor1") or
        none-or-invalid-color(proof-colors, "bgcolor2") or
        none-or-invalid-color(proof-colors, "strokecolor1") or
        none-or-invalid-color(proof-colors, "strokecolor2")) {
      return false
    }
  }

  for statement-env in statement-envs {
    let statement-colors = colors.at(statement-env, default: none)
    if statement-colors == none { return false }
    if (none-or-invalid-color(statement-colors, "bgcolor") or
        none-or-invalid-color(statement-colors, "strokecolor")) {
      return false
    }
  }

  let bookmark-colors = colors.at("bookmark", default: none)
  if bookmark-colors == none { return false }
  if (none-or-invalid-color(bookmark-colors, "bgcolor") or
      none-or-invalid-color(bookmark-colors, "strokecolor")) {
    return false
  }

  // TODO: Raw

  // Optional arguments
  let opts-colors = colors.at("opts", default: none)
  if opts-colors == none { return true }
  if not is-hex-color(opts-colors.at("fill")) { return false }
  if not is-hex-color(opts-colors.at("text1")) { return false }
  if not is-hex-color(opts-colors.at("text2")) { return false }
  if not is-hex-color(opts-colors.at("h1")) { return false }
  if not is-hex-color(opts-colors.at("h2")) { return false }

  return true
}

// Calculates raw ratio based on float
#let get-ratio(colors, env-name, parameter-name) = {
  return float(colors.at(env-name).at(parameter-name)) * 100%
}

// Returns color dict of associated environment
#let get-colors(colors, env-name) = {
  return colors.at(env-name, default: none)
}

// Returns and possibly constructs "opts" color dict
#let get-opts-colors(colors) = {
  let opts = get-colors(colors, "opts")

  let filled-opts = (:)

  if (opts != none) {
    filled-opts.insert("fill",   opts.at("fill",   default: "#ffffff"))
    filled-opts.insert("text1",  opts.at("text1",  default: "#000000"))
    filled-opts.insert("text2",  opts.at("texcolors-dictt2",  default: "#ffffff"))
    filled-opts.insert("h1",     opts.at("h1",     default: "#020004"))
    filled-opts.insert("h2",     opts.at("h2",     default: "#16428e"))
    filled-opts.insert("strong", opts.at("strong", default: "#020004"))
  } else {
    filled-opts.insert("fill",   "#ffffff")
    filled-opts.insert("text1",  "#000000")
    filled-opts.insert("text2",  "#ffffff")
    filled-opts.insert("h1",     "#020004")
    filled-opts.insert("h2",     "#16428e")
    filled-opts.insert("strong", "#020004")
  }

  return filled-opts
}
