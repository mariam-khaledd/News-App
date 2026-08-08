class CategoryItem {
  final String title;
  final String query;

  const CategoryItem({
    required this.title,
    required this.query,
  });
}

const List<CategoryItem> homeCategories = [
  CategoryItem(
    title: 'All',
    query: '',
  ),
  CategoryItem(
    title: 'Sport',
    query: 'sports',
  ),
  CategoryItem(
    title: 'Education',
    query: 'Education',
  ),
  CategoryItem(
    title: 'Health',
    query: 'health',
  ),
];