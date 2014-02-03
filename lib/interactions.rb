module Interactions
  def ask question
    puts question
    return $stdin.gets.chomp
  end

  def tell statement
    puts statement
  end

  def give_options(question, choice_array)
    question = question + "\n"
    choice_array.each_with_index do |choice, i|
      if choice.is_a?(Role) || choice.is_a?(Breed)
        question << "#{i+1}. #{choice.name}\n"
      else
        question << "#{i+1}. #{choice}\n"
      end
    end
    answer = ask(question)
    chosen_option = choice_array[answer.to_i - 1]
  end
end
