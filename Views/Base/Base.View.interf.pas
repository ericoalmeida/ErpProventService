unit Base.View.interf;

interface

uses Types.Controllers;

type
  iBaseMessageView = interface
    ['{0FDD5214-2AF9-436E-A091-19C63770AB29}']
    function messages(AValue: string): iBaseMessageView;
    function &end: Boolean;
  end;

  iBaseListView = interface
    ['{178B06F7-0753-49CA-9CE1-4B0AD39EBAC7}']
    procedure insert;
    procedure update;
    procedure recover;
    procedure delete;
    procedure duplicate;
    procedure listRecords;
    procedure totalRecords;
    procedure &end;
  end;

  iBaseRegisterView = interface
    ['{ACEF692B-8873-47CE-B32F-929BFCA6F946}']
    function operation(AValue: TTypeOperation): iBaseRegisterView;
    function selectedRecord(AValue: string): iBaseRegisterView;

    procedure insert;
    procedure update;
    procedure recover;
    procedure delete;
    procedure duplicate;

    procedure save;
    procedure showDataOnScreen;
    procedure disableFields;
    procedure &end;
  end;

implementation

end.
