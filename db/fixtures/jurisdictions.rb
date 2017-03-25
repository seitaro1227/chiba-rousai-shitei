jurisdiction_map = Hash[*%w"chiba 千葉 kashiwa 柏 funabashi 船橋 mobara 茂原 togane 東金 choshi 銚子 narita 成田 kisarazu 木更津"]

jurisdiction_map.each do|roman, name|
  Jurisdiction.seed(:roman) do |s|
    s.roman = roman
    s.name = name
  end
end