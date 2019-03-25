# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
require 'rails_helper'

# このRSpec.featureの右側に、「タスク管理機能」のように、テスト項目の名称を書きます（do ~ endでグループ化されています）
RSpec.feature "タスク管理機能", type: :feature do

  background do
    FactoryBot.create(:user)
    FactoryBot.create(:label, label_title: '仕事')
    FactoryBot.create(:label, label_title: 'プライベート')
    FactoryBot.create(:label, label_title: '勉強')
    FactoryBot.create(:task, title: '付け加えた名前１', time_limit: "2019-03-11")
    FactoryBot.create(:task, title: '付け加えた名前２', time_limit: "2019-03-12", priority: "middle")
    FactoryBot.create(:second_task, title: '付け加えた名前３', content: '付け加えたコンテント', time_limit: "2019-03-13")
    # FactoryBot.create(:label)
  end
  # scenario（itのalias）の中に、確認したい各項目のテストの処理を書きます。
  scenario "タスク一覧のテスト" do
    visit new_session_path

    fill_in 'Email', with: 'shibao@example.com'
    fill_in 'Password', with: 'shibaodayo'
    click_on 'Log in'
    click_on 'タスク一覧画面'
    # save_and_open_page

    # visitした（到着した）expect(page)に（タスク一覧ページに）「testtesttest」「samplesample」という文字列が
    # have_contentされているか？（含まれているか？）ということをexpectする（確認・期待する）テストを書いている
    expect(page).to have_content '付け加えた名前３'
    expect(page).to have_content '付け加えたコンテント'

  end

  scenario "タスク作成のテスト" do
    visit new_session_path

    fill_in 'Email', with: 'shibao@example.com'
    fill_in 'Password', with: 'shibaodayo'
    click_on 'Log in'
    click_on 'タスク一覧画面'
    click_on '新しくタスクを投稿する'

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
    visit new_session_path

    fill_in 'Email', with: 'shibao@example.com'
    fill_in 'Password', with: 'shibaodayo'
    click_on 'Log in'
    click_on 'タスク一覧画面'

    # 実際の状況を確認したい箇所にさし挟む。
    # 例の場合、「タスクが保存された後、タスク一覧ページに行くとどうなるのか」を確認するため
    # visit tasks_path の直後に save_and_open_page を挟んでいる
    # save_and_open_page

    click_on '詳細確認', match: :first
    #save_and_open_page

    expect(page).to have_content '付け加えた名前３'
    expect(page).to have_content '付け加えたコンテント'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    visit new_session_path

    fill_in 'Email', with: 'shibao@example.com'
    fill_in 'Password', with: 'shibaodayo'
    click_on 'Log in'
    click_on 'タスク一覧画面'
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
    visit new_session_path

    fill_in 'Email', with: 'shibao@example.com'
    fill_in 'Password', with: 'shibaodayo'
    click_on 'Log in'
    click_on 'タスク一覧画面'
    # save_and_open_page

    # expect(page).to have_content DateTime.now
    expect(page).to have_content "2019-03-11"
    # save_and_open_page
  end

  scenario "タスクが終了期限でソートするかテスト" do
    visit new_session_path

    fill_in 'Email', with: 'shibao@example.com'
    fill_in 'Password', with: 'shibaodayo'
    click_on 'Log in'
    click_on 'タスク一覧画面'

    click_on '終了期限でソートする'
    # save_and_open_page
    tasks = page.all(".index")
    # binding.pry
    expect(tasks[0]).to have_content '2019-03-13'
    expect(tasks[1]).to have_content '2019-03-12'
    expect(tasks[2]).to have_content '2019-03-11'
    # background.each.do |time_limit|
    # expect(page).to have_content time_limit
  end

  scenario "検索ロジックのテスト" do
    visit new_session_path

    fill_in 'Email', with: 'shibao@example.com'
    fill_in 'Password', with: 'shibaodayo'
    click_on 'Log in'
    click_on 'タスク一覧画面'

    fill_in 'タイトル検索', with: '付け加えた名前１'

    select "waiting", from: 'ステータス検索'

    click_on '検索'
    # save_and_open_page

    expect(page).to have_content '付け加えた名前１'
    expect(page).to have_content 'completed'

  end

  scenario "優先順位で高い順にソートできるかテスト" do
    visit new_session_path

    fill_in 'Email', with: 'shibao@example.com'
    fill_in 'Password', with: 'shibaodayo'
    click_on 'Log in'
    click_on 'タスク一覧画面'
    # save_and_open_page

    click_on '優先順位でソートする'
    # save_and_open_page
    tasks = page.all(".priority")
    expect(tasks[0]).to have_content 'high'
    expect(tasks[1]).to have_content 'high'
    expect(tasks[2]).to have_content 'middle'
  end

  scenario "登録したlabelが詳細画面で表示されるかテストした" do
    visit new_session_path

    fill_in 'Email', with: 'shibao@example.com'
    fill_in 'Password', with: 'shibaodayo'
    click_on 'Log in'
    click_on 'タスク一覧画面'
    # save_and_open_page

    click_on '新しくタスクを投稿する'

    fill_in 'タイトル', with: 'aaa'
    fill_in '内容', with: 'bbb'
    check 'task_label_ids_25'
    check 'task_label_ids_26'
    check 'task_label_ids_27'
    # save_and_open_page
    click_on '登録する'
    # save_and_open_page
    visit task_path(29)
    # save_and_open_page

    expect(page).to have_content '仕事'
    expect(page).to have_content 'プライベート'
    expect(page).to have_content '勉強'
  end

  scenario "仕事ラベルのついたタスクのみを検索できるかテストした" do
    visit new_session_path

    fill_in 'Email', with: 'shibao@example.com'
    fill_in 'Password', with: 'shibaodayo'
    click_on 'Log in'
    click_on 'タスク一覧画面'
    # save_and_open_page

    click_on '新しくタスクを投稿する'

    fill_in 'タイトル', with: 'aaa'
    fill_in '内容', with: 'bbb'
    check 'task_label_ids_28'
    check 'task_label_ids_29'
    check 'task_label_ids_30'
    # save_and_open_page
    click_on '登録する'
    # save_and_open_page

    select '仕事', from: 'ラベル検索'
    click_on '検索'
    # visit task_path(33)
    save_and_open_page

    expect(page).to have_content 'aaa'
  end

end
