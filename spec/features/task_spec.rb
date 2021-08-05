require 'rails_helper'

RSpec.describe "Tasks", type: :feature do
  before(:all) do
    @user = create(:user)
  end

  describe "首頁登入" do 
    it "要求登入" do 
      visit tasks_path
      expect(page).to have_content("#{User.human_attribute_name("password")}")
    end
  end

  describe "登入" do
    it "成功" do
      visit root_path

      fill_in "user_email", with: @user.email
      fill_in "user_password", with: @user.password

      click_button "登入"
      expect(page).to have_content("#{I18n.t("login")}#{I18n.t("success")}")
    end
    it "失敗" do
      visit root_path

      click_button "登入"
      expect(page).to have_content("帳號密碼錯誤")
    end
  end

  describe "已登入" do
    before(:each) do
      visit root_path
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: @user.password
      click_button "登入"
    end

    describe "新增" do 
      before(:each) do 
        @current_time = Time.zone.now
        visit new_task_path
        fill_in "task_name", with: "task"
        fill_in "task_start_at", with: @current_time
        fill_in "task_end_at", with: @current_time + 1.day
      end
      
      it "成功" do 
        click_button "確認"
        expect(page).to have_content("新增成功")
      end
  
      it "失敗" do
        click_button "確認"
        expect(page).not_to have_content("can't be blank")
      end
    end
  
    describe "更新" do 
      let!(:task) {
        @user.tasks.create!(name: Faker::Lorem.word, start_at: Time.zone.now, end_at: Time.zone.now+1.day)
      }
      before(:each) do
        @current_time = Time.zone.now
        visit edit_task_path(task)
      end
      it "成功" do 
        fill_in "task_name", with: "task"
        fill_in "task_start_at", with: @current_time
        fill_in "task_end_at", with: @current_time + 1.day
        click_button "確認"
        expect(page).to have_content("更新成功")
      end
      it "失敗" do 
        click_button "確認"
        expect(page).not_to have_content("can't be blank")
      end
    end 
  
    describe "刪除" do
      let!(:task) {
        @user.tasks.create!(name: Faker::Lorem.word, start_at: Time.zone.now, end_at: Time.zone.now+1.day)
      }
      before(:each) do
        @current_time = Time.zone.now
        visit task_path(task)
      end
      it "成功" do 
        expect {click_link "刪除"}.to change(Task, :count).by(-1)
      end
    end

    describe "排序" do
      let(:params) {
        {
          name: "task",
          start_at: "2021-01-01",
          end_at: "2021-02-02",
          start_at: Time.zone.now
        }
      }
      it "建立日期" do
        @task1 = @user.tasks.create(params)
        @task2 = @user.tasks.create(params.merge(start_at: Time.zone.now+1.day))
        @task3 = @user.tasks.create(params.merge(start_at: Time.zone.now+2.days))
        visit tasks_path
        tasks = @user.tasks.order_start_at
        expect(tasks).to eq([@task3, @task2, @task1])
      end
    end
  end  
end
