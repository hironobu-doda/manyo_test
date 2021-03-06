# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
require 'rails_helper'

# このRSpec.featureの右側に、「タスク管理機能」のように、テスト項目の名称を書きます（do ~ endでグループ化されています）
RSpec.feature "ログイン管理機能", type: :feature do

  # background do
  #   FactoryBot.create(:user)
  # end


  scenario "ユーザ登録（create）をした時、同時にログインもされるかテストした" do
    #ユーザー登録画面に移動
    visit new_user_path

    #入力フォームに入力する
    fill_in 'Name', with: 'shibao'
    fill_in 'Email', with: 'shibao@example.com'
    fill_in 'Password', with: "shibaodayo"
    fill_in 'Password confirmation', with: "shibaodayo"

    #アカウント作成ボタンをクリック
    click_on 'アカウントを作成する'
    # save_and_open_page
    # binding.pry

    expect(page).to have_content 'shibaoのページ'
    expect(page).to have_content 'ログインしました'
  end

  scenario "ログインしていないのにタスクのページに飛ぼうとした場合は、ログインページに遷移されるかテストした" do

    #ログインせずに、タスク一覧画面に飛ぶ
    visit tasks_path
    # save_and_open_page

    expect(page).to have_content 'ログインしてください'

  end

  scenario "ログインしている時は、ユーザー登録画面（new画面）に行かせないように、コントローラで制御されるかテストした" do

    #ユーザー登録画面に移動
    visit new_user_path

    #入力フォームに入力する
    fill_in 'Name', with: 'shibao'
    fill_in 'Email', with: 'shibao@example.com'
    fill_in 'Password', with: "shibaodayo"
    fill_in 'Password confirmation', with: "shibaodayo"

    #アカウント作成ボタンをクリック
    click_on 'アカウントを作成する'

    #ユーザー登録画面に移動
    visit new_user_path
    # save_and_open_page

    #ログインしている状態で「ユーザー登録画面」に移動しようとすると、詳細ページに移動する
    expect(page).to have_content 'ログインしました'

  end

  scenario "自分（current_user）以外のユーザのマイページ（userのshow画面）に行かせないように、コントローラで制御されるかテストした" do

    #ユーザー登録画面に移動
    visit new_user_path
    #入力フォームに入力する(shibao)
    fill_in 'Name', with: 'shibao'
    fill_in 'Email', with: 'shibao@example.com'
    fill_in 'Password', with: "shibaodayo"
    fill_in 'Password confirmation', with: "shibaodayo"
    #アカウント作成ボタンをクリック
    click_on 'アカウントを作成する'
    #ログアウトボタンをクリック
    click_on 'ログアウト'

    #ユーザー登録画面に移動
    visit new_user_path
    #入力フォームに入力する(yamada)
    fill_in 'Name', with: 'yamada'
    fill_in 'Email', with: 'yamada@example.com'
    fill_in 'Password', with: "yamadadayo"
    fill_in 'Password confirmation', with: "yamadadayo"
    #アカウント作成ボタンをクリック
    click_on 'アカウントを作成する'


    #shibaoのユーザー登録画面に移動
    visit user_path(3)
    # save_and_open_page

    #yamadaがログインしている状態で「shibaoのユーザー登録画面」に移動しようとすると、「yamadaの詳細ページ」に移動する
    expect(page).to have_content 'yamadaのページ'
    expect(page).to have_content 'ログインしました'

  end

  scenario "自分が作成したタスクだけを表示するかテストした" do

    #ユーザー登録画面に移動
    visit new_user_path
    #入力フォームに入力する(shibao)
    fill_in 'Name', with: 'shibao'
    fill_in 'Email', with: 'shibao@example.com'
    fill_in 'Password', with: "shibaodayo"
    fill_in 'Password confirmation', with: "shibaodayo"
    #アカウント作成ボタンをクリック
    click_on 'アカウントを作成する'
    #タスク登録画面に移動
    visit new_task_path
    # save_and_open_page

    #タスク登録フォームに入力する(shibao)
    fill_in 'タイトル', with: 'shibaoのタスク'
    fill_in '内容', with: 'shibaoのタスク内容'
    fill_in '終了期限', with: "2019-03-12 15:48:21 +0900"
    select 'working', from: 'ステータス'
    select 'low', from: 'Priority'
    #タスク登録ボタンをクリック
    click_on '登録する'
    #ログアウトボタンをクリック
    click_on 'ログアウト'
    save_and_open_page


    #ユーザー登録画面に移動
    visit new_user_path
    #入力フォームに入力する(yamada)
    fill_in 'Name', with: 'yamada'
    fill_in 'Email', with: 'yamada@example.com'
    fill_in 'Password', with: "yamadadayo"
    fill_in 'Password confirmation', with: "yamadadayo"
    #アカウント作成ボタンをクリック
    click_on 'アカウントを作成する'
    #タスク登録画面に移動
    visit new_task_path
    # save_and_open_page

    #タスク登録フォームに入力する(shibao)
    fill_in 'タイトル', with: 'yamadaのタスク'
    fill_in '内容', with: 'yamadaのタスク内容'
    fill_in '終了期限', with: "2019-03-13 15:48:21 +0900"
    select 'waiting', from: 'ステータス'
    select 'middle', from: 'Priority'
    #タスク登録ボタンをクリック
    click_on '登録する'
    save_and_open_page

    #yamadaのタスク内容
    expect(page).to have_content 'yamadaのタスク内容'

  end

end
