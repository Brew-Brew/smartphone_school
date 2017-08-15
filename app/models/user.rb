class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]




  after_create :set_seed
  
  has_many :subjects
  has_many :quizzes
 
  has_many :scores
 
  has_many :posts
  has_many :comments
  
  # Virtual attribute for authenticating by either phonenumber or email
  # This is in addition to a real persisted field like 'phonenumber'
  attr_accessor :login
  
def self.find_for_database_authentication(warden_conditions)
  conditions = warden_conditions.dup
  if login = conditions.delete(:login)
    where(conditions).where(["lower(phonenumber) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  else
    where(conditions).first
  end
end

def self.find_first_by_auth_conditions(warden_conditions)
  conditions = warden_conditions.dup
  if login = conditions.delete(:login)
    where(conditions).where(["lower(phonenumber) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  else
    if conditions[:phonenumber].nil?
      where(conditions).first
    else
      where(phonenumber: conditions[:phonenumber]).first
    end
  end
end







def set_seed
  
User.where(id: self.id).update(study: 0)


subject_list = [
  [self.id,'주요 버튼 및 기능','https://www.youtube.com/embed/EsDOZ4Bz7Vk'],
  [self.id,'전화/메시지','https://www.youtube.com/embed/fds8542N7Cs'],
  [self.id,'카메라','https://www.youtube.com/embed/hwfyujTryAI'],
  [self.id,'환경설정','https://www.youtube.com/embed/hwfyujTryAI'],
  [self.id,'마켓/어플','https://www.youtube.com/embed/hwfyujTryAI'],
  [self.id,'SNS','https://www.youtube.com/embed/hwfyujTryAI']
]
subject_list.each do |current_user,name,lecture|
  Subject.create(user_id: current_user,name: name,lecture: lecture,score: 0)
end



#score 초기화 부분
score=[
  [self.id,0,0,0,(self.id - 1)*6 + 1],
  [self.id,0,0,0,(self.id - 1)*6 + 2],
  [self.id,0,0,0,(self.id - 1)*6 + 3],
  [self.id,0,0,0,(self.id - 1)*6 + 4],
  [self.id,0,0,0,(self.id - 1)*6 + 5],
  [self.id,0,0,0,(self.id - 1)*6 + 6]
  ]
score.each do |user_id,total_score,quiz_score,practice_score,subject_id|
Score.create(user_id: user_id,total_score: total_score,quiz_score: quiz_score,practice_score: practice_score,subject_id: subject_id)
end

quiz_list1=[
  [self.id,(self.id - 1)*6 + 1,'주요버튼 및기능 문제1','홈버튼은 휴대폰 아래에 위치한다.','O'],
  [self.id,(self.id - 1)*6 + 1,'주요버튼 및기능 문제2','전면카메라, 후면카메라 이렇게 두개의 카메라가 있다.','O'],
  [self.id,(self.id - 1)*6 + 1,'주요버튼 및기능 문제3','사진을 선택하거나, 앱을 실행할때 화면을 꼭 두번 눌러야한다.','X']
  ]
  
#quiz 생성
quiz_list1.each do |user_id,subject_id,title,content,answer|
    Quiz.create(user_id: user_id,subject_id: subject_id,title: title,content: content,answer: answer)
  end
  
quiz_list2=[
  [self.id,(self.id - 1)*6 + 2,'전화/메시지 문제1','연락처의 +버튼으로도 연락처를 저장할 수 있다.','O'],
  [self.id,(self.id - 1)*6 + 2,'전화/메시지 문제2','영상통화를 하며 카메라 전환기능을 사용할 수 없다','X'],
  [self.id,(self.id - 1)*6 + 2,'전화/메시지 문제3','메시지를 보낼때 보낼사람을 이름으로 검색할 수 있다.','O']
  ]
 
  quiz_list2.each do |user_id,subject_id,title,content,answer|
   Quiz.create(user_id: user_id,subject_id: subject_id,title: title,content: content,answer: answer)
  end
  
quiz_list3=[
  [self.id,(self.id - 1)*6 + 3,'메뉴-3 문제1','문제내용1','O'],
  [self.id,(self.id - 1)*6 + 3,'메뉴-3 문제2','문제내용2','X'],
  [self.id,(self.id - 1)*6 + 3,'메뉴-3 문제3','문제내용3','O'],
  [self.id,(self.id - 1)*6 + 3,'메뉴-3 문제4','문제내용4','X'],
  [self.id,(self.id - 1)*6 + 3,'메뉴-3 문제5','문제내용5','O']
  ]
 
  quiz_list3.each do |user_id,subject_id,title,content,answer|
   Quiz.create(user_id: user_id,subject_id: subject_id,title: title,content: content,answer: answer)
  end


quiz_list4=[
  [self.id,(self.id - 1)*6 + 4,'메뉴-4 문제1','문제내용1','O'],
  [self.id,(self.id - 1)*6 + 4,'메뉴-4 문제2','문제내용2','X'],
  [self.id,(self.id - 1)*6 + 4,'메뉴-4 문제3','문제내용3','O'],
  [self.id,(self.id - 1)*6 + 4,'메뉴-4 문제4','문제내용4','X'],
  [self.id,(self.id - 1)*6 + 4,'메뉴-4 문제5','문제내용5','O']
  ]
 
  quiz_list4.each do |user_id,subject_id,title,content,answer|
   Quiz.create(user_id: user_id,subject_id: subject_id,title: title,content: content,answer: answer)
  end
quiz_list5=[
  [self.id,(self.id - 1)*6 + 5,'메뉴-5 문제1','문제내용1','O'],
  [self.id,(self.id - 1)*6 + 5,'메뉴-5 문제2','문제내용2','X'],
  [self.id,(self.id - 1)*6 + 5,'메뉴-5 문제3','문제내용3','O'],
  [self.id,(self.id - 1)*6 + 5,'메뉴-5 문제4','문제내용4','X'],
  [self.id,(self.id - 1)*6 + 5,'메뉴-5 문제5','문제내용5','O']
  ]
 
  quiz_list5.each do |user_id,subject_id,title,content,answer|
   Quiz.create(user_id: user_id,subject_id: subject_id,title: title,content: content,answer: answer)
  end
  
  quiz_list6=[
  [self.id,(self.id - 1)*6 + 6,'메뉴-6 문제1','문제내용1','O'],
  [self.id,(self.id - 1)*6 + 6,'메뉴-6 문제2','문제내용2','X'],
  [self.id,(self.id - 1)*6 + 6,'메뉴-6 문제3','문제내용3','O'],
  [self.id,(self.id - 1)*6 + 6,'메뉴-6 문제4','문제내용4','X'],
  [self.id,(self.id - 1)*6 + 6,'메뉴-6 문제5','문제내용5','O']
  ]
 
  quiz_list6.each do |user_id,subject_id,title,content,answer|
   Quiz.create(user_id: user_id,subject_id: subject_id,title: title,content: content,answer: answer)
  end
end
    
  
end
