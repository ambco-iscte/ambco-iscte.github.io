# frozen_string_literal: true

require 'uri'
require 'json'
require 'net/http'

module TeachingActivities
  # Automatically queries the ISCTE Repository API to get a list of my teaching activities.
  # The list of teaching activities is passed as a template variable to the about.html page.
  class Generator < Jekyll::Generator
    def get_teaching_activities(cookie)
      uri = URI('https://ciencia.iscte-iul.pt/api/v2_6/authors/3649/teaching-activities?language=en')
      headers = { 'Cookie' => cookie }
      response = Net::HTTP.get_response(uri, headers)
      JSON.parse(response.body)
    end

    # The API is weird, the degree names are only written in English if the appropriate
    # cookie has been set beforehand by sending a GET request to /lang/en
    def en_lang_cookie
      Net::HTTP.get_response(URI('https://ciencia.iscte-iul.pt/lang/en'))['set-cookie']
    end

    def generate(site)
      about_page = site.pages.find { |page| page.name == 'about.html' }

      response = get_teaching_activities(en_lang_cookie)
      teaching_activities = response['result']['author']['teaching_activities']

      about_page.data['teaching_activities'] = teaching_activities
    end
  end
end
