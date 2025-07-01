//sum
let a = 5;
let b = 10;
let sum = a + b;
console.log("Sum:", sum);

//even or odd

let num = 7;

if (num % 2 === 0) {
  console.log(num, "is even");
} else {
  console.log(num, "is odd");
}


//1to 5loop

for (let i = 1; i <= 5; i++) {
  console.log(i);
}


///reverse string


let str = "hello";
let reversed = str.split('').reverse().join('');
console.log(reversed);


// even odd loop
for (let i = 1; i <= 10; i++) {
  if (i % 2 === 0) {
    console.log(i + " is even");
  } else {
    console.log(i + " is odd");
  }
}

//prime
for (let num = 2; num <= 20; num++) {
  let isPrime = true;
  
  for (let i = 2; i < num; i++) {
    if (num % i === 0) {
      isPrime = false;
      break;  
  }
}

  
  if (isPrime) {
    console.log(num + " is prime");
  } else {
    console.log(num + " is not prime");
  }
}



//7. Factorial-5! = 5 × 4 × 3 × 2 × 1 = 120

function factorial(n) {
  let result = 1;  

  for (let i = 1; i <= n; i++) {
    result *= i; 
  }

  return result;  
}


let number = 5;
console.log("Factorial of " + number + " is: " + factorial(number));




//8. Split the String

let sentence = "Hello My Name is Java Script";
let words = sentence.split(" ");
console.log(words);




//9.
let sentences= "apple,banana,cherry,grape";
let limitedSplit = sentence.split(",", 2);
console.log(limitedSplit);



//push
let fruits = ["apple", "banana", "cherry"];
fruits.push("orange"); 
console.log(fruits); 



//pop
let fruitss = ["apple", "banana", "cherry"];
let removed = fruits.pop(); 
console.log(fruitss); 
console.log(removed); // "cherry"

//shift

let fruitsss = ["apple", "banana", "cherry"];
let removeds = fruits.shift(); // Removes "apple"
console.log(fruitsss); // ["banana", "cherry"]
console.log(removeds); // "apple"

//unshift

let fruit = ["banana", "cherry"];
let newLength = fruits.unshift("apple"); // Adds "apple" to the beginning
console.log(fruits); // ["apple", "banana", "cherry"]
console.log(newLength); // 3



//removes element
let frui = ["apple", "banana", "cherry", "date"];
let removes = fruits.splice(1, 2); // Removes 2 elements starting from index 1
console.log(fruits); // ["apple", "date"]

//add
let fru = ["apple", "banana", "cherry"];
fru.splice(2, 0, "date", "elderberry"); 
console.log(fru); 
//concat

let fruitssss = ["apple", "banana"];
let vegetables = ["carrot", "potato"];
let food = fruits.concat(vegetables);
console.log(food); 

//slice  
let list= ["apple", "banana", "cherry", "date"];
let newFruits = fruits.slice(1, 3);
console.log(newFruits); 
console.log(fruits);

//index

let group = ["apple", "banana", "cherry"];
let index = fruits.indexOf("banana");
console.log(index); 


//for each

let comman = ["apple", "banana", "cherry"];
fruits.forEach(function(fruit) {
  console.log(fruit);
});


//map

let numbers = [1, 2, 3, 4];
let squares = numbers.map(function(number) {
  return number * number;
});
console.log(squares); 

//filter 

 numbers = [1, 2, 3, 4, 5];
let evenNumbers = numbers.filter(function(number) {
  return number % 2 === 0;
});
console.log(evenNumbers); 


//object

let person = {
  name: "John",
  age: 30,
  isEmployed: true
};

console.log(person.name); 
console.log(person["age"]); 


let map = new Map();
map.set('name', 'Alice');
map.set('age', 25);
map.set('job', 'Developer');

console.log(map.get('name')); 
console.log(map.size); 





//sets

let uniqueNumbers = new Set([1, 2, 3, 4, 5, 1, 2]);

console.log(uniqueNumbers); 
console.log(uniqueNumbers.size); // 5
console.log(uniqueNumbers.has(3)); 
uniqueNumbers.add(6); 
console.log(uniqueNumbers); 


