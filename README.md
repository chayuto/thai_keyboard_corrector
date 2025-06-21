# 🇹🇭 Thai Keyboard Corrector – แก้ไขข้อความไทยพิมพ์ผิด

**Thai Keyboard Corrector** (TKC) แก้ปัญหาการพิมพ์ **สลับแป้น** ระหว่างแป้นพิมพ์ภาษาไทยเกษมณี (Thai Kedmanee) และแป้นภาษาอังกฤษ QWERTY  
ตัวอย่าง `l;ylfu` ➜ **สวัสดี** │ `ฟหกด` ➜ **asdf**

---

## Features

|  |  |
|---------|---------|
| Detects text that *looks* like **Thai-in-English** (`:thai_in_en`) or **English-in-Thai** (`:en_in_th`). | ตรวจจับข้อความที่พิมพ์สลับแป้น ทั้ง ไทยในอังกฤษ และ อังกฤษในไทย |
| Converts both directions with a **fixed key-position map** (no locale files). | แปลงกลับได้ทั้งสองทางด้วยตารางแมปคีย์ถาวร |
| **Pure Ruby, zero dependencies** – works ≥ Ruby 2.7. | เขียนด้วย Ruby ล้วน ๆ ไม่พึ่งไลบรารีภายนอก |
| Offers a **clean Ruby API** *and* a **CLI tool** (`thai_kbd_correct`). | ใช้ง่ายผ่านโค้ด Ruby หรือ CLI |

---

## Installation

```bash
gem install thai_keyboard_corrector
```

(หรือเพิ่ม `gem "thai_keyboard_corrector"` ใน Gemfile)

---

## Usage – Ruby API

```ruby
require "thai_keyboard_corrector"

# 1. Auto-correct if layout seems wrong
ThaiKeyboardCorrector.correct("l;ylfu")   # => "สวัสดี"
ThaiKeyboardCorrector.correct("้รทัืฟทำ รห")     # => "himyname is"

# 2. Detect layout (returns a Symbol)
ThaiKeyboardCorrector.detect_layout("้รทัืฟทำรห")  # => :thai
ThaiKeyboardCorrector.detect_layout("l;ylfu")  # => :thai_in_en
ThaiKeyboardCorrector.detect_layout("ฟหกด")    # => :en_in_th
ThaiKeyboardCorrector.detect_layout("helloส")  # => :mixed
```

### Detection Symbols

| Symbol        | Meaning                                                      |
| ------------- | ------------------------------------------------------------ |
| `:thai`       | Normal Thai text                                             |
| `:en`         | Normal English text                                          |
| `:thai_in_en` | Thai characters typed on **EN** layout (needs flip EN→TH)    |
| `:en_in_th`   | English characters typed on **TH** layout (needs flip TH→EN) |
| `:mixed`      | Contains both Thai & English letters in correct positions    |
| `:unknown`    | Blank or symbols only                                        |

---

## Usage – CLI

```bash
$ thai_kbd_correct "l;ylfu"
สวัสดี

$ echo "ฟหกด" | thai_kbd_correct
asdf
```

Flags:

| Flag    | ใช้ทำอะไร                         |
| ------- | --------------------------------- |
| `-f th` | บังคับแปลง EN→TH (ข้ามการตรวจจับ) |
| `-f en` | บังคับแปลง TH→EN                  |
| `-h`    | แสดงวิธีใช้                       |

---

## 🛠️ Development

```bash
git clone https://github.com/<you>/thai_keyboard_corrector.git
cd thai_keyboard_corrector
bundle install
bundle exec rspec          # ✅  tests should pass
bundle exec rubocop -A     # ✅  style conforms
```

---

## License

© 2025 Chayut Orapinpatipat
Released under the MIT License. See [LICENSE.txt](LICENSE.txt) for details.