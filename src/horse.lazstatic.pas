unit Horse.LazStatic;

{$IF DEFINED(FPC)}
{$MODE DELPHI}{$H+}
{$ENDIF}

interface

uses
{$IF DEFINED(FPC)}
  SysUtils, Classes,
{$ELSE}
  System.Classes, System.SysUtils,
{$ENDIF}
  Horse, Horse.LazStatic.MimeTypes;

type
  THorseStaticResponse = class(THorseResponse)

  public
    procedure SendStatic(AFilePath:string);

  end;



function LazStatic(AStaticFolder: string): THorseCallback;

procedure Middleware(Req: THorseRequest; Res: THorseResponse; Next: {$IF DEFINED(FPC)}TNextProc{$ELSE}TProc{$ENDIF});

var
  StaticPath: string;
  AllMimes: TStringList;


implementation

procedure THorseStaticResponse.SendStatic(AFilePath: string);
var
  AStream: TFileStream;
begin
  AStream := TFileStream.Create(StaticPath + DirectorySeparator + AFilePath, fmOpenRead);
  RawWebResponse.ContentType := FindMimeTypeByExtension(AllMimes, AFilePath);
  RawWebResponse.ContentStream := AStream;
  RawWebResponse.SendContent;
  AStream.Free;
end;

function LazStatic(AStaticFolder: string): THorseCallback;

begin
  AllMimes := RegisterMimeTypes;
  StaticPath := AStaticFolder;
  Result := Middleware;
end;

procedure Middleware(Req: THorseRequest; Res: THorseResponse; Next: {$IF DEFINED(FPC)}TNextProc{$ELSE}TProc{$ENDIF});
begin
  Next();
end;

end.

