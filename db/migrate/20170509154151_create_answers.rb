class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table(:answers) do |a|
      a.column(:response, :string)

      a.timestamps()
    end
  end
end
