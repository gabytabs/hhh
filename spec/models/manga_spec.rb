require 'rails_helper'

RSpec.describe Manga, type: :model do
  it { should validate_presence_of(:episode) }
  it { should belong_to(:manga_title)}
  it { should have_many(:manga_contents) }
end
