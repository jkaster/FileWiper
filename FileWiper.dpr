program FileWiper;

uses
  Forms,
  fWiper in 'fWiper.pas' {FormFileWiper};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormFileWiper, FormFileWiper);
  Application.Run;
end.
