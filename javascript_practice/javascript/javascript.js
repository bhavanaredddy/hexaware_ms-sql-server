let x = 10;

if (x === 10) {
  let x = 20;
  console.log(x); 
}

console.log(x); 


for (let i = 0; i < 5; i++) {
  setTimeout(() => console.log(i), 1000);
}




function sum(a, b) {
  return a + b;
}

let result = sum(10, 20);
console.log(result);





function isPalindrome(str) {
  let reversedStr = str.split("").reverse().join("");
  return str === reversedStr;
}

console.log(isPalindrome("madam")); 
console.log(isPalindrome("hello"));


function isPrime(num) {
  if (num <= 1) return false;
  for (let i = 2; i <= Math.sqrt(num); i++) {
    if (num % i === 0) return false;
  }
  return true;
}

console.log(isPrime(7));
console.log(isPrime(10));



function calculator(a, b, operation) {
  switch (operation) {
    case "add":
      return a + b;
    case "subtract":
      return a - b;
    case "multiply":
      return a * b;
    case "divide":
      return a / b;
    default:
      return "Invalid operation";
  }
}

console.log(calculator(10, 5, "add")); 
console.log(calculator(10, 5, "divide")); 
