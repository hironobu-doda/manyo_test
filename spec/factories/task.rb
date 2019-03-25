# 「FactoryBotを使用します」という記述
FactoryBot.define do

  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  # factory :user do
  #   name { '1shibao' }
  #   email { '1shibao@example.com' }
  #   password { '1shibaodayo' }
  #   admin { 'true' }
  # end

  factory :task do
    title { 'Factoryで作ったデフォルトのタイトル１' }
    content { 'Factoryで作ったデフォルトのコンテント１' }
    time_limit { "2019-03-11" }
    status { 'waiting' }
    priority { 'high' }
    user_id { 1 }
  end

  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル２' }
    content { 'Factoryで作ったデフォルトのコンテント２' }
    time_limit { "2019-03-11" }
    status { 'working' }
    priority { 'high' }
    user_id { 1 }
  end
end
