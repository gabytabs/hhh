require 'rails_helper'

RSpec.describe MangaTitle, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:manga_type) }
  it { should validate_presence_of(:genre) }
  it { should belong_to(:user) }
  it { should have_many(:mangas) }
end
