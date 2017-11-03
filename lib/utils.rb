def set_interval(seconds)
  Thread.new do
    loop do
      sleep seconds
      yield
    end
  end
end
