class Question < ActiveRecord::Base
  has_many(:answers)
  validates(:prompt, {:presence => true, :length => {:maximum => 500}})
  before_save(:capitalize_prompt)

  private

  define_method(:capitalize_prompt) do
    self.prompt=(prompt().capitalize())
  end
end
