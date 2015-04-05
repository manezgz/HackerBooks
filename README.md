# HackerBooks

|¿Qué otros métodos similares hay? ¿En qué se distingue isMemberOfClass: ?|
---------------------------------------------------------------------------
- isKindOfClass:Required
- isMemberOfClass:Required
- respondsToSelector:Required
- conformsToProtocol:Required

isMemberOfclass: te dice si el objeto es de una clase en concreto. isKindOfClass hace lo mismo pero tb aplica herencia, es decir devuelve true si es de una clase en concreto o de alguna clase que hereda de esa clase.

|Haz lo mismo para las imágenes de portada y los pdfs. ¿Donde guardarías estos datos?|
---------------------------------------------------------------------------------------
Los he guardado todos en el Documents, no se si hubiera sido mejor idea guardarlos en el dir Caches...

|¿Cómo harías eso? ¿Se te ocurre más de una forma de hacerlo? Explica la decisión de diseño que hayas tomado.|
----------------------------------------------------------------------------------------------------------------
Cada libro sabe si es favorito con su correspondiente propiedad isFavorite.
Para recuperar esto al arrancar la aplicacion lo que hago es serializar el array del modelo(Tendría que haber serializado el modelo completo he hubiera sido mas facil). Al arrancar lo deserializo y ya se cuales son los favoritos.
Probé a guardar directamente el array en NSUsers pero  me devolvía una excepcion, de esta forma se hace lo mismo pero en vez del array se guarda un NSData.
Pienso que era lo mismo sencillo(con mis precarios conocimientos de Objective-C).

|¿cómo enviarías información de un AGTBook a un AGTLibraryTableViewController?Se te ocurre más de una forma de hacerlo? ¿Cual te parece mejor?|
----------------------------------------------------------------------------------------------------------------
Yo lo he hecho con Notificaciones, se podría haber hecho con un protocolo y mediante delegados, pero ya tenía los delegados "ocupados".

|¿Es esto una aberración desde el punto de rendimiento (volver a cargar datos que en su mayoría ya estaban correctos)? Explica por qué no es así. ¿Hay una forma alternativa? ¿Cuando crees que vale la pena usarlo?|
------------------------------------------------------------------------------------------------------------
Solo cargaría los datos que ves en pantalla ya que no carga todo el datasource, con lo cual no supone mucha perdida de rendimiento.
Yo refresco la tabla cuando se añade o se borra algun elemento de favoritos.

|Cuando el usuario cambia en la tabla el libro seleccionado, el AGTSimplePDFViewController debe de actualizarse. ¿Cómo lo harías?|
-------------------------------------------------------------------------------------------------------------------
Por higiene he hecho que al cambair el libro seleccionado si estas en la vista de PDF se muestre la vista de libro.
De la otra forma se me bloqueaba la tabla mientras cargaba el pdf... y me parecía que no quedaba muy bien.
Todo esto imagino que se soluciona si se realiza la carga en segundo plano

Pido perdón de antemano por mis lamentables dotes como diseñador...Me estuve pegando bastante con los autolayouts y el disseño me quedo horrible, pero al menos se ve en iphone y ipad.


