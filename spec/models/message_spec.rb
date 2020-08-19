require 'rails_helper'

RSpec.describe Message, type: :model do
  describe '#create メッセージ・画像の投稿' do
    before do
      @message = FactoryBot.build(:message)
      @message.image = fixture_file_upload('public/images/test_image.png')
    end

    context "メッセージ・画像の投稿ができるとき" do

      it 'contentとimageが存在していれば保存できること' do
        expect(@message).to be_valid
      end

      it 'contentが存在していれば保存できること' do
        @message.image = nil
        expect(@message).to be_valid  
      end

      it 'imageが存在していれば保存できること' do
        @message.content = nil
        expect(@message).to be_valid
      end

    end

    context "メッセージ・画像の投稿ができないとき" do
      it 'contentとimageが空では保存できないこと' do
        @message.content = nil
        @message.image = nil
        @message.valid?
        #binding.pry
        expect(@message.errors.full_messages).to include("Content can't be blank")  
      end
    end

  end
end
