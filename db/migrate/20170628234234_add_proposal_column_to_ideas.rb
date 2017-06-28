class AddProposalColumnToIdeas < ActiveRecord::Migration[5.0]
  def change
    add_column :ideas, :proposal, :string
    add_column :ideas, :proposal_link, :string
  end
end
