
enum FoodCategory{
  KOREAN_FOOD('KOREAN_FOOD', '한식'),
  JAPANESE_FOOD('JAPANESE_FOOD', '일식'),
  CHINEESE_FOOD('CHINEESE_FOOD', '중식');

  final String engName;
  final String korName;

  const FoodCategory(this.engName, this.korName);
}