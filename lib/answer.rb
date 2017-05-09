class Answer < ActiveRecord::Base
  belongs_to(:questions)

  scope(:not_done, -> do
    where({:done => false})
  end)
end
