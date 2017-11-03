def set_interval(interval)
  Thread.new do
    loop do
      sleep interval
      yield
    end
  end
end
