class String
  def ask
    StringAsk.new(self)
  end
end

class StringAsk < String
  def method_missing(m)
    m.to_s == "parent" ? self.class.superclass : m.to_s.chop == self
  end
end
