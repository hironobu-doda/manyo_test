require 'rails_helper'

RSpec.describe Task, type: :model do

  it "titleが空ならバリデーションが通らない" do
    task = Task.new(title: '', content: '失敗テスト')
    expect(task).not_to be_valid
  end

  it "contentが空ならバリデーションが通らない" do
    # ここに内容を記載する
    task = Task.new(title: 'aaa', content: '')
    expect(task).not_to be_valid
  end

  it "titleとcontentに内容が記載されていればバリデーションが通る" do
    # ここに内容を記載する
    task = Task.new(title: 'aaa', content: 'aaa')
    expect(task).to be_valid
  end

  it "statusカラムのキー番号を指定すると、キー番号に対応しているキーを取り出すことができる" do
    task0 = Task.statuses.keys[0]
    task1 = Task.statuses.keys[1]
    task2 = Task.statuses.keys[2]

    expect(task0).to eq 'waiting'
    expect(task1).to eq 'working'
    expect(task2).to eq 'completed'
  end
end
