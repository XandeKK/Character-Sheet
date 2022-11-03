# frozen_string_literal: true

class PathfinderShow::OffenseComponent < ViewComponent::Base
	include ShowCharactersHelper
	def initialize(character:)
		@character = character
	end
end
