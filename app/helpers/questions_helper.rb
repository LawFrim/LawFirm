module QuestionsHelper
  def render_question_status(question)
    if question.is_answer
      content_tag(:span,"",:class => "fa fa-lock")
    else
      content_tag(:span,"",:class =>"fa fa-globe")
    end
  end
end
