module HTTP
  def self.parse_time(time_str : String) : Time?
    {"%a, %d %b %Y %H:%M:%S %z", "%d %b %Y %H:%M:%S %z", "%A, %d-%b-%y %H:%M:%S %z", "%a %b %e %H:%M:%S %Y"}.each do |pattern|
      begin
        return Time.parse(time_str, pattern, kind: Time::Kind::Utc)
      rescue Time::Format::Error
      end
    end

    nil
  end

  # Dequotes a RFC2616 quoted-string
  def self.dequote_string(str)
    data = str.to_slice
    quoted_pair_index = data.index('\\'.ord)
    return str unless quoted_pair_index

    String.build do |io|
      while quoted_pair_index
        io.write(data[0, quoted_pair_index])
        io << data[quoted_pair_index + 1].chr

        data += quoted_pair_index + 2
        quoted_pair_index = data.index('\\'.ord)
      end
      io.write(data)
    end
  end
end
