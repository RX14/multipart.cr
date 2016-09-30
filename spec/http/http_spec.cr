require "../spec_helper"

describe HTTP do
  it "parses RFC1123 without day name" do
    time = Time.new(1994, 11, 6, 8, 49, 37)
    HTTP.parse_time("06 Nov 1994 08:49:37 GMT").should eq(time)
  end

  describe ".dequote_string" do
    it "dequotes a string" do
      HTTP.dequote_string(%q(foo\"\\bar\ baz\\)).should eq(%q(foo"\bar baz\))
    end
  end
end
