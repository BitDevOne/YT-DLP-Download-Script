<#
.SYNOPSIS
Sprawdza, czy narzędzie `yt-dlp` jest zainstalowane, a następnie pobiera wideo i dane z linków zawartych w pliku tekstowym. Użytkownik może określić plik z linkami oraz folder docelowy, a skrypt pobiera wideo, napisy, miniatury oraz dodatkowe informacje, zapisując je w określonym folderze.

.DESCRIPTION
Skrypt PowerShell weryfikuje, czy narzędzie `yt-dlp` jest zainstalowane w systemie, a także sprawdza, czy dostępna jest jego nowsza wersja. Następnie umożliwia użytkownikowi podanie ścieżek do pliku tekstowego z linkami do pobrania oraz folderu docelowego. Dla każdego linku skrypt wykonuje pobieranie wideo w najwyższej jakości, napisów, miniatury, oraz zapisuje dodatkowe informacje w plikach JSON. Skrypt automatycznie konwertuje napisy na format SRT, osadza je w wideo, a także remuxuje wideo do formatu MP4, jeśli to konieczne. Zawiera również funkcje zapobiegające nadpisywaniu plików oraz umożliwiające dostosowanie nazw plików do systemu Windows.

.PARAMETER None
Brak parametrów wejściowych - wszystkie ścieżki (plik z linkami oraz folder docelowy) są wprowadzane przez użytkownika w trakcie działania skryptu.

.EXAMPLE
# Uruchomienie skryptu, aby pobrać wideo z linków z pliku 'links.txt' do folderu 'C:\Videos'
C:\Path\To\Script.ps1
# Skrypt poprosi o podanie ścieżki do pliku z linkami oraz folderu docelowego, a następnie pobierze wideo.

.NOTES
Twórca: BitDevOne
Wersja: 1.0
#>

# Funkcja sprawdzająca, czy yt-dlp jest zainstalowany
function Check-YTDLP {
    $ytDLPPath = (Get-Command "yt-dlp" -ErrorAction SilentlyContinue)
    if (-Not $ytDLPPath) {
        Write-Host "Błąd: yt-dlp nie jest zainstalowany lub nie znajduje się w PATH." -ForegroundColor Red
        Write-Host "Zainstaluj yt-dlp, uruchamiając:"
        Write-Host "  winget install yt-dlp" -ForegroundColor Cyan
        exit
    } else {
        Write-Host "yt-dlp jest zainstalowany." -ForegroundColor Green
    }
}

# Funkcja sprawdzająca dostępność nowej wersji yt-dlp
function Check-YTDLP-Update {
    Write-Host "Sprawdzam, czy jest dostępna nowa wersja yt-dlp..." -ForegroundColor Yellow
    $UpdateOutput = yt-dlp -U
    if ($UpdateOutput -match "yt-dlp is up to date") {
        Write-Host "Masz najnowszą wersję yt-dlp." -ForegroundColor Green
    } elseif ($UpdateOutput -match "Updating to version") {
        Write-Host "Znaleziono nową wersję yt-dlp! Zaktualizuj narzędzie." -ForegroundColor Cyan
        Write-Host "Uruchom poniższe polecenie, aby zaktualizować:"
        Write-Host "  yt-dlp -U" -ForegroundColor Cyan
        exit
    } else {
        Write-Host "Nie udało się sprawdzić aktualizacji. Upewnij się, że masz połączenie z internetem." -ForegroundColor Red
        exit
    }
}

# Funkcja do wczytania ścieżki do pliku tekstowego i folderu docelowego
function Get-UserInput {
    # Zapytanie o ścieżkę do pliku z linkami
    $InputFile = Read-Host "Podaj pełną ścieżkę do pliku z linkami (np. C:\ścieżka\do\list.txt)"
    
    # Sprawdzenie, czy plik istnieje
    if (-Not (Test-Path $InputFile)) {
        Write-Host "Błąd: Plik $InputFile nie istnieje!" -ForegroundColor Red
        exit
    }

    # Zapytanie o ścieżkę do folderu docelowego
    $OutputFolder = Read-Host "Podaj pełną ścieżkę do folderu docelowego (np. C:\ścieżka\do\folderu)"
    
    # Upewnij się, że folder docelowy istnieje
    if (-Not (Test-Path $OutputFolder)) {
        New-Item -ItemType Directory -Path $OutputFolder | Out-Null
    }

    # Zwróć obie ścieżki
    return @{InputFile=$InputFile; OutputFolder=$OutputFolder}
}

# Sprawdzenie, czy yt-dlp jest zainstalowany
Check-YTDLP

# Sprawdzenie dostępności nowej wersji yt-dlp
Check-YTDLP-Update

# Pobranie ścieżek od użytkownika
$userInput = Get-UserInput
$InputFile = $userInput.InputFile
$OutputFolder = $userInput.OutputFolder

# Pobierz każdy link z pliku tekstowego
Get-Content $InputFile | ForEach-Object {
    $Url = $_
    if (-Not [string]::IsNullOrWhiteSpace($Url)) {
        Write-Host "Pobieranie: $Url" -ForegroundColor Green
        yt-dlp `
            --no-simulate `
            --no-progress `
            --no-force-overwrites `
            --write-subs --convert-subs srt --embed-subs --sub-langs en,pl `
            --write-thumbnail --convert-thumbnail jpg --embed-thumbnail `
            --write-info-json --clean-info-json --embed-metadata `
            --remux-video mp4 `
            --format-sort "res:4320,+codec:avc:m4a" `
            --windows-filenames `
            --output "$OutputFolder\%(title)s.%(ext)s" `
            $Url
    }
}
Write-Host "Pobieranie zakończone!" -ForegroundColor Cyan
Write-Host -NoNewLine 'Naciśnij dowolny klawisz, aby kontynuować...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
