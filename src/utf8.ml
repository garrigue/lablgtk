
let char n = String.make 1 (Char.chr n)

let utf8 n =
  if 0 <= n && n <= 0x7f then
    char n
  else if 0 <= n && n <= 0x7ff then
    char (0xC0 + (n lsr 6) land 0b11111) ^ 
    char (0x80 + n land 0b111111)
  else if 0 <= n && n <= 0xffff then
    char (0xE0 + (n lsr 12) land 0b1111) ^ 
    char (0x80 + (n lsr 6) land 0b111111) ^
    char (0x80 + n land 0b111111)
  else if 0 <= n && n <= 0x1fffff then
    char (0xF0 + (n lsr 18) land 0b111) ^
    char (0x80 + (n lsr 12) land 0b111111) ^ 
    char (0x80 + (n lsr 6) land 0b111111) ^
    char (0x80 + n land 0b111111)
  else if 0 <= n && n <= 0x3ffffff then
    char (0xf8 + (n lsr 24) land 0b11) ^
    char (0x80 + (n lsr 18) land 0b111111) ^ 
    char (0x80 + (n lsr 12) land 0b111111) ^
    char (0x80 + (n lsr 6) land 0b111111) ^
    char (0x80 + n land 0b111111)
  else
    char (0xfc + (n lsr 30) land 0b1) ^
    char (0x80 + (n lsr 24) land 0b111111) ^ 
    char (0x80 + (n lsr 18) land 0b111111) ^ 
    char (0x80 + (n lsr 12) land 0b111111) ^
    char (0x80 + (n lsr 6) land 0b111111) ^
    char (0x80 + n land 0b111111)

