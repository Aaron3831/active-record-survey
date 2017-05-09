require("sinatra/activerecord")
require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/answer")
require("./lib/question")
require("pg")

get("/") do
  @answers = Answer.all
  erb(:index)
end

get('/designer') do
  @questions = Question.all()
  erb(:designer)
end

get("/questions/new") do
  erb(:question)
end

post("/designer") do
  prompt = params.fetch("prompt")
  question = Question.new({:prompt => prompt, :id => nil})
  question.save()
  erb(:designer_success)
end

get('/answers')do
  @answers = Answer.all()
  erb(:question)
end

get("/questions/:id") do
  @questions = Question.find(params.fetch("id").to_i())
  erb(:answer_form)
end

post('/answers') do
  erb(:designer_success)
end

post('/answers/:id') do
  id = params.fetch('id')
  @question = Question.find(id)
  response = params.fetch("response")
  @question.answers().new({:response => response})
  @question.save()
  @answer = Answer.all()
  erb(:designer_success)
end

get("/questions/:id/edit") do
  @question = Question.find(params.fetch("id").to_i())
  erb(:question_edit)
end

patch("/questions/:id") do
  name = params.fetch("name")
  @question = Question.find(params.fetch("id").to_i())
  @question.update({:name => name})
  erb(:question)
end

delete("/questions/:id") do
  @question = Question.find(params.fetch("id").to_i())
  @question.delete()
  @questions = Question.all()
  erb(:index)
end

get('/answers/:id/edit') do
  @answer = Answer.find(params.fetch("id").to_i())
  erb(:answer_form)
end

patch("/answers/:id") do
  response = params.fetch("response")
  @answer = Answer.find(params.fetch("id").to_i())
  @answer.update({:response => response})
  @answers = Answer.all()
  erb(:index)
end
