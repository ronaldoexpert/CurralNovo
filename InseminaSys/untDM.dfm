object DM: TDM
  OldCreateOrder = False
  Height = 426
  Width = 702
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Database=C:\DelphiBerlin\Curral Novo\BD\INSEMINASYS.FDB'
      'DriverID=FB')
    LoginPrompt = False
    Left = 40
    Top = 40
  end
  object qryUsuario: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    Left = 32
    Top = 104
  end
  object dtsUsuario: TDataSource
    DataSet = qryUsuario
    Left = 80
    Top = 104
  end
  object qryInseminacao: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    Left = 32
    Top = 160
  end
  object dtsInseminacao: TDataSource
    DataSet = qryInseminacao
    Left = 80
    Top = 160
  end
  object qryCria: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    Left = 32
    Top = 224
  end
  object dtsCria: TDataSource
    DataSet = qryCria
    Left = 80
    Top = 224
  end
  object dtsProprietario: TDataSource
    DataSet = qryProprietario
    Left = 208
    Top = 104
  end
  object qryProprietario: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    Left = 160
    Top = 104
  end
  object qryMae: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    Left = 160
    Top = 168
  end
  object dtsMae: TDataSource
    DataSet = qryMae
    Left = 208
    Top = 168
  end
  object qryCadastro: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    Left = 160
    Top = 224
  end
  object dtsCadastro: TDataSource
    DataSet = qryCadastro
    Left = 208
    Top = 224
  end
  object qryConfirmados: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    Left = 288
    Top = 104
  end
  object dtsConfirmados: TDataSource
    DataSet = qryConfirmados
    Left = 336
    Top = 104
  end
  object qryAConfirmar: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    FetchOptions.AssignedValues = [evRowsetSize, evRecordCountMode]
    FetchOptions.RowsetSize = 9999999
    FetchOptions.RecordCountMode = cmTotal
    Left = 280
    Top = 160
  end
  object dtsAConfirmar: TDataSource
    DataSet = qryAConfirmar
    Left = 336
    Top = 160
  end
  object qryAnimal: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    Left = 280
    Top = 216
  end
  object dtsAnimal: TDataSource
    DataSet = qryAnimal
    Left = 336
    Top = 216
  end
  object qryVeterinario: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    Left = 416
    Top = 104
  end
  object dtsVeterinario: TDataSource
    DataSet = qryVeterinario
    Left = 472
    Top = 104
  end
  object qryCadInseminacao: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    Left = 416
    Top = 160
  end
  object dtsCadInseminacao: TDataSource
    DataSet = qryCadInseminacao
    Left = 472
    Top = 160
  end
  object qryConfiguracao: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    Left = 416
    Top = 216
  end
  object dtsConfiguracao: TDataSource
    DataSet = qryConfiguracao
    Left = 472
    Top = 216
  end
  object qryMoviInseminacao: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateMode]
    Left = 416
    Top = 272
  end
  object dtsMoviInseminacao: TDataSource
    DataSet = qryMoviInseminacao
    Left = 472
    Top = 272
  end
  object qryServico: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    Left = 280
    Top = 272
  end
  object dtsServico: TDataSource
    DataSet = qryServico
    Left = 336
    Top = 272
  end
  object qryProduto: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    Left = 280
    Top = 328
  end
  object dtsProduto: TDataSource
    DataSet = qryProduto
    Left = 336
    Top = 328
  end
  object qryAuxiliar: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateMode]
    Left = 416
    Top = 336
  end
  object dtsAuxiliar: TDataSource
    DataSet = qryAuxiliar
    Left = 472
    Top = 336
  end
  object qryEmpresa: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    Left = 32
    Top = 280
  end
  object dtsEmpresa: TDataSource
    DataSet = qryEmpresa
    Left = 80
    Top = 280
  end
  object qryLiberacao: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    Left = 32
    Top = 336
  end
  object dsLiberacao: TDataSource
    DataSet = qryLiberacao
    Left = 80
    Top = 336
  end
end
