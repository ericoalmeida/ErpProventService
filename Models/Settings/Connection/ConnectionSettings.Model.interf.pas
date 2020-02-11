unit ConnectionSettings.Model.interf;

interface

type
  iConnectionSettingsModel = interface
    ['{ED797A4C-48A9-42FE-A793-925D7D14502A}']
    function typeDatabase: integer;
    function driver: string;
    function database: string;
    function server: string;
    function port: string;
    function user: string;
    function password: string;
    function lib: string;
  end;

implementation

end.
