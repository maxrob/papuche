require "spec_helper"

RSpec.describe "Story", :type => :model do

  describe "Story" do
    it "Require title" do
      user = User.create(email: "toto@gmail.com", nickname: "Toto", password: "totototo")
      story = Story.create(content: "Voici 3 mots", user_id: user.id)
      expect(story.valid?).to eq(false)

      story.title = "Mon titre"
      expect(story.valid?).to eq(true)
    end

    it "Require content" do
      user = User.create(email: "toto@gmail.com", nickname: "Toto", password: "totototo")
      story = Story.create(title: "Mon titre" , user_id: user.id)
      expect(story.valid?).to eq(false)

      story.content = "Voici 3 mots"
      expect(story.valid?).to eq(true)
    end

    it "Require user" do
      story = Story.create(title: "Mon titre" ,content: "Voici 3 mots")
      expect(story.valid?).to eq(false)

      user = User.create(email: "toto@gmail.com", nickname: "Toto", password: "totototo")
      story.user_id = user.id
      expect(story.valid?).to eq(true)
    end

    it "Content has limits" do
      user = User.create(email: "toto@gmail.com", nickname: "Toto", password: "totototo")
      story = Story.create(title: "Mon titre" ,content: "Une limite de 10 mots pas plus que ça sinon une erreur", user_id: user.id)
      expect(story.valid?).to eq(false)

      story.content = "Egalementunelimitesde240caractèrespourlesplusmalin:Loremipsumdolorsitamet,consecteturadipiscingelit.Morbiultriciesmassaeumattisporta.Loremipsumdolorsitamet,consecteturadipiscingelit.Vestibulumasuscipitpurus,sedauctorjusto.Donecauguemassa,tempussitametamet."
      expect(story.valid?).to eq(false)

      story.content = "Avec moins de 10 caractères et 240 caractères ça passe"
      expect(story.valid?).to eq(true)
    end

    it "Can be finish" do
      user = User.create(email: "toto@gmail.com", nickname: "Toto", password: "totototo")
      story = Story.create(title: "Mon titre" ,content: "Mon contenu", user_id: user.id)
      expect(story.finished).to eq(false)

      story.finished!
      expect(story.finished).to eq(true)
    end

    it "Get finished and unfinished" do
      user = User.create(email: "toto@gmail.com", nickname: "Toto", password: "totototo")
      story = Story.create(title: "Mon titre" ,content: "Mon contenu", user_id: user.id)
      story.finished!
      other_story = Story.create(title: "Mon titre" ,content: "Mon contenu", user_id: user.id)

      expect(Story.all_finished).to eq([story])
      expect(Story.all_unfinished).to eq([other_story])
    end

    it "Get all stories finished order by likes" do
      user = User.create(email: "toto@gmail.com", nickname: "Toto", password: "totototo")
      story = Story.create(title: "Mon titre" ,content: "Mon contenu", user_id: user.id)
      other_story = Story.create(title: "Mon titre" ,content: "Mon contenu", user_id: user.id)
      story.finished!

      story.like = 8

      expect(Story.top_finished).to eq([story])

      other_story.finished!
      expect(Story.top_finished).to eq([story, other_story])
    end

    it "Get all stories user likes" do
      user = User.create(email: "toto@gmail.com", nickname: "Toto", password: "totototo")
      other_user = User.create(email: "titi@gmail.com", nickname: "Titi", password: "titititi")
      story = Story.create(title: "Mon titre" ,content: "Mon contenu", user_id: user.id)
      other_story = Story.create(title: "Mon titre" ,content: "Mon contenu", user_id: user.id)

      Like.create(user_id: other_user.id, story_id: story.id)
      expect(Story.all_liked(user_id: other_user.id)).to eq([story])

      Like.create(user_id: other_user.id, story_id: other_story.id)
      expect(Story.all_liked(user_id: other_user.id)).to eq([other_story, story])
    end

    it "Get all stories user contributes" do
      user = User.create(email: "toto@gmail.com", nickname: "Toto", password: "totototo")
      other_user = User.create(email: "titi@gmail.com", nickname: "Titi", password: "titititi")
      story = Story.create(title: "Mon titre" ,content: "Mon contenu", user_id: user.id)
      other_story = Story.create(title: "Mon titre" ,content: "Mon contenu", user_id: user.id)

      Message.create(content: "Ma contribution", user_id: other_user.id, story_id: story.id)
      expect(Story.all_contributed(user_id: other_user.id)).to eq([story])

      Message.create(content: "Ma contribution", user_id: other_user.id, story_id: other_story.id)
      expect(Story.all_contributed(user_id: other_user.id)).to eq([other_story, story])
    end
  end
end
