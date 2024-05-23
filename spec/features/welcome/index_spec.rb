require "rails_helper"

RSpec.describe "Index Page", type: :feature do
  describe "As a visitor" do

    before do
      json_response_info = File.read("spec/fixtures/info/joey_info.json")
      stub_request(:get, "http://localhost:3000/api/v0/employees/1")
      .to_return(status: 200, body: json_response_info)
      visit root_path
    end

    it "displays a welcome page that has buttons to each page" do
      within ".welcome_message" do
        expect(page).to have_content("Welcome to Joey's Portfolio\nSoftware Engineer")
      end

      within ".buttons" do
        expect(page).to have_button("About Me")
        click_on "About Me"        
        expect(current_path).to eq(info_index_path)

        visit root_path
        expect(page).to have_button("Projects")
        click_on "Projects"
        expect(current_path).to eq(projects_path)

        visit root_path
        expect(page).to have_button("Contact Info")
        click_on "Contact Info"
        expect(current_path).to eq(contact_index_path)
        
        visit root_path
        expect(page).to have_button("Skills")
        click_on "Skills"
        expect(current_path).to eq(skills_path)
      end
    end
  end 
end