unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.StrUtils, uControleSistema,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListBox, FMX.Edit,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView;

type
  TfrmPrincipal = class(TForm)
    ComboBox1: TComboBox;
    lblInfo: TLabel;
    edtEstado: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtSigla: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
    ObjControleSistema: TControleSistema;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}
{ TFPrincipal }

procedure TfrmPrincipal.ComboBox1Change(Sender: TObject);

begin

  case TiposUF(AnsiIndexStr(ComboBox1.Items[ComboBox1.ItemIndex], Estados)) of
    tpNul:
      begin
        if not Assigned(ObjControleSistema) then
          ObjControleSistema := TControleSistemaSingleton.GetInstance;

        { Limpa todos os edits se o index do array "estados" for 0 }

        ObjControleSistema.LimparObjeto(Self);
      end
  else
    { No evento OnChange do ComboBox1 pego os dois últimos digitos e passo para o edtSigla
      atraves da funcao: "ExtrairUF"  onde pego de forma reversa
      as 2 últimas strings }

      { Extraindo o Estado e passando para o edtEstado }
    edtEstado.Text := ObjControleSistema.ExtrairUF(ComboBox1.Items[ComboBox1.ItemIndex], 6, 20);

    { Extraindo a Sigla e passando para o edtSigla }
    edtSigla.Text := ObjControleSistema.ExtrairUF(ComboBox1.Items[ComboBox1.ItemIndex], 1, 2);
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
var
  i: Integer;
begin

  { obtendo a instancia da classe pelo padrao Singleton }
  { Ao encerrar a aplicacao a classe singleton chama o seu metodo finalization passando
  TControleSistemaSingleton.ReleaseInstance();
  Com isto estamos garantindo a liberacao da instancia ( ponto de acesso global ) em memória }

  ObjControleSistema := TControleSistemaSingleton.GetInstance;

  { Percorre a lista de constantes na ordem crescente e add para o ComboBox1 }

  { Esta lista de constantes esta disponivel num ponto de acesso global pela instancia singleton da classe TControleSistema }

  for i := Ord(Low(Estados)) to Ord(High(Estados)) do
  begin
    ComboBox1.Items.Add(Estados[i]);
    ComboBox1.ItemIndex := 0;
  end;

end;

end.
