require("sinatra/activerecord")
require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/answer")
require("./lib/question")
require("pg")

get("/") do
  erb(:index)
end

get('/questions') do
  @questions = Question.all()
  erb(:questions)
end

get('/questions/new') do
  @questions = Question.all()
  erb(:questions)
end

get('/questions/:id') do
  @question = Question.find(params.fetch("id").to_i())
  @answers = @question.answers()
  # @answers.save()
  erb(:question)
end

post('/answer/:id') do
  id = params.fetch('id').to_i
  @question = Question.find(id)
  response = params.fetch("response")
  @question.answers().create({:response => response})
  # @question.answers().new({:prompt => prompt})
  # @question.save()
  @answers = Answer.all()
  # @answers.save()
  erb(:success)
end

post('/questions') do
  prompt = params.fetch('prompt')
  question = Question.new({:prompt => prompt})
  question.save()
  erb(:designer_success)
end

get('/questions/:id/edit') do
  @question = Question.find(params.fetch("id").to_i())
  @answers = @question.answers()
  erb(:question)
end


#BELOW WAS A MAJOR HEADACHE
post('/answers/:id') do
  id = params.fetch('id')
  @question = Question.find(id)
  prompt = params.fetch("prompt")
  @question.answers().create({:response => prompt})
  # @question.answers().new({:prompt => prompt})
  # @question.save()
  @answers = Answer.all()
  erb(:success)
end

#ABOVE WAS A MAJOR HEADACH
get('/answers/:id/edit') do
  @answer = Answer.find(params.fetch('id').to_i())
  erb(:answer_edit)
end

patch("/answers/:id") do
  prompt = params.fetch("prompt")
  @answer = Answer.find(params.fetch("id").to_i())
  @answer.update({:prompt => prompt})
  @answers = Answer.all()
  erb(:index)
end

get("/quetions/:id/edit") do
  @question = Question.find(params.fetch("id").to_i())
  erb(:questions)
end

get("/question_edit") do
  @question = Question.find(params.fetch('id').to_i())
  erb(:question_edit)
end

patch("/questions/:id") do
  name = params.fetch("prompt")
  @question = Question.find(params.fetch("id").to_i())
  @question.update({:prompt => name})
  erb(:questions)
end
