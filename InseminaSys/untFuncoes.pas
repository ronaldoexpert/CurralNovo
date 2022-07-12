unit untFuncoes;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, IniFiles, Registry, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
  Vcl.StdCtrls, FireDAC.Phys.IBWrapper, FireDAC.Phys.IBBase,
  DateUtils, Vcl.Imaging.pngimage, Vcl.Mask, Vcl.DBCtrls, Windows;

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
    procedure GravaLog (vLog, vUsuario : String);     //Versao 1.2.0 - 04/07/2018
    function LerArquivoIni(vSecao, vLinha : String) : string;     //Versao 1.5.0 - 25/10/2018 - RS
    function LiberaSistema(out msg : string) : Boolean;
    function DataSQL(data, formato: string): string;    //Versao 3.0.0 - 12/07/2022
    function UsuarioWindows: string;                  //Versao 3.0.0 - 12/07/2022
  end;

var
  frmFuncoes: TfrmFuncoes;

implementation

{$R *.dfm}

uses untDM, untLogin;

{ TfrmFuncoes }

function TfrmFuncoes.UsuarioWindows: string;     //Versao 14.0.5 - 17/02/2021 - RS
var
  I: DWord;
  user: string;
begin
  I := 255;
  SetLength(user, I);
  Windows.GetUserName(PChar(user), I);
  user := string(PChar(user));
  result := user;
end;

function TfrmFuncoes.DataSQL(data,formato: string): string;  //Versao 3.0.0 - 12/07/2022
begin
  if formato = 'aaaa,mm,dd' then
    Result := data[7]+data[8]+data[9]+data[10]+','+ data[4]+data[5]+','+data[1]+data[2];
  if formato = 'mm,dd,aaaa' then
    Result := data[4]+data[5]+','+data[1]+ data[2]+','+data[7]+data[8]+data[9]+data[10];
  if formato = 'mm/dd/aaaa' then    // quando vai para sql
    Result := data[4]+data[5]+'/'+data[1]+ data[2]+'/'+data[7]+data[8]+data[9]+data[10];
  if formato = 'aaaa-mm-dd' then    // quando vai para sql
    Result := data[7]+data[8]+data[9]+data[10]+'-'+ data[4]+data[5]+'-'+data[1]+data[2];
end;

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
   ShowMessage('Gravação efetuada com sucesso!');
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

procedure TfrmFuncoes.GravaLog (vLog, vUsuario : String);     //Versao 1.2.0 - 04/07/2018
var
  arq: TextFile;
  i, n: integer;
  vNomeArquivo, vTexto, vHora : string;
begin
  try
    vNomeArquivo := 'Logs\' + FormatDateTime('DDMMYYY', date) + '.txt';

    vHora := TimeToStr(Time);

    vTexto := vHora + ', ' + vLog + ', ' + vUsuario;

    AssignFile(arq, vNomeArquivo);
    if FileExists(vNomeArquivo) then
    begin
      Append(arq);
    end
    else
    begin
      Rewrite(arq);
    end;

    Writeln(arq, vTexto);
    CloseFile(arq);
  except
  end;

end;

function TfrmFuncoes.LerArquivoIni(vSecao, vLinha : String): string;      //Versao 1.5.0 - 25/10/2018 - RS
var
  vComando : String;
begin
  if FileExists( ExtractFilePath( Application.ExeName ) + 'COMANDOS.ini' ) then // Testa Existência do arquivo
  begin                    // ENDEREÇO DO ARQUIVO                   { NOME
    with  TIniFile.Create( ExtractFilePath( Application.ExeName ) + 'COMANDOS.ini' ) do // Cria a estância do Objeto em Memória.
    begin                                // SEÇÃO     { CHAVE         { VALOR PADRAO
      vComando := ReadString(vSecao, vLinha, ''); // ReadString   - Lê um parâmetro como String;
      Free;
    end;
  end
  else
  begin
    ShowMessage( 'Arquivo Ini Não Encontrado!!!' );
  end;

  Result := vComando;
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

  if (IOResult <> 0) then // verifica o resultado da operação de abertura
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

function TfrmFuncoes.LiberaSistema(out msg : string): Boolean;
var
  vRetorno : Boolean;
begin
  vRetorno := True;
  ExecutaSQL('SELECT * FROM CONFIGURACAO', 'Abrir', DM.qryLiberacao);

  if DM.qryLiberacao.FieldByName('BASE').AsString = 'SB' then
  BEGIN
    if DM.qryLiberacao.FieldByName('DATA_BASE').AsDateTime < Date then
    begin
      vRetorno := False;
      msg := 'Sistema Bloqueado! Entre em contato para fazer a liberação!';
    end
    else
    begin
      vRetorno := True;
      msg := '****** Período de Testes ******' + #13 + 'O sistema será desativado em: ' + DM.qryLiberacao.FieldByName('DATA_BASE').AsString;
    end;
  END
  ELSE
    vRetorno := True;

  Result := vRetorno;
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
