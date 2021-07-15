import WidgetKit
import SwiftUI

struct Recipe: Codable, Identifiable {
  let id: Int
  let title: String
}

let recipe = Recipe(id: 1, title: "Tagliatelle with meatballs")

struct Provider: TimelineProvider {
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(family: context.family, recipe: recipe)
  }

  func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    let entry = SimpleEntry(family: context.family, recipe: recipe)
    completion(entry)
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    let timeline = Timeline(entries: [SimpleEntry(family: context.family, recipe: recipe)], policy: .atEnd)
    completion(timeline)
  }
}

struct SimpleEntry: TimelineEntry {
  let date = Date()
  let family: WidgetFamily
  let recipe: Recipe
}

struct CoookWidgetEntryView : View {
  let entry: Provider.Entry

  var body: some View {
    switch entry.family {
    case .systemSmall:
      ZStack {
        Image("meatball")
          .resizable()
          .scaledToFill()
        VStack {
          RoundedText(text: "RECIPE OF THE DAY", style: .caption, weight: .heavy)
            .padding(5)
          Spacer()
        }
      }
    case .systemMedium:
      HStack(alignment: .top) {
        Image("meatball")
          .resizable()
          .scaledToFit()
        VStack(alignment: .leading, spacing: 8) {
          RoundedText(text: "RECIPE OF THE DAY", style: .caption, weight: .heavy)
          RoundedText(text: entry.recipe.title, style: .body, weight: .heavy)
          RoundedText(text: "Serves 4", style: .caption, weight: .heavy)
            .foregroundColor(.secondary)
        }
        .padding()
        Spacer()
      }
    case .systemLarge:
      ZStack {
        VStack(spacing: 0) {
          HStack(spacing: 0) {
            Image("skewers")
              .resizable()
              .scaledToFill()
            Image("meatball")
              .resizable()
              .scaledToFill()
          }
          HStack(spacing: 0) {
            Image("pana")
              .resizable()
              .scaledToFill()
            Image("neg")
              .resizable()
              .scaledToFill()
          }
        }
        RoundedText(text: "DINNER PARTY", style: .body, weight: .heavy)
      }
    case .systemExtraLarge:
      Text("XL")
    @unknown default:
      fatalError("New size added")
    }
  }
}

@main
struct CoookWidget: Widget {
  let kind: String = "CoookWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      CoookWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("My Widget")
    .description("This is an example widget.")
  }
}

struct CoookWidget_Previews: PreviewProvider {
  static var previews: some View {
    CoookWidgetEntryView(entry: SimpleEntry(family: .systemMedium, recipe: recipe))
      .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}

struct RoundedText: View {
  let text: String
  let style: Font.TextStyle
  let weight: Font.Weight

  var body: some View {
    Text(text)
      .font(.system(style, design: .rounded))
      .fontWeight(weight)
  }
}
