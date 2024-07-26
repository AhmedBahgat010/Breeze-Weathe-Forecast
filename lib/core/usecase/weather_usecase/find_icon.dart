String findIcon(String name, bool type) {
  if (type) {
    switch (name) {
      case "Clouds":
        return "assets/images/sunny.png";
        break;
      case "Rain":
        return "assets/images/rainy.png";
        break;
      case "Clear":
        return "assets/images/clear.png";
        break;
      case "Drizzle":
        return "assets/images/rainy.png";
        break;
      case "Thunderstorm":
        return "assets/images/thunder.png";
        break;
      case "Snow":
        return "assets/images/snow.png";
        break;
      default:
        return "assets/images/sunny.png";
    }
  } else {
    switch (name) {
      case "Clouds":
        return "assets/images/sunny_2d.png";
        break;
      case "Rain":
        return "assets/images/rainy_2d.png";
        break;
      case "Drizzle":
        return "assets/images/rainy_2d.png";
        break;
      case "Thunderstorm":
        return "assets/images/thunder_2d.png";
        break;
      case "Snow":
        return "assets/images/snow_2d.png";
        break;
      default:
        return "assets/images/sunny_2d.png";
    }
  }
}
