# frozen_string_literal: true

require 'rails_helper'

describe Task, type: :model do
  subject { FactoryBot.create(:task, task_list: task_list) }
  let!(:task_list) { FactoryBot.create(:task_list) }

  it { is_expected.to belong_to(:task_list) }

  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end
end
