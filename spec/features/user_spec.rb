RSpec.feature 'Users:', type: :feature do

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
