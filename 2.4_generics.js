// Обозначим комплексные числа как z
// и определим операции над ними
// Реализация их не важна в данный момент
realPart(z) // возвращает действительную часть числа
imagPart(z) // возвращает мнимую часть числа
magnitude(z) // возвращает модуль (длину вектора) числа
angle(z) // возвращает аргумент (угол поворота вектора) числа

// Определим конструкторы, которые возвращают комплексные числа
makeFromRealImag(realPart(z), imagPart(z)) // порождаeт комплексное число, равное z
makeFromMagAng(magnitude(z), angle(z)) // порождаeт комплексное число, равное z

// Операции надо комплексными числами в терминах абстрактных процедур
function addComplex(z1, z2) {
    return makeFromRealImag(
        realPart(z1) + realPart(z2),
        imagPart(z1) + imagPart(z2)
    );
}

function subComplex(z1, z2) {
    return makeFromRealImag(
        realPart(z1) - realPart(z2),
        imagPart(z1) - imagPart(z2)
    );
}

function mulComplex(z1, z2) {
    return makeFromMagAng(
        magnitude(z1) * magnitude(z2),
        angle(z1) + angle(z2)
    );
}

function divComplex(z1, z2) {
    return makeFromMagAng(
        magnitude(z1) / magnitude(z2),
        angle(z1) - angle(z2)
    );
}

// Представим числа как массивы из двух элементов
// Реализация Бена, первый элемент действительная часть, второй -- мнимая
function realPart(z) {
    const [ real, imag ] = z;
    return real;
}
function imagPart(z) {
    const [ real, imag ] = z;
    return imag;
}
function magnitude(z) {
    return Math.sqrt(realPart(z) ** 2 + imagPart(z) ** 2);
}
function angle(z) {
    return Math.atan(imagPart(z) / realPart(z));
}
function makeFromRealImag(x, y) {
    return [ x, y ];
}
function makeFromMagAng(r, a) {
    return [ r * Math.cos(a), r * Math.sin(a) ];
}
// Потестируем числа
var z = makeFromRealImag(2, 2);
realPart(z); // 2
imagPart(z); // 2
magnitude(z); // 2.8284271247461903
angle(z); // 0.7853981633974483
var z = makeFromMagAng(2.8284271247461903, 0.7853981633974483);
realPart(z); // 2.0000000000000004
imagPart(z); // 2
magnitude(z); // 2.8284271247461903
angle(z); // 0.7853981633974483

// Представление Лизы
function realPart(z) {
    return magnitude(z) * Math.cos(angle(z));
}
function imagPart(z) {
    return magnitude(z) * Math.sin(angle(z));
}
function magnitude(z) {
    const [ magnitude, angle ] = z;
    return magnitude;
}
function angle(z) {
    const [ magnitude, angle ] = z;
    return angle;
}
function makeFromRealImag(x, y) {
    return [ Math.sqrt(x ** 2 + y ** 2), Math.atan(y / x) ];
}
function makeFromMagAng(r, a) {
    return [ r, a ];
}
// Потестируем числа снова
var z = makeFromRealImag(2, 2);
realPart(z); // 2.0000000000000004
imagPart(z); // 2
magnitude(z); // 2.8284271247461903
angle(z); // 0.7853981633974483
var z = makeFromMagAng(2.8284271247461903, 0.7853981633974483);
realPart(z); // 2.0000000000000004
imagPart(z); // 2
magnitude(z); // 2.8284271247461903
angle(z); // 0.7853981633974483
// Как видно внутренние представления z разные в реализациях Бена и Лизы, но селекторы возвращают одинаковые значения
// Для операций addComplex, mulComplex, subComplex, divComplex можно использовать любое представление, и результаты будут идентичны

// 2.4.2
// Процедуры для проставления и извлечения метки типа и контента
function attachTag(typeTag, contents) {
    return [ typeTag, ...contents ];
}
function typeTag(datum) {
    const [ typeTag, ...contents ] = datum;
    return typeTag;
}
function contents(datum) {
    const [ typeTag, ...contents ] = datum;
    return contents;
}
// Предикаты для проверки типа
function isRectangular(z) {
    return typeTag(z) === 'rectangular';
}
function isPolar(z) {
    return typeTag(z) === 'polar';
}

// Новые процедуры Бена без кофликтов имен
function realPartRectangular(z) {
    const [ real, imag ] = z;
    return real;
}
function imagPartRectangular(z) {
    const [ real, imag ] = z;
    return imag;
}
function magnitudeRectangular(z) {
    return Math.sqrt(realPart(z) ** 2 + imagPart(z) ** 2);
}
function angleRectangular(z) {
    return Math.atan(imagPart(z) / realPart(z));
}
function makeFromRealImagRectangular(x, y) {
    return [ 'rectangular', x, y ];
}
function makeFromMagAngRectangular(r, a) {
    return [ 'polar', r * Math.cos(a), r * Math.sin(a) ];
}

// Новые процедуры Лизы без кофликтов имен
function realPartPolar(z) {
    return magnitude(z) * Math.cos(angle(z));
}
function imagPartPolar(z) {
    return magnitude(z) * Math.sin(angle(z));
}
function magnitudePolar(z) {
    const [ magnitude, angle ] = z;
    return magnitude;
}
function anglePolar(z) {
    const [ magnitude, angle ] = z;
    return angle;
}
function makeFromRealImagPolar(x, y) {
    return [ 'rectangular', Math.sqrt(x ** 2 + y ** 2), Math.atan(y / x) ];
}
function makeFromMagAngPolar(r, a) {
    return [ 'polar', r, a ];
}

// Обобщенные селекторы, которые могут использовать любой тип
function realPart(z) {
    switch (typeTag(z)) {
        case 'rectangular':
            return realPartRectangular(contents(z));
        case 'polar':
            return realPartPolar(contents(z));
        default:
            throw new Error('Неизвестный тип -- REAL-PART', z);
    }
}
function imagPart(z) {
    switch (typeTag(z)) {
        case 'rectangular':
            return imagPartRectangular(contents(z));
        case 'polar':
            return imagPartPolar(contents(z));
        default:
            throw new Error('Неизвестный тип -- IMAG-PART', z);
    }
}
function magnitude(z) {
    switch (typeTag(z)) {
        case 'rectangular':
            return magnitudeRectangular(contents(z));
        case 'polar':
            return magnitudePolar(contents(z));
        default:
            throw new Error('Неизвестный тип -- MAGNITUDE', z);
    }
}
function angle(z) {
    switch (typeTag(z)) {
        case 'rectangular':
            return angleRectangular(contents(z));
        case 'polar':
            return anglePolar(contents(z));
        default:
            throw new Error('Неизвестный тип -- ANGLE', z);
    }
}
function makeFromRealImag(x, y) {
    return makeFromRealImagRectangular(x, y);
}
function makeFromMagAng(r, a) {
    return makeFromMagAngRectangular(r, a);
}

// 2.4.3 Data-directed programming
var typesMap = new Map();
function put(operation, type, f) {
    for (const key of typesMap.keys()) {
        if (JSON.stringify(key) === JSON.stringify(type)) {
            typesMap.get(key).set(operation, f);
            return;
        }
    }
    typesMap.set(type, new Map());
    typesMap.get(type).set(operation, f);
}
function get(operation, type) {
    for (const key of typesMap.keys()) {
        if (JSON.stringify(key) === JSON.stringify(type)) {
            return typesMap.get(key).get(operation);
        }
    }
    return false;
}

// Пакет Бена
(function installRectangularPackage() {
    function realPart(z) {
        const [ real, imag ] = z;
        return real;
    }
    function imagPart(z) {
        const [ real, imag ] = z;
        return imag;
    }
    function magnitude(z) {
        return Math.sqrt(realPart(z) ** 2 + imagPart(z) ** 2);
    }
    function angle(z) {
        return Math.atan(imagPart(z) / realPart(z));
    }
    function makeFromRealImag(x, y) {
        return [ x, y ];
    }
    function makeFromMagAng(r, a) {
        return [ r * Math.cos(a), r * Math.sin(a) ];
    }
    // Интерфейс к остальной системе
    function tag(x) {
        return attachTag('rectangular', x);
    }
    put('realPart', ['rectangular'], realPart);
    put('imagPart', ['rectangular'], imagPart);
    put('magnitude', ['rectangular'], magnitude);
    put('angle', ['rectangular'], angle);
    put('makeFromRealImag', 'rectangular', (x, y) => tag(makeFromRealImag(x, y)));
    put('makeFromMagAng', 'rectangular', (r, a) => tag(makeFromMagAng(r, a)));
})();

// Пакет Лизы
(function installRectangularPackage() {
    function realPart(z) {
        return magnitude(z) * Math.cos(angle(z));
    }
    function imagPart(z) {
        return magnitude(z) * Math.sin(angle(z));
    }
    function magnitude(z) {
        const [ magnitude, angle ] = z;
        return magnitude;
    }
    function angle(z) {
        const [ magnitude, angle ] = z;
        return angle;
    }
    function makeFromRealImag(x, y) {
        return [ Math.sqrt(x ** 2 + y ** 2), Math.atan(y / x) ];
    }
    function makeFromMagAng(r, a) {
        return [ r, a ];
    }
    // Интерфейс к остальной системе
    function tag(x) {
        return attachTag('polar', x);
    }
    put('realPart', ['polar'], realPart);
    put('imagPart', ['polar'], imagPart);
    put('magnitude', ['polar'], magnitude);
    put('angle', ['polar'], angle);
    put('makeFromRealImag', 'polar', (x, y) => tag(makeFromRealImag(x, y)));
    put('makeFromMagAng', 'polar', (r, a) => tag(makeFromMagAng(r, a)));
})();

function makeFromRealImag(x, y) {
    return get('makeFromRealImag', 'rectangular')(x, y);
}
function makeFromMagAng(r, a) {
    return get('makeFromMagAng', 'polar')(r, a);
}

function applyGeneric(operation, ...args) {
    const typeTags = args.map(typeTag);
    const f = get(operation, typeTags);
    if (!f) {
        throw new Error('Нет метода для этих типов -- APPLY-GENERIC', operation, args);
    }
    return f.apply(null, args.map(contents));
    // можно так еще, эпплай не нужен
    // return f(...args.map(contents))
}
function realPart(z) {
    return applyGeneric('realPart', z);
}
function imagPart(z) {
    return applyGeneric('imagPart', z);
}
function magnitude(z) {
    return applyGeneric('magnitude', z);
}
function angle(z) {
    return applyGeneric('angle', z);
}

var z = makeFromRealImag(3, 4);
realPart(z);
