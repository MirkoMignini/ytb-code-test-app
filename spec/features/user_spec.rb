RSpec.feature 'Users:', type: :feature do

  describe User do

    it 'is valid with name and email' do
      expect(User.new(name: 'user', email: 'email@domain.com')).to be_valid
    end

    it 'is invalid without name or email' do
      expect(User.new(name: '', email: '')).to_not be_valid
    end

    it 'is invalid with a wrong email' do
      expect(User.new(name: 'user', email: 'email@domain')).to_not be_valid
    end

    it 'is invalid with an already used email' do
      User.new(name: 'user', email: 'email@email.com').save
      expect(User.new(name: 'user 2', email: 'email@email.com')).to_not be_valid
    end

    it 'books are deleted when the owner user is deleted' do
      user = User.new(name: 'user', email: 'email2@email.com')
      user.save
      expect(Book.count).to eq(0)

      Book.new(title: 'title', user: user).save
      expect(Book.count).to eq(1)

      user.destroy
      expect(Book.count).to eq(0)
    end

  end

  describe 'Creating a user' do

    include ActiveJob::TestHelper

    before do
      expect(ActionMailer::Base.deliveries.empty?).to be true
      visit '/'
      click_on 'New User'
      fill_in 'Name', with: 'Sam Smith'
      fill_in 'Email', with: 'sam@email.com'
      perform_enqueued_jobs do
        click_on 'Create User'
      end
    end

    it 'notifies an admin by email' do
      email = ActionMailer::Base.deliveries.last
      expect(email.subject).to eq 'New user added'
      expect(email.to_s).to include 'Sam Smith'
    end

  end

end
