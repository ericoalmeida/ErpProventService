unit Vehicle.Model.Interf;

interface

uses ormbr.container.objectset.interfaces, TASSVEHICLE.Entity.Model;

type
   IVehicleModel = interface
      ['{66952D14-24EA-4277-83BD-1407C7C2CFF3}']
      function Entity: TTASSVEHICLE; overload;
      function Entity(AValue: TTASSVEHICLE): IVehicleModel; overload;
      function DAO: IContainerObjectSet<TTASSVEHICLE>;
   end;

implementation

end.
