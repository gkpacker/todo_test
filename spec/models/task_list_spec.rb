# frozen_string_literal: true

require 'rails_helper'

describe TaskList, type: :model do
  subject { FactoryBot.create(:task_list, user: user) }
  let!(:user) { FactoryBot.create(:user) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:tasks).dependent(:destroy) }

  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end
end
