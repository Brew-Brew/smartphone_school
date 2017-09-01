class QuizController < ApplicationController
  def index
    #user가 선택한 답을 보관하는 전역변수로 배열 선언 $answer_list=>user답  quiz_list=> 진짜 답
    $answer_list = Array.new

    @subjects=Subject.where(user_id: current_user.id)
    @quizzes=Quiz.all
    @answer = params[:answer]
  end

  #정답 관련 및 성취율 업데이트관련
  def score
    @subject=Subject.find(params[:id])
    @quiz=Quiz.where(subject_id: params[:id])
    @quiznum=@quiz.size

    if ($answer_list.size >= @quiznum)
      $answer_list = Array.new
    end

    #정답체크 관련 (user가 선택한 정받을 받아와 임시의 answer_list에 저장해 push해줌)
    @answer = params[:answer]
    quiz_list=@quiz.select('answer')
    $answer_list.push(@answer)
    respond_to do |format|
      format.html
      format.js
    end

  end

  def practice
    @user=current_user
    #마지막문제에서 제출했을때 연습하기 점수를 100점으로 채운다.
    @answer = params[:answer]
    @score=Score.where(subject_id: params[:id])
    @subject=Subject.find(params[:id])
    @total_subject=Subject.where(user_id: current_user.id)

    if (@answer=='correct')
      if (@score[0].practice_score <100)
        @score[0].practice_score =100
        @score[0].total_score += @score[0].practice_score/2
        @score[0].save
        
        
        @subject.score = @score[0].total_score
        @subject.save
        
        @total=@total_subject.select('score')
        
        total=0
        for i in 0..(@total_subject.size- 1)
         total+=@total[i].score
        end  
        
        total=total/@total.size
        
        @user.study=total
        @user.save
      
      end
    end
    ##user의 total점수가 100%면 완료페이지로 넘어가게 redirect
    if (@score[0].total_score == 100)
      redirect_to "/user/complete"
    else
      redirect_to :back
    end
  end

  def solve
    #User
    @user=current_user
    user=current_user

    #퀴즈관련
    @zero = 0
    @score=Score.where(subject_id: params[:id])
    @subject=Subject.find(params[:id])
    @quiz=Quiz.where(subject_id: params[:id])
    @quiznum=@quiz.size
    @total_subject=Subject.where(user_id: current_user.id)


    @ans= $answer_list

    #quiz 점수가 100점일때 practice활성화

    #user 답 갯수가 quiz 문제 개수보다 작으면 배열 초기화
    if (($answer_list).size < @quiznum)
      $answer_list = Array.new
    end

    #정답체크 관련

    @answer = params[:answer]

    #정답 모아놓은 배열과, user가 선택한 정답 받아와서
    #비교하고, 그것을 몇개중 몇개 맞았다 표시하고, 성취율 업데이트!
    quiz_list=@quiz.select('answer')
    @ans= $answer_list

    #제출한 답안의 갯수가 퀴즈의 답갯수와 같을 때만 user 성취율 업데이트
    if ($answer_list.size== @quiznum)
      @sum = 0.0
      for i in 0..(@quiznum - 1)
        if quiz_list[i].answer == $answer_list[i]
          @sum+=1.0
        end
      end
      #성취율
      user_score= 100 * @sum / @quiznum

      #user의 점수가 예전보다 높으면 높은 점수로 업데이트
      
      if (user_score/2>@subject.score)

        @score[0].quiz_score =user_score
        @score[0].total_score=@score[0].quiz_score/2
        @score[0].save
        @subject.score=@score[0].total_score
        @subject.save
        
        @total=@total_subject.select('score')
        
        total=0
        for i in 0..(@total_subject.size- 1)
         total+=@total[i].score
        end  
        
        total=total/@total.size
        
        @user.study=total
        @user.save
      end
    end

    respond_to do |format|
      format.html
      format.json { render :json => @ans }
      format.js
    end
  
  end
  
  # @quiz[0].answer= @answer
  # @quiz[0].save


  def text
    @subject=Subject.find(params[:id])
  end


  def new
    respond_to do |format|
      format.html { render(:text => "not implemented") }
      format.js {}
    end
  end
  
end


