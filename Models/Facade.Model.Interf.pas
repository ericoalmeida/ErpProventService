unit Facade.Model.Interf;

interface

uses SettingsFactory.Model.Interf, ConnectionFactory.Model.Interf;

type
  iFacadeModel = interface
    ['{ABBD687A-5B26-4AC3-87AD-491A89EFD73A}']
    function ConnectionFactoryModel: iConnectionFactoryModel;
    function SettingsFactoryModel: iSettingsFactoryModel;
  end;

implementation

end.
