def my_delegate(*m, to:)
  if to[0] == "@"
    m.each do |met|
      define_method(met) do |*args, &block|
        instance_variable_get(to).send(met, *args, &block)
      end
    end
  else
    m.each do |met|
      define_method(met) do |*args, &block|
        self.send(to).send(met, *args, &block)
      end
    end
  end
end
