// function f() {
// 	console.log(1);
// }
// var x = f;
// f = function (argument) {
// 	console.log(2);
// }

// x()



// function test(argument) {
// 	console.log(a);
// 	console.log(foo());
// 	var a = 1;
// 	function foo() {
// 		return 2
// 	}
// }
// test()


// Promise.resolve(1).then(function (a) {
// 	console.log(a);
// 	return a + 1;
// }).then(function (b) {
// 	console.log(b);
// 	throw new Error('error')
// }).catch(function (e) {
// 	console.log(e);
// 	return 1;
// }).then(function (e) {
// 	console.log(e);
// 	return e;
// }).catch(function () {
// 	console.log(100);
// })

var p1 = new Promise(function(resolve, reject) {
	setTimeout(resolve, 5000, "one");
});
var p2 = new Promise(function(resolve, reject) {
	setTimeout(resolve, 2000, "two");
});

var pa = Promise.all([p1, p2])
// Promise.all([p1, p2]).then(function(value) {
// 	console.log(value); // "two"
// 	// 两个都完成，但 p2 更快
// 	console.timeEnd('pa');
// });


// setTimeout(function(a, b) {
// 	console.log(a + b);
// }, 1000, 1, 10);
console.time('setTimeout');
var f = function(a, b) {
	console.log(a + b);
	console.timeEnd('setTimeout');
}

async function main() {
	const [r1, r2] = await pa;
	console.log(r1, r2);
	setTimeout(f.bind(null, 1, 2), 1000);
	const [rr1, rr2] = await Promise.all([pa, p1])
	console.log(rr1, rr2)
}
main()