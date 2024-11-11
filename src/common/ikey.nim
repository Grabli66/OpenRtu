type
    # Интерфейс позволяющий считать хэш и сравнивать объекты
    IKey*[T] = object
        # Объект который сравнивается
        obj:T
        # Считает хэш
        hash:proc(x:T):int
        # Сравнивает объекты
        equals:proc(x,y:T):bool

# Создаёт новый ключ
proc newIKey*[T](
        obj:T, hash:proc(x:T):int, equals:proc(x,y:T):bool):IKey[T] =
    return IKey[T](
        obj:obj,
        hash:hash,
        equals:equals
    )

# Считает хэш
proc hash*[T](this:IKey[T]):int =    
    return this.hash(this.obj)

# Савнивает объекты
proc `==`*[T](this:IKey[T], other:IKey[T]):bool =
    return this.equals(this.obj, other.obj)