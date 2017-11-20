let zero = f => x => x;
let addOne = n => f => x => f(n(f)(x));

let one;
one = addOne(zero);
one = (n => f => x => f(n(f)(x)))(f => x => x);
one = f => x => f((f => x => x)(f)(x));
one = f => x => f((x => x)(x));
one = f => x => f(x);

let two;
two = addOne(one);
two = (n => f => x => f(n(f)(x)))(f => x => f(x));
two = f => x => f((f => x => f(x))(f)(x));
two = f => x => f((x => f(x))(x));
two = f => x => f(f(x));

let three;
three = addOne(two);
three = (n => f => x => f(n(f)(x)))(f => x => f(f(x)));
three = f => x => f((f => x => f(f(x)))(f)(x));
three = f => x => f((x => f(f(x)))(x));
three = f => x => f(f(f(x)));

const sum = (n, m) => f => x => n(f)(m(f(x)));

const churchToNumber = churchNumber => {
    const inc = x => x + 1;
    return churchNumber(inc)(0);
}

churchToNumber(one);
churchToNumber(two);
churchToNumber(three);
