import SwiftUI

struct Recipe: Codable, Identifiable {
  let id: Int
  let title: String?
  let summary: String?
  let prep_time_mins: Int?
  let cook_time_mins: Int?
  let servings: Int?
  let hidden: Bool?
  let photo: Collection.Image?
  let ingredient_lists: [IngredientList]?
  let recipe_step_lists: [StepList]?
  let web_view: String?
  let usdz: String?

  func containsKeyword(_ keyword: String) -> Bool {
    [title, summary]
      .compactMap { $0 }
      .joined(separator: " ")
      .contains(keyword) ||
    (ingredient_lists ?? [])
      .flatMap { $0.ingredients ?? [] }
      .map { $0.description }
      .joined(separator: " ")
      .contains(keyword)
  }
  
  var totalCookingTime: Int {
    guard let prepTime = prep_time_mins, let cookTime = cook_time_mins else { return 0 }
    let totalTime = prepTime + cookTime
    guard totalTime != 0 else { return 0 }
    return totalTime
  }

  var ingredientListsWithIngredients: [IngredientList] {
    ingredient_lists?.filter { $0.ingredients?.isEmpty == false } ?? []
  }

  var recipeStepListsWithSteps: [StepList] {
    recipe_step_lists?.filter { $0.stepsWithTimers.isEmpty == false } ?? []
  }

  struct IngredientList: Codable, Identifiable {
    let id: Int
    let title: String?
    let ingredients: [Ingredient]?

    struct Ingredient: Codable, Identifiable {
      let id: Int
      let names: QuantityLocalized?
      let quantity: Double?
      let preparation_instructions_past: String?
      let unit: QuantityLocalized?

      var description: String {
        var description = ""
        if let quantity = quantity {
          description += quantity.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", quantity) : String(quantity)
        }
        if let unit = localizedUnit {
          description += unit
        }
        if !description.isEmpty {
          description += " "
        }
        if let name = localizedName {
          description += name.capitalized
        }
        return description
      }

      private var localizedName: String? {
        guard let quantity = quantity else { return names?.plural }
        return quantity > 1 ? names?.plural : names?.singular
      }

      private var localizedUnit: String? {
        guard let quantity = quantity else { return unit?.plural }
        return quantity > 1 ? unit?.plural : unit?.singular
      }

      struct QuantityLocalized: Codable {
        let singular: String?
        let plural: String?
      }
    }
  }

  struct StepList: Codable, Identifiable {
    let id: Int
    let title: String?
    let recipe_steps: [Step]?

    var stepsWithTimers: [StepWithTimer] {
      let steps = recipe_steps ?? []
      return steps.compactMap { StepWithTimer(from: $0) }
    }

    struct Step: Codable, Identifiable {
      let id: Int
      let instructions: String?
      let timer_seconds_lower_bound: Int?
      let timer_seconds_upper_bound: Int?
      let position: Int?
    }

    struct StepWithTimer: Codable, Identifiable {
      let id: Int
      let hasTimer: Bool
      let totalTime: Int
      let instructions: String?
      let position: Int?

      init(from step: Step) {
        self.id = step.id
        self.hasTimer = ((step.instructions?.contains("<timer>") == true || step.instructions?.contains("</timer>") == true) && step.timer_seconds_upper_bound != 0)
        self.totalTime = step.timer_seconds_upper_bound ?? 0
        let newInstructions = step.instructions?.replacingOccurrences(of: "<timer>", with: "")
        self.instructions = newInstructions?.replacingOccurrences(of: "</timer>", with: "")
        self.position = step.position
      }
    }
  }
}
