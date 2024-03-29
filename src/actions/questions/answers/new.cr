class Questions::Answers::New < BrowserAction
  get "/questions/questions/:question_id/answers/new" do
    question = QuestionQuery.new.preload_tags.preload_author.find(question_id)
    html NewPage, operation: SaveAnswer.new, question: question
  end
end
