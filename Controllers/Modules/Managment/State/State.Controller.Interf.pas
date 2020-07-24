unit State.Controller.Interf;

interface

uses State.Model.Interf, TMNGSTATE.Entity.Model;

type
   iStateInsertController = interface;
   iStateUpdateController = interface;
   iStateDeleteController = interface;
   iStateDuplicateController = interface;

   iStateController = interface
      function find(AValue: string): iStateController;
      function findById(AValue: string): iStateController;

      function insert: iStateInsertController;
      function update: iStateUpdateController;
      function Delete: iStateDeleteController;
      function Duplicate: iStateDuplicateController;

      function code: string;
      function stateId: string;
      function name: string;
      function initials: string;
      function countryId: string;
      function countryName: string;
      function createdAt: string;
      function updatedAt: string;
   end;

   iStateInsertController = interface
      function stateModel(AValue: IStateModel): iStateInsertController;
      function name(AValue: string): iStateInsertController;
      function initials(AValue: string): iStateInsertController;
      function countryId(AValue: string): iStateInsertController;

      procedure save;
   end;

   iStateUpdateController = interface
      function stateModel(AValue: IStateModel): iStateUpdateController;
      function selectedRecord(AValue: TTMNGSTATE): iStateUpdateController;
      function name(AValue: string): iStateUpdateController;
      function initials(AValue: string): iStateUpdateController;
      function countryId(AValue: string): iStateUpdateController;

      procedure save;
   end;

   iStateDeleteController = interface
      function stateModel(AValue: IStateModel): iStateDeleteController;
      function selectedRecord(AValue: TTMNGSTATE): iStateDeleteController;

      procedure save;
   end;

   iStateDuplicateController = interface
      function stateModel(AValue: IStateModel): iStateDuplicateController;
      function name(AValue: string): iStateDuplicateController;
      function initials(AValue: string): iStateDuplicateController;
      function countryId(AValue: string): iStateDuplicateController;

      procedure save;
   end;

implementation

end.
