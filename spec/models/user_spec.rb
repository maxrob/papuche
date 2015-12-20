require 'rails_helper'

RSpec.describe "User", :type => :model do
   it "User can be saved" do
      user = User.create(email: "toto@gmail.com", nickname: "Toto", password: "totototo")
      user.save!

      last_user = User.last
      expect(last_user.email).to eq("toto@gmail.com")
      expect(last_user.nickname).to eq("Toto")
    end

    it "Require valid email" do
      user = User.new
      user.nickname = "Toto"
      user.password = "totototo"
      expect(user.valid?).to eq(false)

      user.email = "toto"
      expect(user.valid?).to eq(false)

      user.email = "toto@gmail.com"
      expect(user.valid?).to eq(true)

    end

    it "Require nickname" do
      user = User.new
      user.email = "toto@gmail.com"
      user.password = "totototo"
      expect(user.valid?).to eq(false)

      user.nickname = "Toto"
      expect(user.valid?).to eq(true)

    end

    it "Require password of 8 letters" do
      user = User.new
      user.nickname = "Toto"
      user.email = "toto@gmail.com"
      expect(user.valid?).to eq(false)

      user.password = "toto"
      expect(user.valid?).to eq(false)

      user.password = "toto8letters"
      expect(user.valid?).to eq(true)
    end

    it "Uniq Nickname" do
      first_user = User.create(email: "toto@gmail.com", nickname: "Toto", password: "totototo")
      expect(first_user.valid?).to eq(true)

      second_user = User.create(email: "test@gmail.com", nickname: "Toto", password: "totototo")
      expect(second_user.valid?).to eq(false)
    end

    it "Uniq Email" do
      first_user = User.create(email: "toto@gmail.com", nickname: "Toto", password: "totototo")
      expect(first_user.valid?).to eq(true)

      second_user = User.create(email: "toto@gmail.com", nickname: "Tartu", password: "totototo")
      expect(second_user.valid?).to eq(false)
    end

end
