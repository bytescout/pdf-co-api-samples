unit ByteScoutWebApiExec;

interface

function WebAPIExec(query, api_key: string; var file_name: string): boolean;

implementation

uses
    System.SysUtils,
    Classes,
    IdHTTP,
    IdURI,
    IdSSL,
    IdSSLOpenSSL,
    System.JSON;

function WebAPIExec(query, api_key: string; var file_name: string): boolean;
var
    http: TIdHTTP;
    http_file_downloader: TIdHTTP;
    response_stream: TStringStream;
    response: string;
    io_handler: TIdSSLIOHandlerSocketOpenSSL;
    response_json: TJSONObject;
    is_error: TJSONBool;
    file_url: string;
    file_stream: TFileStream;
    error_message: TJSONString;
begin
    Result := false;
    file_name := '';
    // Put the necessary libeay32.dll & ssleay32.dll library versions in the
    // program folder
    io_handler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    io_handler.SSLOptions.Method := sslvSSLv23;
    io_handler.SSLOptions.SSLVersions := [sslvSSLv23];

    http := TIdHTTP.Create(nil);
    http.HTTPOptions := http.HTTPOptions + [hoForceEncodeParams];
    http.AllowCookies := true;
    http.HandleRedirects := true;
    http.Request.Connection := 'keep-alive';
    http.Request.ContentType := 'application/json; charset=utf-8';
    http.Request.UserAgent := 'User-Agent:Mozilla/5.0 (Windows NT 6.1; ) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36';
    http.IOHandler := io_handler;

    response_stream := TStringStream.Create();
    file_stream := nil;
    http_file_downloader := nil;
    try
        try
            // Set API Key
            http.Request.CustomHeaders.AddValue('x-api-key', api_key);
            // Execute request
            http.Get(query, response_stream);

            // Parse JSON response
            response_json := TJSONObject.ParseJSONValue(response_stream.DataString, false) as TJSONObject;
            is_error := response_json.Values['error'] as TJSONBool;
            if (not is_error.AsBoolean) then begin

                file_url := TJSONString(response_json.Values['url']).ToString();
                file_url := StringReplace(file_url, '"', '', [rfReplaceAll]);
                file_name := ExtractFileName(StringReplace(file_url, '/', '\', [rfReplaceAll]));
                file_name := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + file_name;
                http_file_downloader := TIdHTTP.Create(nil);

                // Download generated file
                file_stream := TFileStream.Create(file_name, fmCreate);
                http_file_downloader.Get(file_url, file_stream);

                Result := true;
            end else begin

                error_message := response_json.Values['message'] as TJSONString;
                raise Exception.Create(error_message.ToString);
            end;
        except
            on E: Exception do begin

                response := http.ResponseText;
                Writeln(E.ClassName, ': ', E.Message);
            end;
        end;
    finally
        response_stream.Free();
        http.Free();
        if (Assigned(file_stream)) then
            file_stream.Free();
        if (Assigned(http_file_downloader)) then
            http_file_downloader.Free();
    end;
end;

end.
