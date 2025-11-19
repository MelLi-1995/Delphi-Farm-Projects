program SimpleBridge;

{$APPTYPE CONSOLE}

uses
  SysUtils;

type
  // ИНТЕРФЕЙС реализации - определяет способ кормления
  IFeed = interface
    procedure Feed(AnimalName: string);  // Метод кормления
  end;

  // КОНКРЕТНАЯ РЕАЛИЗАЦИЯ 1: обычное кормление
  TNormalFeed = class(TInterfacedObject, IFeed)
    procedure Feed(AnimalName: string);  // Реализация метода
  end;

  // КОНКРЕТНАЯ РЕАЛИЗАЦИЯ 2: специальное кормление
  TSpecialFeed = class(TInterfacedObject, IFeed)
    procedure Feed(AnimalName: string);  // Реализация метода
  end;

  // АБСТРАКЦИЯ: класс животного
  TAnimal = class
  private
    FFeed: IFeed;      // Ссылка на реализацию (МОСТ)
    FName: string;     // Имя животного
  public
    constructor Create(AFeed: IFeed; AName: string);  // Конструктор
    procedure Eat;     // Метод для кормления
  end;

{ TNormalFeed }

// Реализация обычного кормления
procedure TNormalFeed.Feed(AnimalName: string);
begin
  Writeln(AnimalName, ' получает обычный корм');  // Обычное кормление
end;

{ TSpecialFeed }

// Реализация специального кормления
procedure TSpecialFeed.Feed(AnimalName: string);
begin
  Writeln(AnimalName, ' получает специальный корм');  // Специальное кормление
end;

{ TAnimal }

// Конструктор животного
constructor TAnimal.Create(AFeed: IFeed; AName: string);
begin
  inherited Create;
  FFeed := AFeed;  // Сохраняем реализацию кормления (МОСТ)
  FName := AName;  // Сохраняем имя
end;

// Метод кормления - делегирует работу реализации
procedure TAnimal.Eat;
begin
  FFeed.Feed(FName);  // МОСТ: вызываем метод реализации
end;

// Основная программа
var
  Normal, Special: IFeed;  // Объявляем реализации
  Cow, Cat: TAnimal;       // Объявляем животных

begin
  // СОЗДАЕМ РЕАЛИЗАЦИИ кормления
  Normal := TNormalFeed.Create;   // Обычное кормление
  Special := TSpecialFeed.Create; // Специальное кормление

  // СОЗДАЕМ ЖИВОТНЫХ с разными реализациями кормления
  Cow := TAnimal.Create(Normal, 'Корова');   // Корова с обычным кормлением
  Cat := TAnimal.Create(Special, 'Кот');     // Кот со специальным кормлением

  // КОРМИМ ЖИВОТНЫХ
  Cow.Eat;  // Вызывает обычное кормление
  Cat.Eat;  // Вызывает специальное кормление

  // ОСВОБОЖДАЕМ ПАМЯТЬ
  Cow.Free;
  Cat.Free;

  Readln;
end.
