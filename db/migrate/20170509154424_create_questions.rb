class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table(:questions) do |q|
      q.column(:prompt, :string)
      q.column(:done, :boolean)

      q.timestamps()
    end
  end
end
