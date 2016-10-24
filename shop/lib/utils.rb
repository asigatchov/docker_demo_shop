# encoding: UTF-8
module Utils
  def self.translit(text)
    equivalent = {
    "А"=>"a","Б"=>"b","В"=>"v","Г"=>"g",
    "Д"=>"d","Е"=>"e", "Ё"=> 'e', "Ж"=>"j","З"=>"z","И"=>"i",
    "Й"=>"y","К"=>"k","Л"=>"l","М"=>"m","Н"=>"n",
    "О"=>"o","П"=>"p","Р"=>"r","С"=>"s","Т"=>"t",
    "У"=>"u","Ф"=>"f","Х"=>"h","Ц"=>"ts","Ч"=>"ch",
    "Ш"=>"sh","Щ"=>"sch","Ъ"=>"","Ы"=>"yi","Ь"=>"",
    "Э"=>"e","Ю"=>"yu","Я"=>"ya","а"=>"a","б"=>"b",
    "в"=>"v","г"=>"g","д"=>"d","е"=>"e", 'ё'=>'e', "ж"=>"j",
    "з"=>"z","и"=>"i","й"=>"y","к"=>"k","л"=>"l",
    "м"=>"m","н"=>"n","о"=>"o","п"=>"p","р"=>"r",
    "с"=>"s","т"=>"t","у"=>"u","ф"=>"f","х"=>"h",
    "ц"=>"ts","ч"=>"ch","ш"=>"sh","щ"=>"sch","ъ"=>"y",
    "ы"=>"yi","ь"=>"","э"=>"e","ю"=>"yu","я"=>"ya", 
    " "=> "_", "."=> "", "/"=> "_" 
       }
    translit_text = ""
    text = text.mb_chars.strip.normalize
    k = text.mb_chars.size

    k.times do |i|
        c = text.mb_chars[i].to_s
        translit_text << (equivalent[c].nil? ? c : equivalent[c])
    end
    return translit_text
  end
end

