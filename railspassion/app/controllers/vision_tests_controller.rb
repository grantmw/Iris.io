
class VisionTestsController < ApplicationController
 skip_before_filter :verify_authenticity_token
  def index
    session[:line] = 1
  end

  def show
    p params
    if session[:line] != 1
      @list = ('A'..'Z').to_a.sample(5).join.upcase
    else
      @list = ('A'..'Z').to_a.sample(4).join.upcase
    end

    if params[:type] == 'both'
      session.delete(:goagain) #when you visit both, reset goagain
      p "*" * 50
      p session[:goagain]
      p "*" * 50
      if !session[:line]
        session[:line] = 1
        session[:tries] = 0
        render 'show'
      end

      render 'show'

    elsif params[:type] == 'single'

      if !session[:goagain]
        session[:goagain] = 'on'
        session[:tries] = 0
      # elsif session[:goagain] = 'on'
      #   session[:goagain] = 'off'
      end
      if !session[:line]
        session[:line] = 1
        session[:tries] = 0
        render 'show'
      end
      p "*" * 50
      p session[:goagain]
      p "*" * 50
      render 'show'
    end
  end

  def checker
  p "*" * 80
    p session[:line]
    p session[:tries]
    p "*" * 80
    p params
    p "69" * 100

    while session[:line] < 12 && session[:tries] < 4
      if params[:answer] == params[:fiveletters].downcase
        session[:line] += 1 #if right, increment up
        session[:tries] = 0 #reset tries
        redirect_to "/vision_tests/#{params[:type]}" and return
      else
        session[:tries] += 1
        redirect_to "/vision_tests/#{params[:type]}" and return
      end
    end
    session[:tries] = 0
    p 'apples'*99
    redirect_to "/vision_tests/results" and return
  end

  def results
    p 'oranges' * 99
    if session[:goagain] == 'on'
      if session[:line] != 1 && session[:line] != 12
        @result = Vision.find(session[:line]-1).level
        session[:result_left] = @result
        session[:line] = 1
      else
        @result = Vision.find(session[:line]).level
        session[:result_left] = @result
        session[:line] = 1
      end
      render 'show_results'

    elsif session[:goagain] == 'off'
      if session[:line] != 1 && session[:line] != 12

        @result = Vision.find(session[:line]-1).level
        SavedTest.create(user_id: session[:id], result_left: session[:result_left], result_right: @result, test_type: 'vision')
      else
        @result = Vision.find(session[:line]).level
        SavedTest.create(user_id: session[:id], result_left: session[:result_left], result_right: @result, test_type: 'vision')

      end
      session[:goagain] == nil
      session[:line] = 1
      render 'show_results'

    else
      if session[:line] != 1 && session[:line] != 12
        @result = Vision.find(session[:line]-1).level
        session[:line] = 1
        SavedTest.create(user_id: session[:id], result_both: @result, test_type: 'vision')
        #make vision a wildcard --
        #restful: tests/:test_id/results - or something like that
        render 'show_results'
      else
        @result = Vision.find(session[:line]).level
        session[:line] = 1
        SavedTest.create(user_id: session[:id], result_both: @result, test_type: 'vision')
        render 'show_results'
      end
    end
  end

  def reset
    session[:line] = 1
    redirect_to "/vision_tests"
  end
end
