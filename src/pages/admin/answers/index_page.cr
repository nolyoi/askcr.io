class Admin::Answers::IndexPage < AdminLayout
  include FormattingHelpers
  needs answers : AnswerQuery
  needs pages : Lucky::Paginator
  quick_def page_title, "All Answers"

  def content
    div class: "container mx-auto mt-2 min-h-screen" do
      div class: "w-full max-w-6xl mx-auto" do
        div class: "grid gap-2 sm:grid-cols-1 md:grid-cols-3 lg:grid-cols-3" do
          div class: "sm:col-span-1 md:col-span-3 align-baseline align-middle justify-between items-center" do
            div do
              h1 "All Answers", class: "text-2xl text-gray-800 font-bold align-baseline"
              small "A list of all answers registered in the application."
            end
            mount ::Shared::BackButton
          end
          answers_list
        end
      end
    end
  end

  private def answers_list
    div class: "md:col-span-3" do
      div class: "py-4 mb-4 bg-white dark:bg-gray-800 rounded-lg shadow-md" do
        div class: "grid grid-cols-17 border-b-2 border-gray-300" do
          div class: "col-span-1 mb-3 text-center" do
            span "ID", class: "font-bold text-gray-800"
          end
          div class: "col-span-3 mb-3 truncate" do
            span "Question", class: "font-bold text-gray-800"
          end
          div class: "col-span-4 mb-3 truncate" do
            span "Answer", class: "font-bold text-gray-800"
          end
          div class: "col-span-2 mb-3" do
            span "By", class: "font-bold text-gray-800"
          end
          div class: "col-span-2 mb-3" do
            span "Total Answers", class: "font-bold text-gray-800"
          end
          div class: "has-tooltip inline col-span-1 mb-3 text-center" do
            span "Solution?", class: "font-bold text-gray-800"
          end
          div class: "col-span-3 text-center mb-3 text-center" do
            span "Actions", class: "font-bold text-gray-800"
          end
        end
        answers.each_with_index do |answer, index|
          div class: index % 2 == 0 ? "grid grid-cols-17 py-2 bg-gray-50 border-b border-gray-200 hover:bg-gray-100" : "grid grid-cols-17 py-2 bg-white border-b border-gray-200 hover:bg-gray-100" do
            div class: "col-span-1 mb-2 self-center text-center" do
              span answer.id, class: "text-gray-800"
            end
            div class: "col-span-3 mb-2 self-center text-center" do
              link answer.question.title, to: ::Questions::Show.with(answer.question.id), class: "text-gray-800 hover:text-blue-500"
            end
            div class: "col-span-4 mb-2 self-center truncate" do
              a answer.body, href: "/questions/#{answer.question.id}/#answer-#{answer.question.solution_id}", class: "text-gray-800 hover:text-blue-500"
            end
            div class: "col-span-2 mb-2 self-center" do
              span answer.author.username, class: "text-gray-800"
            end
            div class: "col-span-2 mb-2 self-center" do
              span answer.question.answers.size, class: "text-gray-800 text-center self-center"
            end
            div class: "col-span-1 text-center mb-2 self-center text-center" do
              if answer.solution?
                tag "svg", class: "inline h-5 w-5 text-green-600", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
                  tag "path", d: "M5 13l4 4L19 7", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
                end
              else
                tag "svg", class: "inline h-5 w-5 text-red-300", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
                  tag "path", d: "M6 18L18 6M6 6l12 12", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
                end
              end
            end
            div class: "col-span-3 text-center items-center mb-2 self-center text-center" do
              link to: Admin::Answers::Edit.with(answer.question.id, answer.id), class: "has-tooltip inline-flex  py-2 px-4 bg-transparent text-gray-800 rounded hover:bg-green-100 focus:outline-none", type: "button" do
                span "Edit this answer.", class: "tooltip rounded shadow-lg px-2 py-1 bg-gray-800 text-gray-100 -mt-10"
                tag "svg", class: "inline h-5 w-5 text-gray-700", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
                  tag "path", d: "M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
                end
              end
              link to: Admin::Answers::Delete.with(answer.id), class: "has-tooltip inline-flex py-2 px-4 bg-transparent text-red-600 rounded hover:bg-red-200 focus:outline-none", type: "button" do
                span "Delete this answer.", class: "tooltip rounded shadow-lg px-2 py-1 bg-gray-800 text-gray-100 -mt-8"
                tag "svg", class: "inline h-5 w-5 text-red-500", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
                  tag "path", d: "M15 12H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
                end
              end
            end
          end
        end
      end
      mount ::Shared::PaginationLinks, pages: pages, page_type: "answers"
    end
  end
end
