require("sinatra/activerecord")
require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/answer")
require("./lib/question")
require("pg")

get("/")  do
  erb(:index)
end

get('/designer')  do
  @questions = Question.all()
  erb(:designer)
end

get("/designer/:id") do
  @questions = Question.find(params.fetch("id").to_i())
  erb(:designer)
end

get("/designer/new") do
  erb(:designer)
end

post("/designer") do
  prompt = params.fetch("prompt")
  question = Question.new({:prompt => prompt, :id => nil})
  question.save()
  erb(:designer)
end

patch("/answers/:id") do
  response = params.fetch("response")
  @answer = Answer.find(params.fetch("id").to_i())
  @answer.update({:response => response})
  @answers = Answer.all()
  erb(:designer)
end

post("/survey") do
  response = params.fetch("response")
  question_id = params.fetch("question_id").to_i()
  @question = Question.find(question_id)
  @answer = Answer.new({:response => response, :question_id => question_id})
  @answer.save()
  erb(:survey)
end
