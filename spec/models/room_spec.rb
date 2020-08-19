require 'rails_helper'

RSpec.describe Room, type: :model do
  describe '#create ルームの作成' do
    before do
      @room = FactoryBot.build(:room)
    end

    context "ルームが作成できるとき" do

      it "nameの値が存在すれば登録できること" do
        expect(@room).to be_valid  
      end

    end

    context "ルームが作成できないとき" do

      it "nameが空では登録できないこと" do
        @room.name = nil
        @room.valid?
        #binding.pry
        expect(@room.errors.full_messages).to include("Name can't be blank")  
      end

    end

  end
end
