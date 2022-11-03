# frozen_string_literal: true

class PathfinderShow::EquipamentComponent < ViewComponent::Base
	include ShowCharactersHelper
	def initialize(character:)
		@character = character
	end
end
