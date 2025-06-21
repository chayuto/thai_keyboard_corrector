# frozen_string_literal: true

module ThaiKeyboardCorrector
  # Mapping module provides methods to convert between English and Thai characters
  module mapping
    # 1. Base map – lower-case EN → Thai Kedmanee
    BASE = {
      'q' => 'ๆ', 'w' => 'ไ', 'e' => 'ำ', 'r' => 'พ', 't' => 'ะ',
      'y' => 'ั', 'u' => 'ี', 'i' => 'ร', 'o' => 'น', 'p' => 'ย',
      '[' => 'บ', ']' => 'ล',
      'a' => 'ฟ', 's' => 'ห', 'd' => 'ก', 'f' => 'ด', 'g' => 'เ',
      'h' => '้', 'j' => '่', 'k' => 'า', 'l' => 'ส', ';' => 'ว', "'" => 'ง',
      'z' => 'ผ', 'x' => 'ป', 'c' => 'แ', 'v' => 'อ', 'b' => 'ิ',
      'n' => 'ื', 'm' => 'ท', ',' => 'ม', '.' => 'ใ', '/' => 'ฝ'
    }.freeze

    # 2. Shift-layer Thai glyphs → underlying EN key
    SHIFT = {
      # ── Number row (Shift+1 … Shift+0) – Thai digits
      '๑' => '1', '๒' => '2', '๓' => '3', '๔' => '4', '๕' => '5',
      '๖' => '6', '๗' => '7', '๘' => '8', '๙' => '9', '๐' => '0',

      # ── Top-letter row (Q–P)
      'ฃ' => 'w', 'ฅ' => 'e', 'ฆ' => 'r', 'ฑ' => 't', 'ํ' => 'y',
      'ฐ' => 'u', 'ณ' => 'i', 'ญ' => 'o', 'ธ' => 't', # (Shift+T duplicate)

      # ── Home row (A–L)
      'ฤ' => 'a', 'ฦ' => 's', 'ฌ' => 'h', 'ศ' => 'l', 'ษ' => ';', 'ฮ' => "'",

      # ── Bottom row (Z–/)
      'ฒ' => 'z', 'ฬ' => 'x',
      'ฯ' => 'm',  # Thai paiyannoi
      '฿' => '.',  # Baht sign (Shift+.)
      '๏' => '/',  # Thai “head mark”

      # Already mapped earlier (duplicates kept for clarity—harmless):
      '๛' => ',' # end-paragraph mark
    }.freeze

    # 3. Final maps (frozen once, never mutated)
    ENG_TO_THAI = BASE.merge(BASE.transform_keys(&:upcase)).freeze
    THAI_TO_ENG = BASE.invert.merge(SHIFT).freeze

    module_function

    def map_eng_to_thai(str)
      str.chars.map { |c| ENG_TO_THAI.fetch(c, c) }.join
    end

    def map_thai_to_eng(str)
      str.chars.map { |c| THAI_TO_ENG.fetch(c, c) }.join
    end
  end
end
