# frozen_string_literal: true

module ThaiKeyboardCorrector
  # Mapping module provides methods to convert between English and Thai characters
  module Mapping
    # Base (lower-case) map
    BASE = {
      'q' => 'ๆ', 'w' => 'ไ', 'e' => 'ำ', 'r' => 'พ', 't' => 'ะ',
      'y' => 'ั', 'u' => 'ี', 'i' => 'ร', 'o' => 'น', 'p' => 'ย',
      '[' => 'บ', ']' => 'ล',
      'a' => 'ฟ', 's' => 'ห', 'd' => 'ก', 'f' => 'ด', 'g' => 'เ',
      'h' => '้', 'j' => '่', 'k' => 'า', 'l' => 'ส', ';' => 'ว', "'" => 'ง',
      'z' => 'ผ', 'x' => 'ป', 'c' => 'แ', 'v' => 'อ', 'b' => 'ิ',
      'n' => 'ื', 'm' => 'ท', ',' => 'ม', '.' => 'ใ', '/' => 'ฝ'
    }.freeze

    ENG_TO_THAI = BASE.merge(BASE.transform_keys(&:upcase)).freeze
    THAI_TO_ENG = BASE.invert.freeze # ⇒ always lower-case

    module_function

    def map_eng_to_thai(str)
      str.chars.map { |c| ENG_TO_THAI.fetch(c, c) }.join
    end

    def map_thai_to_eng(str)
      str.chars.map { |c| THAI_TO_ENG.fetch(c, c) }.join
    end
  end
end
