unit SettingsFactory.Model.interf;

interface

uses ConnectionSettings.Model.interf;

type
   iSettingsFactoryModel = interface
      ['{A707ED9B-5EE9-47EB-9C1E-72F67D436031}']
      function connection: iConnectionSettingsModel;
   end;

implementation

end.
