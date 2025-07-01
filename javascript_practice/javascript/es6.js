let x = 10;
if (true) {
  let x = 20;
  console.log(x);  // 20 (block-scoped)
}
console.log(x);  // 10 (function-scoped)



const sum = (a, b) => a + b;
console.log(sum(3, 4));


let name = "John";
console.log(`Hello, ${name}!`);


function greet(name = "Guest") {
  console.log(`Hello, ${name}!`);
}
greet();  
greet("Alice");  


const arr = [1, 2, 3];
const [a, b, c] = arr;
console.log(a, b, c);

class Car {
  constructor(brand, model, year) {
    this.brand = brand;
    this.model = model;
    this.year = year;
  }

  start() {
    console.log(`🚗 The ${this.brand} ${this.model} (${this.year}) is starting...`);
  }

  getDetails() {
    return `Brand: ${this.brand}, Model: ${this.model}, Year: ${this.year}`;
  }
}

// Create a Car instance
const myCar = new Car("Toyota", "Camry", 2022);

// Use methods
myCar.start();
console.log(myCar.getDetails());



