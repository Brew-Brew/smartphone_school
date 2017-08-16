class UserController < ApplicationController
  
  
  
  def mypage
    @user=current_user
    @score=Score.where(user_id: current_user.id)
  end

  def complete
  end
  
  def rank
    rank=User.pluck(:study,:username)
    @rank=rank.sort {|x,y| y <=> x}
  end
end
