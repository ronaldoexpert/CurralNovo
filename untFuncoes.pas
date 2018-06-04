unit untFuncoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmFuncoes = class(TForm)
    FDQueryAutoincre: TFDQuery;
    dtsAutoincre: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ExecutaSQL(pComando : string; pAcao : String; vSQL : TFDQuery);
    function AutoIncre(vTabela : string; vStatus : string) : Integer;
    procedure Botoes(vBotao : string; vSQL : TFDQuery);
    function VersaoExe: String;
    function FormataNumero(vNumero : string) : string;
    function PegaTempDir : String;       //Pega o diretorio da Pasta Temporaria
    function LerArquivoUsuario : String; //Pega o valor do arquivo usuario.txt no temp
  end;

var
  frmFuncoes: TfrmFuncoes;

implementation

{$R *.dfm}

uses untDM, untLogin;

{ TfrmFuncoes }

function TfrmFuncoes.AutoIncre(vTabela, vStatus: string): Integer;
var
  vRetorno : Integer;
begin
  vRetorno := 0;
  if vStatus = 'Novo' then
  BEGIN
    FDQueryAutoincre.SQL.Clear;
    FDQueryAutoincre.Close;
    FDQueryAutoincre.SQL.Add('Select * from AUTOINCRE where tabela = ' + QuotedStr(vTabela) +'');
    FDQueryAutoincre.OpenOrExecute;

    vRetorno := 1 + FDQueryAutoincre.FieldByName('SEQUENCIA').AsInteger;
  END
  else
  BEGIN
    FDQueryAutoincre.SQL.Clear;
    FDQueryAutoincre.Close;
    FDQueryAutoincre.SQL.Add('UPDATE AUTOINCRE SET SEQUENCIA = SEQUENCIA + 1 where tabela = ' + QuotedStr(vTabela) +'');
    FDQueryAutoincre.ExecSQL;
  END;

  Result :=  vRetorno;
end;

procedure TfrmFuncoes.Botoes(vBotao: string; vSQL: TFDQuery);
begin
  if vBotao = 'Excluir' then
  begin
    if Application.MessageBox('Deseja realmente excluir o registro?', 'Curral Novo', MB_YESNO) = mrYes then
    begin
      vSQL.Delete;
      vSQL.ApplyUpdates(-1);
    end;
  end
  ELSE if vBotao = 'Gravar' then
  begin
   vSQL.Post;
   vSQL.ApplyUpdates(-1);
   ShowMessage('Grava��o efetuada com sucesso!');
  end;
end;

procedure TfrmFuncoes.ExecutaSQL(pComando, pAcao: String; vSQL: TFDQuery);
begin
  with vSQL do
  begin
    SQL.Clear;
    Close;
    SQL.Add(pComando);
    if pAcao = 'Abrir' then
      Open
    else
      ExecSQL;
  end;
end;
function TfrmFuncoes.FormataNumero(vNumero: string): string;
var
  vRetorno : string;
begin
  if Length(vNumero) = 1 then
  begin
    vRetorno := '00000' + vNumero;
  end
  else if Length(vNumero) = 2 then
  begin
    vRetorno := '0000' + vNumero;
  end
  else if Length(vNumero) = 3 then
  begin
    vRetorno := '000' + vNumero;
  end
  else if Length(vNumero) = 4 then
  begin
    vRetorno := '00' + vNumero;
  end
  else if Length(vNumero) = 5 then
  begin
    vRetorno := '0' + vNumero;
  end
  else if Length(vNumero) = 6 then
  begin
    vRetorno := vNumero;
  end;

  Result := vRetorno;

end;

function TfrmFuncoes.LerArquivoUsuario: String;
var
  arq: TextFile;
  linha: string;
begin
  AssignFile(arq, frmLogin.vCaminhoTemp + 'usuario.txt');

  {$I-}         // desativa a diretiva de Input
  Reset(arq);   // [ 3 ] Abre o arquivo texto para leitura
  {$I+}         // ativa a diretiva de Input

  if (IOResult <> 0) then // verifica o resultado da opera��o de abertura
    ShowMessage('Erro na abertura do arquivo !!!')
  else
  begin
     while (not eof(arq)) do
     begin
       readln(arq, linha);
     end;
     CloseFile(arq);
   end;

   Result := linha;
end;

function TfrmFuncoes.PegaTempDir: String;
var DiretorioTemp : PChar;
    TempBuffer    : Dword;
begin
  TempBuffer := 255;
  GetMem(DiretorioTemp,255);
  try
    GetTempPath(tempbuffer,diretoriotemp);
    result := DiretorioTemp;
  finally
    FreeMem(diretoriotemp);
  end;
end;

function TfrmFuncoes.VersaoExe: String;
type
  PFFI = ^vs_FixedFileInfo;
var
  F : PFFI;
  Handle : Dword;
  Len : Longint;
  Data : Pchar;
  Buffer : Pointer;
  Tamanho : Dword;
  Parquivo: Pchar;
  Arquivo : String;
begin
  Arquivo := Application.ExeName;
  Parquivo := StrAlloc(Length(Arquivo) + 1);
  StrPcopy(Parquivo, Arquivo);
  Len := GetFileVersionInfoSize(Parquivo, Handle);
  Result := '';
  if Len > 0 then
  begin
    Data:=StrAlloc(Len+1);
    if GetFileVersionInfo(Parquivo,Handle,Len,Data) then
    begin
      VerQueryValue(Data, '\',Buffer,Tamanho);
      F := PFFI(Buffer);
      Result := Format('%d.%d.%d.%d',
      [HiWord(F^.dwFileVersionMs),
      LoWord(F^.dwFileVersionMs),
      HiWord(F^.dwFileVersionLs),
      Loword(F^.dwFileVersionLs)]);
    end;
    StrDispose(Data);
  end;
  StrDispose(Parquivo);
end;

end.
