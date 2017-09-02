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
  [self.id,'주요 버튼 및 기능','https://www.youtube.com/embed/EsDOZ4Bz7Vk',1],
  [self.id,'전화/메시지','https://www.youtube.com/embed/fds8542N7Cs',2],
  [self.id,'카메라','https://www.youtube.com/embed/hwfyujTryAI',3],
  [self.id,'환경설정','https://www.youtube.com/embed/hwfyujTryAI',4],
  [self.id,'마켓/어플','https://www.youtube.com/embed/hwfyujTryAI',5],
  [self.id,'SNS','https://www.youtube.com/embed/hwfyujTryAI',6]
]
subject_list.each do |current_user,name,lecture,subject_num|
  Subject.create(user_id: current_user,name: name,lecture: lecture,subject_num: subject_num,score: 0)
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
  [self.id,(self.id - 1)*6 + 3,'카메라 문제1','사진은 갤러리 라는 앱에서 볼수있다.','O'],
  [self.id,(self.id - 1)*6 + 3,'카메라 문제2','카카오톡 앱에서 저장한 사진은 KaKaoTalk 이라는 폴더에 따로 저장된다.','O'],
  [self.id,(self.id - 1)*6 + 3,'카메라 문제3','화면에 손가락을 화면에 대고 벌리면 다른 사진을 확인 할 수 있다.','X'],
  [self.id,(self.id - 1)*6 + 3,'카메라 문제4','공유 버튼을 통해 메시지로 사진을 전송할 수 있다.','O']
  ]
 
  quiz_list3.each do |user_id,subject_id,title,content,answer|
   Quiz.create(user_id: user_id,subject_id: subject_id,title: title,content: content,answer: answer)
  end


quiz_list4=[
  [self.id,(self.id - 1)*6 + 4,'환경설정 문제1','환경설정-디스플레이에서 배경화면을 바꿀수 있다.','O'],
  [self.id,(self.id - 1)*6 + 4,'환경설정 문제2','홈화면과 잠금화면을 다르게 설정할 수 있다.','O'],
  [self.id,(self.id - 1)*6 + 4,'환경설정 문제3','와이파이 신호 오른쪽에 자물쇠 모양이 있으면 비밀번호를 입력하고 연결 해야 한다.','O']
  ]
 
  quiz_list4.each do |user_id,subject_id,title,content,answer|
   Quiz.create(user_id: user_id,subject_id: subject_id,title: title,content: content,answer: answer)
  end
quiz_list5=[
  [self.id,(self.id - 1)*6 + 5,'마켓/어플 문제1','어플을 다운받는 앱의 이름은 PLAY 마켓이다.','X'],
  [self.id,(self.id - 1)*6 + 5,'마켓/어플 문제2','스토어에서 어플을 다운받고, 다운이 다되면 바로 열기를 할 수 있다.','O'],
  [self.id,(self.id - 1)*6 + 5,'마켓/어플 문제3','환경설정-애플리케이션에 들어가면 어플을 삭제 할 수 있다.','O']
  ]
 
  quiz_list5.each do |user_id,subject_id,title,content,answer|
   Quiz.create(user_id: user_id,subject_id: subject_id,title: title,content: content,answer: answer)
  end
  
  quiz_list6=[
  [self.id,(self.id - 1)*6 + 6,'SNS 문제1','카카오톡 메시지 입력창의 오른쪽 얼굴 모양을 누르면 이모티콘을 보낼 수 있다.','O'],
  [self.id,(self.id - 1)*6 + 6,'SNS 문제2','사진이나 동영상을 보내려면 대화창의 - 버튼을 누르면 된다.','X'],
  [self.id,(self.id - 1)*6 + 6,'SNS 문제3','카카오톡에는 통화할수 있는 인터넷 전화인 보이스톡이라는 서비스가 있다.','O'],
  [self.id,(self.id - 1)*6 + 6,'SNS 문제4','네이버밴드에서 연락처로 초대에서 초대하기를 하면 문자로 자동으로 초대메세지가 입력된다.','O'],
  [self.id,(self.id - 1)*6 + 6,'SNS 문제5','네이버 밴드에서는 문자말고 다른방법으로도 초대가 가능하다.','O']
  ]
 
  quiz_list6.each do |user_id,subject_id,title,content,answer|
   Quiz.create(user_id: user_id,subject_id: subject_id,title: title,content: content,answer: answer)
  end
end
    
  
end
