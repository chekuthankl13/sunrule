class CategoryWidget {
  static const dummynewCategories = [
    {"txt": "Kitchen Needs", "img": ""},
    {"txt": "Pet Care", "img": ""},
    {"txt": "Gift Store", "img": ""},
    {"txt": "Groccery", "img": ""},
  ];

  //// all categories
  static const dummyAllCat = [
    {
      "txt": "Fruits & Vegetables",
      "id": "1",
      "img": "https://example.com/fruits_vegetables.jpg",
    },
    {
      "txt": "Dairy & Eggs",
      "id": "2",
      "img": "https://example.com/dairy_eggs.jpg",
    },
    {
      "txt": "Meat & Seafood",
      "id": "3",
      "img": "https://example.com/meat_seafood.jpg",
    },
    {
      "txt": "Bakery",
      "id": "4",
      "img": "https://example.com/bakery.jpg",
    },
    {
      "txt": "Pantry",
      "id": "5",
      "img": "https://example.com/pantry.jpg",
    },
    {
      "txt": "Beverages",
      "id": "6",
      "img": "https://example.com/beverages.jpg",
    },
    {
      "txt": "Frozen Foods",
      "id": "7",
      "img": "https://example.com/frozen_foods.jpg",
    },
    {
      "txt": "Snacks",
      "id": "8",
      "img": "https://example.com/snacks.jpg",
    },
    {
      "txt": "Personal Care",
      "id": "9",
      "img": "https://example.com/personal_care.jpg",
    },
    {
      "txt": "Cleaning Supplies",
      "id": "10",
      "img": "https://example.com/cleaning_supplies.jpg",
    },
    {
      "txt": "Baby Care",
      "id": "11",
      "img": "https://example.com/baby_care.jpg",
    },
    {
      "txt": "Pet Supplies",
      "id": "12",
      "img": "https://example.com/pet_supplies.jpg",
    },
    {
      "txt": "Health & Wellness",
      "id": "13",
      "img": "https://example.com/health_wellness.jpg",
    },
    {
      "txt": "Household Essentials",
      "id": "14",
      "img": "https://example.com/household_essentials.jpg",
    },
    {
      "txt": "Office & School Supplies",
      "id": "15",
      "img": "https://example.com/office_school_supplies.jpg",
    },
    {
      "txt": "Home & Kitchen",
      "id": "16",
      "img": "https://example.com/home_kitchen.jpg",
    },
  ];

  static const dummySubCat = [
    {
      "category_id": "1",
      "id": "1",
      "txt": "Fruits",
      "img": "https://example.com/home_kitchen.jpg",
    },
    {
      "category_id": "1",
      "id": "2",
      "txt": "Vegetables",
      "img": "https://example.com/home_kitchen.jpg",
    },
    {
      "category_id": "2",
      "id": "3",
      "txt": "Milk",
      "img": "https://example.com/home_kitchen.jpg",
    },
    {
      "category_id": "2",
      "id": "4",
      "txt": "Cheese",
      "img": "https://example.com/home_kitchen.jpg",
    },
    {
      "category_id": "2",
      "id": "5",
      "txt": "Egg",
      "img": "https://example.com/home_kitchen.jpg",
    },
    {
      "category_id": "4",
      "id": "6",
      "txt": "Bread",
      "img": "https://example.com/home_kitchen.jpg",
    }
  ];

  static const dummyPdt = [
    {
      "category_id":"1",
      "subcategory_id":"1",
      "id": "1",
      "price":"100",
      "off_price":"",
      "off_percen":"",
      "txt": "Apple",
      "img": "https://example.com/home_kitchen.jpg",
    },
    {
      "category_id":"1",
      "subcategory_id":"1",
      "id": "2",
      "price":"100",
      "off_price":"",
      "off_percen":"",
      "txt": "Bannana",
      "img": "https://example.com/home_kitchen.jpg",
    },
    {
      "category_id":"1",
      "subcategory_id":"2",
      "id": "3",
      "price":"100",
      "off_price":"",
      "off_percen":"",
      "txt": "Carrot",
      "img": "https://example.com/home_kitchen.jpg",
    },
     {
      "category_id":"1",
      "subcategory_id":"2",
      "id": "4",
      "price":"100",
      "off_price":"",
      "off_percen":"",
      "txt": "Brocoli",
      "img": "https://example.com/home_kitchen.jpg",
    },
     {
      "category_id":"2",
      "subcategory_id":"3",
      "id": "5",
      "price":"100",
      "off_price":"",
      "off_percen":"",
      "txt": "Whole milk",
      "img": "https://example.com/home_kitchen.jpg",
    },
    {
      "category_id":"2",
      "subcategory_id":"3",
      "id": "6",
      "price":"100",
      "off_price":"",
      "off_percen":"",
      "txt": "Skim milk",
      "img": "https://example.com/home_kitchen.jpg",
    },
    {
      "category_id":"2",
      "subcategory_id":"4",
      "id": "7",
      "price":"100",
      "off_price":"",
      "off_percen":"",
      "txt": "Cheedar Cheese",
      "img": "https://example.com/home_kitchen.jpg",
    },
     {
      "category_id":"2",
      "subcategory_id":"4",
      "id": "8",
      "price":"100",
      "off_price":"",
      "off_percen":"",
      "txt": "Swiss Cheese",
      "img": "https://example.com/home_kitchen.jpg",
    },
     {
      "category_id":"2",
      "subcategory_id":"5",
      "id": "9",
      "price":"100",
      "off_price":"",
      "off_percen":"",
      "txt": "Duck Egg",
      "img": "https://example.com/home_kitchen.jpg",
    },

     {
      "category_id":"4",
      "subcategory_id":"6",
      "id": "10",
      "price":"100",
      "off_price":"",
      "off_percen":"",
      "txt": "White Bread",
      "img": "https://example.com/home_kitchen.jpg",
    },
    {
      "category_id":"4",
      "subcategory_id":"6",
      "id": "11",
      "price":"100",
      "off_price":"",
      "off_percen":"",
      "txt": "Whole Wheat Bread",
      "img": "https://example.com/home_kitchen.jpg",
    },
  ];
}
