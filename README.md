# Thai Keyboard Corrector

Corrects Thai text typed on the **wrong keyboard layout** (English ↔ Thai Kedmanee).


## Features

* Detects if a string looks like **Thai‑in‑English** or **English‑in‑Thai**.
* Converts both directions using a fixed key‑position map.
* Pure Ruby, zero dependencies.
* CLI + simple Ruby API.

## Installation

```bash
gem install thai_keyboard_corrector
```

## Usage (Ruby)

```ruby
require "thai_keyboard_corrector"

ThaiKeyboardCorrector.correct("l;ylfu")   # => "สวัสดี"
ThaiKeyboardCorrector.detect_layout("สวัสดี") # => :thai
ThaiKeyboardCorrector.detect_layout("l;ylfu") # => :thai_in_en
```

## CLI

```bash
thai_kbd_correct "l;ylfu"
# => สวัสดี
```

## License

MIT © 2025 Your Name
