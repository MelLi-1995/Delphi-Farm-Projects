program FarmHierarchy;

{$APPTYPE CONSOLE}

uses
  SysUtils;

type
  // БАЗОВЫЙ КЛАСС для всех таксономических единиц
  TTaxonomy = class
  private
    FName: string;  // Название таксономической единицы
  public
    constructor Create(const AName: string);  // Конструктор
    property Name: string read FName;  // Свойство только для чтения
  end;

  // КЛАССЫ-НАСЛЕДНИКИ для каждой таксономической категории
  TType = class(TTaxonomy)     // Тип
  end;

  TClass = class(TTaxonomy)    // Класс
  end;

  TOrder = class(TTaxonomy)    // Отряд
  end;

  TFamily = class(TTaxonomy)   // Семейство
  end;

  TGenus = class(TTaxonomy)    // Род
  end;

  TSpecies = class(TTaxonomy)  // Вид
  end;

  // КЛАСС ЖИВОТНОГО - использует АГРЕГАЦИЮ таксономических классов
  TAnimal = class
  private
    FName: string;    // Имя животного
    FType: TType;     // АГРЕГАЦИЯ: объект типа
    FClass: TClass;   // АГРЕГАЦИЯ: объект класса
    FOrder: TOrder;   // АГРЕГАЦИЯ: объект отряда
    FFamily: TFamily; // АГРЕГАЦИЯ: объект семейства
    FGenus: TGenus;   // АГРЕГАЦИЯ: объект рода
    FSpecies: TSpecies; // АГРЕГАЦИЯ: объект вида
  public
    // Конструктор принимает все таксономические объекты
    constructor Create(const AName: string; AType: TType; AClass: TClass;
      AOrder: TOrder; AFamily: TFamily; AGenus: TGenus; ASpecies: TSpecies);
    destructor Destroy; override;  // Деструктор для очистки памяти
    procedure DisplayTaxonomy;     // Показать всю таксономию
    property Name: string read FName;  // Свойство имени
  end;

  // КОНКРЕТНЫЕ КЛАССЫ ЖИВОТНЫХ - НАСЛЕДОВАНИЕ от TAnimal
  TCow = class(TAnimal)  // НАСЛЕДОВАНИЕ: корова - это животное
  public
    constructor Create(const AName: string);
  end;

  TCat = class(TAnimal)  // НАСЛЕДОВАНИЕ: кот - это животное
  public
    constructor Create(const AName: string);
  end;

{ TTaxonomy }

// Конструктор таксономической единицы
constructor TTaxonomy.Create(const AName: string);
begin
  inherited Create;
  FName := AName;  // Устанавливаем название
end;

{ TAnimal }

// Конструктор животного - создает объект со всей таксономией
constructor TAnimal.Create(const AName: string; AType: TType; AClass: TClass;
  AOrder: TOrder; AFamily: TFamily; AGenus: TGenus; ASpecies: TSpecies);
begin
  inherited Create;
  FName := AName;    // Устанавливаем имя животного
  // АГРЕГАЦИЯ: сохраняем ссылки на таксономические объекты
  FType := AType;
  FClass := AClass;
  FOrder := AOrder;
  FFamily := AFamily;
  FGenus := AGenus;
  FSpecies := ASpecies;
end;

// Деструктор - освобождает память всех таксономических объектов
destructor TAnimal.Destroy;
begin
  FType.Free;    // Освобождаем объект типа
  FClass.Free;   // Освобождаем объект класса
  FOrder.Free;   // Освобождаем объект отряда
  FFamily.Free;  // Освобождаем объект семейства
  FGenus.Free;   // Освобождаем объект рода
  FSpecies.Free; // Освобождаем объект вида
  inherited;     // Вызываем родительский деструктор
end;

// Метод для отображения таксономии животного
procedure TAnimal.DisplayTaxonomy;
begin
  Writeln('Таксономия для ', FName, ':');
  Writeln('  Тип: ', FType.Name);      // Используем агрегированные объекты
  Writeln('  Класс: ', FClass.Name);
  Writeln('  Отряд: ', FOrder.Name);
  Writeln('  Семейство: ', FFamily.Name);
  Writeln('  Род: ', FGenus.Name);
  Writeln('  Вид: ', FSpecies.Name);
  Writeln;
end;

{ TCow }

// Конструктор коробы - создает корову с конкретной таксономией
constructor TCow.Create(const AName: string);
begin
  // НАСЛЕДОВАНИЕ: вызываем родительский конструктор с конкретными параметрами
  inherited Create(AName,
    TType.Create('Хордовые'),          // Создаем объект типа
    TClass.Create('Млекопитающие'),    // Создаем объект класса
    TOrder.Create('Парнокопытные'),    // Создаем объект отряда
    TFamily.Create('Полорогие'),       // Создаем объект семейства
    TGenus.Create('Настоящие быки'),   // Создаем объект рода
    TSpecies.Create('Корова')          // Создаем объект вида
  );
end;

{ TCat }

// Конструктор кота - создает кота с конкретной таксономией
constructor TCat.Create(const AName: string);
begin
  // НАСЛЕДОВАНИЕ: вызываем родительский конструктор с конкретными параметрами
  inherited Create(AName,
    TType.Create('Хордовые'),      // Создаем объект типа
    TClass.Create('Млекопитающие'),// Создаем объект класса
    TOrder.Create('Хищные'),       // Создаем объект отряда
    TFamily.Create('Кошачьи'),     // Создаем объект семейства
    TGenus.Create('Кошки'),        // Создаем объект рода
    TSpecies.Create('Кошка')       // Создаем объект вида
  );
end;

// Основная программа
var
  Cow: TCow;  // Объект коровы
  Cat: TCat;  // Объект кота

begin
  try
    Writeln('=== Ферма "Ново-Простоквашино" ===');

    // СОЗДАЕМ КОРОВУ и показываем ее таксономию
    Cow := TCow.Create('Мурка');  // Создаем объект коровы
    try
      Cow.DisplayTaxonomy;  // Показываем таксономию коровы
    finally
      Cow.Free;  // Освобождаем память
    end;

    // СОЗДАЕМ КОТА и показываем его таксономию
    Cat := TCat.Create('Барсикф');  // Создаем объект кота
    try
      Cat.DisplayTaxonomy;  // Показываем таксономию кота
    finally
      Cat.Free;  // Освобождаем память
    end;

    Readln;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);  // Обработка ошибок
  end;
end.
