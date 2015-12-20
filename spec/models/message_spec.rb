require "spec_helper"

RSpec.describe "Message", :type => :model do

  describe "Message" do
    it "Require content" do
      user = User.create(email: "toto@gmail.com", nickname: "Toto", password: "totototo")
      other_user = User.create(email: "titi@gmail.com", nickname: "Titi", password: "titititi")
      story = Story.create(title: "Mon titre", content: "Mon contenu" , user_id: user.id)

      message = Message.create(user_id: other_user.id, story_id: story.id)
      expect(message.valid?).to eq(false)

      message.content = "Mon message"
      expect(message.valid?).to eq(true)
    end

    it "Require user" do
      user = User.create(email: "toto@gmail.com", nickname: "Toto", password: "totototo")
      story = Story.create(title: "Mon titre", content: "Mon contenu" , user_id: user.id)

      message = Message.create(content: "Mon message", story_id: story.id)
      expect(message.valid?).to eq(false)

      other_user = User.create(email: "titi@gmail.com", nickname: "Titi", password: "titititi")
      message.user_id = other_user.id
      expect(message.valid?).to eq(true)
    end

    it "Require story" do
      user = User.create(email: "toto@gmail.com", nickname: "Toto", password: "totototo")
      other_user = User.create(email: "titi@gmail.com", nickname: "Titi", password: "titititi")

      message = Message.create(content: "Mon message", user_id: other_user.id)
      expect(message.valid?).to eq(false)

      story = Story.create(title: "Mon titre", content: "Mon contenu" , user_id: user.id)
      message.story_id = story.id
      expect(message.valid?).to eq(true)
    end

    it "Content has limits" do
      user = User.create(email: "toto@gmail.com", nickname: "Toto", password: "totototo")
      other_user = User.create(email: "titi@gmail.com", nickname: "Titi", password: "titititi")
      story = Story.create(title: "Mon titre", content: "Mon contenu" , user_id: user.id)

      message = Message.create(user_id: other_user.id, story_id: story.id, content: "Une limite de 10 mots pas plus que ça sinon une erreur")
      expect(message.valid?).to eq(false)

      message.content = "Egalementunelimitesde240caractèrespourlesplusmalin:Loremipsumdolorsitamet,consecteturadipiscingelit.Morbiultriciesmassaeumattisporta.Loremipsumdolorsitamet,consecteturadipiscingelit.Vestibulumasuscipitpurus,sedauctorjusto.Donecauguemassa,tempussitametamet."
      expect(message.valid?).to eq(false)

      message.content = "Avec moins de 10 caractères et 240 caractères ça passe"
      expect(message.valid?).to eq(true)
    end

    it "Can't contribute two times" do
      user = User.create(email: "toto@gmail.com", nickname: "Toto", password: "totototo")
      story = Story.create(title: "Mon titre", content: "Mon contenu" , user_id: user.id)
      other_user = User.create(email: "titi@gmail.com", nickname: "Titi", password: "titititi")

      expect(Message.user_already_contribute?(user_id: user.id, story_id: story.id)).to eq(true)

      expect(Message.user_already_contribute?(user_id: other_user.id, story_id: story.id)).to eq(false)
      Message.create(user_id: other_user.id, story_id: story.id, content: "Mon message")
      expect(Message.user_already_contribute?(user_id: other_user.id, story_id: story.id)).to eq(true)
    end

    it "Get story content" do
      user = User.create(email: "toto@gmail.com", nickname: "Toto", password: "totototo")
      story = Story.create(title: "Mon titre", content: "Mon contenu" , user_id: user.id)
      other_user = User.create(email: "titi@gmail.com", nickname: "Titi", password: "titititi")

      message = Message.create(user_id: other_user.id, story_id: story.id, content: "Mon message")

      expect(Message.get_story_content(story_id: story.id)).to eq(story.content + " " + message.content)
    end
  end
end
