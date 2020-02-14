unit State.Controller.Interf;

interface

uses State.Model.Interf, TGERESTADO.Entity.Model;

type
  iStateInsertController = interface;
  iStateUpdateController = interface;
  iStateDeleteController = interface;
  iStateDuplicateController = interface;

  iStateController = interface
    function find(AValue: string): iStateController;

    function insert: iStateInsertController;
    function update: iStateUpdateController;
    function Delete: iStateDeleteController;
    function Duplicate: iStateDuplicateController;

    function stateId: string;
    function description: string;
    function countryId: string;
    function countryDescription: string;
    function createdDate: string;
    function updatedDate: string;
  end;

  iStateInsertController = interface
    function stateModel(AValue: IStateModel): iStateInsertController;
    function description(AValue: string): iStateInsertController;
    function countryId(AValue: string): iStateInsertController;

    procedure save;
  end;

  iStateUpdateController = interface
    function stateModel(AValue: IStateModel): iStateUpdateController;
    function selectedRecord(AValue: TTGERESTADO): iStateUpdateController;
    function description(AValue: string): iStateUpdateController;
    function countryId(AValue: string): iStateUpdateController;

    procedure save;
  end;

  iStateDeleteController = interface
    function stateModel(AValue: IStateModel): iStateDeleteController;
    function selectedRecord(AValue: TTGERESTADO): iStateDeleteController;

    procedure save;
  end;

  iStateDuplicateController = interface
    function stateModel(AValue: IStateModel)
      : iStateDuplicateController;
    function description(AValue: string): iStateDuplicateController;
    function countryId(AValue: string): iStateDuplicateController;

    procedure save;
  end;

implementation

end.
