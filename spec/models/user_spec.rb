require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザサインアップ' do
    before do
      @user = FactoryBot.build(:user)
    end

    context "サインアップできるとき" do

      it "nameとemail、passwordとpassword_confirmationが存在すれば登録できること" do
        expect(@user).to be_valid
      end

      it "passwordが6文字以上であれば登録できること" do
        @user.password = "000000"
        @user.password_confirmation = "000000"
        expect(@user).to be_valid  
      end

    end

    context "サインアップできないとき" do

      it "nameが空では登録できないこと" do
        @user.name = ""
        @user.valid?
        #binding.pry
        expect(@user.errors.full_messages).to include("Name can't be blank") 
      end
  
      it "emailが空では登録できないこと" do
        @user.email= nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "重複したemailが存在する場合登録できないこと" do
        @user.save
        @user2 = FactoryBot.build(:user, email: @user.email)
        #@user2.email = @user.email
        @user2.valid?
        expect(@user2.errors.full_messages).to include("Email has already been taken")
      end
  
      it "passwordが空では登録できないこと" do
        @user.password = nil
        @user.password_confirmation = "00000000"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it "passwordが存在してもpassword_confirmationが空では登録できないこと" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")  
      end

      it "passwordが5文字以下であれば登録できないこと" do
        @user.password = "00000"
        @user.password_confirmation = "00000"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
    end

  end
end
