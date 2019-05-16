class SelfDependencyError < StandardError # The SelfDependencyError inherit from StandardError

  attr_reader :message #access for show the message on error

  def initialize(message)
    @message = message
  end

end

class CircularDependencyError < StandardError # The CircularDependencyError inherit from StandardError

  attr_reader :message #access for show the message on error

  def initialize(message)
    @message = message
  end

end