program ComboBox;

uses
  System.StartUpCopy,
  FMX.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uSingleton in 'Controle\uSingleton.pas',
  uControleSistema in 'Controle\uControleSistema.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
