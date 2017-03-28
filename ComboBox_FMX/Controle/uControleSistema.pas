unit uControleSistema;

interface

uses
  System.SysUtils, FireDAC.Comp.Client,
  uSingleton, Winapi.Windows, System.TypInfo, System.StrUtils,
  System.WideStrUtils, FMX.Forms, FMX.Controls,
  System.Variants, System.Classes, FMX.Platform.Win, FMX.ListView, FMX.Edit,
  FMX.Dialogs;

type
  TiposUF = (tpNul, tpAC, tpAL, tpAM, tpBA, tpCE, tpDF, tpES, tpGO, tpMA, tpMG,
    tpMS, tpMT, tpPA, tpPB, tpPE, tpPI, tpPR, tpRJ, tpRN, tpRO, tpRR, tpRS,
    tpSC, tpSE, tpSP, tpTO);
  TControleSistema = class
  private

  public
    procedure Limpar(Controle: TComponent; const cTag: integer);
    procedure LimparObjeto(Control: TComponent);
    function ExtrairUF(S: String; Index, Count: Integer): String;

  end;

  TControleSistemaSingleton = TSingleton<TControleSistema>;

  const
  Estados: array [0 .. 24] of String = ('Escolha o Estado', 'Acre - AC',
    'Alagoas - AL', 'Amapá - AP', 'Amazonas - AM', 'Bahia - BA', 'Ceará - CE',
    'Distrito Federal - DF', 'Espírito Santo - ES', 'Goiás - GO',
    'Mato Grosso - MT', 'Mato Grosso do Sul - MS', 'Minas Gerais - MG',
    'Pará - PA', 'Paraíba - PB', 'Pernambuco - PE', 'Piauí - PI',
    'Rio de Janeiro - RJ', 'Rio Grande do Norte - RN', 'Rio Grande do Sul - RS',
    'Rondônia - RO', 'Santa Catarina - SC', 'São Paulo - SP', 'Sergipe - SE',
    'Tocantins - TO');

implementation

{ TControleSistema }

function TControleSistema.ExtrairUF(S: String; Index, Count: Integer): String;
begin

  { Declarar System.StrUtils para o Identificador: "ReverseString" }

  { Atraves desta funcao obeteremos os dois últimos caractéres que correspondem a sigla junto ao nome de cada estado }

  { esta funcao será útil caso deseja declarar os estados na constante da mesma forma que fiz }

  Result := ReverseString(S);
  Result := Copy(Result, Index, Count);
  Result := ReverseString(Result);

end;

procedure TControleSistema.Limpar(Controle: TComponent; const cTag: integer);

  { inicio de procedure Interna }

  procedure SetPropStr(Instance: TObject; const PropName: string;
    const Value: Variant);
  var
    P: Pointer;
    E: String;
  begin
    E := VarToWideStr(GetPropValue(Instance, PropName));
    P := Pointer(strtoint(E));
    TStringList(TObject(P)).Text := Value;
  end;

  { fim de procedure Interna }
const
  Propriedade: Array [0 .. 4] of String = ('Text', 'ItemIndex', 'Checked',
    'Lines', 'Items');
var
  index, i: integer;
begin
  for index := 0 to Controle.ComponentCount - 1 do
    if Controle.Components[index].tag = cTag then
      for i := 0 to High(Propriedade) do
        if isPublishedProp(Controle.Components[index], Propriedade[i]) then
        begin
          case i of
            0: { TEdit }
              SetPropValue(Controle.Components[index], Propriedade[0], '');
            1: { TMaskedit }
              SetPropValue(Controle.Components[index], Propriedade[1], -1);
            2: { TCheckBox }
              SetPropValue(Controle.Components[index], Propriedade[2], False);
            3: { TListBox }
              SetPropStr(Controle.Components[index], Propriedade[3], '');
            4: { TMemo }
              SetPropStr(Controle.Components[index], Propriedade[4], '');
          end;
          Break;
        end;
end;

procedure TControleSistema.LimparObjeto(Control: TComponent);
var
  i: integer;
begin
  for i := 0 to Control.ComponentCount - 1 do
  begin
    if (Control.Components[i] is TEdit) then
    // Verifica se o componente é do tipo TEdit, antes de limpar o objeto passado no i.
    begin
      // Aqui fiz um TypeCast de TEdit pegando a propriedade clear. Nada impediria de fazer com "AS" funciona
      // da mesma forma exemplo: (Components[i] as TEdit).Clear;
      (Control.Components[i] as TEdit).Text := '';
    end;
  end;
end;

initialization

finalization

TControleSistemaSingleton.ReleaseInstance();

end.
