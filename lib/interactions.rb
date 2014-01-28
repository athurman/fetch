module Interaction
  def self.ask question
    puts question
    return $stdin.gets.chomp
  end

  def self.tell statement
    puts statement
  end
end