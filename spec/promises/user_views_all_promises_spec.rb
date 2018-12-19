require 'rails_helper'

describe 'Promises' do
  before(:each) do
    @promise1 = Promise.create!(
        promisee: 'Alannah',
        promise_start_date: '10/10/2018',
        promise_end_date: '01/01/2020',
        body: 'Stop eating vegetables.',
        status: :'in progress'
      )

    @promise2 = Promise.create!(
      promisee: 'Orlin',
      promise_start_date: '10/31/2016',
      promise_end_date: '01/01/2019',
      body: 'Buy me a new pen.',
      status: :abandoned
    )

    @promise3 = Promise.create!(
      promisee: 'Dad',
      promise_start_date: '01/18/2019',
      promise_end_date: '02/01/2019',
      body: 'Change my oil.',
      status: :done
    )
  end

  context 'shows user all promises' do
    it 'lists them in order of creation' do
      visit '/promises'

      expect(page).to have_content('Promises')
      expect(page).to have_content('Total Promises: 3')
      expect(page).to have_content('In Progress: 1')
      expect(page).to have_content('Abandoned: 1')
      expect(page).to have_content('Done: 1')

      within('#promise-1') do
        expect(page).to have_content(@promise1.promisee)
        expect(page).to have_content(@promise1.body)
        expect(page).to have_content(@promise1.promise_start_date)
        expect(page).to have_content(@promise1.promise_end_date)
        expect(page).to have_content(@promise1.status)
      end

      within('#promise-2') do
        expect(page).to have_content(@promise2.promisee)
        expect(page).to have_content(@promise2.body)
        expect(page).to have_content(@promise2.promise_start_date)
        expect(page).to have_content(@promise2.promise_end_date)
        expect(page).to have_content(@promise2.status)
      end

      within('#promise-3') do
        expect(page).to have_content(@promise3.promisee)
        expect(page).to have_content(@promise3.body)
        expect(page).to have_content(@promise3.promise_start_date)
        expect(page).to have_content(@promise3.promise_end_date)
        expect(page).to have_content(@promise3.status)
      end
    end

    context 'promise show page' do
      it 'lets you see a promise show page' do
        visit '/promises'

        within("#promise-#{@promise1.id}") do
          expect(page).to have_link(@promise1.body)
        end

        click_link @promise1.body

        expect(current_path).to eq("/promises/#{@promise1.id}")

        expect(page).to have_content("Promisee: #{@promise1.promisee}")
        expect(page).to have_content("Promise: #{@promise1.body}")
        expect(page).to have_content("Start Date: #{@promise1.promise_start_date}")
        expect(page).to have_content("End Date: #{@promise1.promise_end_date}")
        expect(page).to have_content("Status: #{@promise1.status}")
      end
    end

    context 'promise add page' do
      it 'lets user add a new promise' do
        visit '/promises'

        click_link 'Add New Promise'

        expect(current_path).to eq('/promises/new')

        expect(page).to have_content('Add New Promise')

        fill_in :promise_promisee, with: 'Santa Callous'
        fill_in :promise_body, with: 'Bring u presents'
        fill_in :promise_promise_start_date, with: '2018-12-26'
        fill_in :promise_promise_end_date, with: '2019-01-20'
        click_on 'Create Promise'

        expect(current_path).to eq("/promises/#{Promise.last.id}")
        expect(page).to have_content("Promisee: #{Promise.last.promisee}")
        expect(page).to have_content("Promise: #{Promise.last.body}")
        expect(page).to have_content("Start Date: #{Promise.last.promise_start_date}")
        expect(page).to have_content("End Date: #{Promise.last.promise_end_date}")
        expect(page).to have_content("Status: #{Promise.last.status}")
      end
    end

    context 'edit a promise' do
      it 'can allow user to edit a promise' do
        visit "/promises"

        within("#promise-#{@promise1.id}") do
          click_on 'Edit'
        end

        expect(current_path).to eq("/promises/#{@promise1.id}/edit")

        fill_in :promise_body, with: 'Nevermind!'
        click_on 'Update Promise'

        expect(current_path).to eq("/promises/#{@promise1.id}")

        expect(page).to have_content("Promise: Nevermind!")
      end
    end

    context 'promise delete' do
      it 'can remove promises' do
        visit '/promises'

        within("#promise-#{@promise1.id}") do
          click_on('Remove')
        end

        expect(current_path).to eq("/promises")
        expect(page).to have_content('Total Promises: 2')
      end
    end
  end
end
