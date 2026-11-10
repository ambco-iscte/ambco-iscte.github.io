# frozen_string_literal: true

require 'uri'
require 'json'
require 'net/http'

module Publications
  # Automatically queries the ISCTE Repository API to get a list of my publications.
  # The list of publications is passed as a template variable to the publications.html page.
  class Generator < Jekyll::Generator
    def author_publications
      uri = URI('https://ciencia.iscte-iul.pt/api/v2_6/authors/3649/publications/all')
      response = Net::HTTP.get_response(uri)
      JSON.parse(response.body)
    end

    def generate(site)
      publications_page = site.pages.find { |page| page.name == 'publications.html' }

      response = author_publications
      publications = response['result']['author']['publications']

      publications.each do |publication|
        publication['year_online'] = publication['year'] if publication['year_online'].nil?
      end

      publications_page.data['publications'] = publications
    end
  end
end
