# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
require 'rails_helper'

# このRSpec.featureの右側に、「タスク管理機能」のように、テスト項目の名称を書きます（do ~ endでグループ化されています）
RSpec.feature "タスク管理機能", type: :feature do

  background do
    FactoryBot.create(:task, title: '付け加えた名前１')
    FactoryBot.create(:task, title: '付け加えた名前２')
    FactoryBot.create(:second_task, title: '付け加えた名前３', content: '付け加えたコンテント')
  end
  # scenario（itのalias）の中に、確認したい各項目のテストの処理を書きます。
  scenario "タスク一覧のテスト" do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する

    # tasks_pathにvisitする（タスク一覧ページに遷移する）
    visit tasks_path

    # visitした（到着した）expect(page)に（タスク一覧ページに）「testtesttest」「samplesample」という文字列が
    # have_contentされているか？（含まれているか？）ということをexpectする（確認・期待する）テストを書いている
    expect(page).to have_content '付け加えた名前３'
    expect(page).to have_content '付け加えたコンテント'

  end

  scenario "タスク作成のテスト" do
    # new_task_pathにvisitする（タスク登録ページに遷移する）
    # 1.ここにnew_task_pathにvisitする処理を書く
    visit new_task_path

    # 「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄に
    # タスクのタイトルと内容をそれぞれfill_in（入力）する
    # 2.ここに「タスク名」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
    # 3.ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
    fill_in 'タイトル', with: 'aaa'
    fill_in '内容', with: 'bbb'

    # 「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）
    # 4.「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
    click_on '登録する'

    # clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
    # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
    # 5.タスク詳細ページに、テストコードで作成したはずのデータ（記述）がhave_contentされているか（含まれているか）を確認（期待）するコードを書く
    expect(page).to have_content 'aaa'
    expect(page).to have_content 'bbb'

  end

  scenario "タスク詳細のテスト" do
    # Task.create!(title: 'test_task_01', content: 'testtesttest')
    # Task.create!(title: 'test_task_02', content: 'samplesample')
    visit tasks_path

    # 実際の状況を確認したい箇所にさし挟む。
    # 例の場合、「タスクが保存された後、タスク一覧ページに行くとどうなるのか」を確認するため
    # visit tasks_path の直後に save_and_open_page を挟んでいる
    # save_and_open_page

    click_on '詳細を確認する', match: :first
    #save_and_open_page

    expect(page).to have_content '付け加えた名前３'
    expect(page).to have_content '付け加えたコンテント'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    # ここにテスト内容を記載する

    visit tasks_path
    # save_and_open_page
    # 降順になっているので、FactoryBot.create(:second_task, title: '付け加えた名前３', content: '付け加えたコンテント')から順に並んでいる
    expect(page).to have_content '付け加えた名前３'
    expect(page).to have_content '付け加えたコンテント'
    expect(page).to have_content '付け加えた名前２'
    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント１'
    expect(page).to have_content '付け加えた名前１'
    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント１'
  end

  scenario "タスク終了期限作成のテスト" do

    visit new_task_path
    save_and_open_page

    fill_in 'Time limit', with: DateTime.now

    click_on '登録する'

    expect(page).to have_content DateTime.now

  end

  scenario "タスクが終了期限でソートするかテスト" do

    visit tasks_path

    click_on '終了期限でソートする', match: :first
    #save_and_open_page

    expect(page).to have_content DateTime.now
  end

end
