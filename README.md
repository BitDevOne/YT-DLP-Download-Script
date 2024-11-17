# YT-DLP-Download-Script

## Przegląd

Skrypt PowerShell o nazwie **YT-DLP-Download-Script** sprawdza, czy narzędzie `yt-dlp` jest zainstalowane na Twoim systemie, a następnie pobiera wideo oraz związane z nimi dane (napisy, miniatury i metadane) z URL-i zapisanych w pliku tekstowym. Użytkownik może określić plik z linkami oraz folder docelowy. Skrypt pobierze wideo w najwyższej dostępnej jakości, pobierze napisy, osadzi je w wideo, przekonwertuje je do formatu SRT i remuxuje wideo do formatu MP4, jeśli to konieczne.

## Funkcje

- Weryfikuje, czy `yt-dlp` jest zainstalowane i sprawdza dostępność aktualizacji.
- Pobiera wideo, napisy, miniatury i metadane z URL-i zapisanych w pliku tekstowym.
- Automatycznie konwertuje napisy do formatu SRT i osadza je w wideo.
- Remuxuje wideo do formatu MP4, jeśli to konieczne.
- Zapobiega nadpisywaniu plików i zapewnia zgodność z nazwami plików w systemie Windows.
- Umożliwia dostosowanie ścieżek do plików wideo i metadanych.
- Obsługuje pobieranie wideo w różnych formatach i rozdzielczościach.

## Instalacja

1. **Zainstaluj yt-dlp**: Skrypt wymaga, aby `yt-dlp` było zainstalowane na Twoim systemie. Możesz zainstalować je za pomocą poniższego polecenia:

    ```bash
    winget install yt-dlp
    ```

2. **Pobierz Skrypt**: Pobierz lub sklonuj repozytorium na swój system.

3. **Uruchom Skrypt**: Otwórz PowerShell i uruchom skrypt za pomocą poniższego polecenia:

    ```powershell
    C:\Ścieżka\Do\YT-DLP-Download-Script.ps1
    ```

## Użycie

Po uruchomieniu skrypt poprosi Cię o podanie:

1. Pełnej ścieżki do pliku tekstowego zawierającego listę URL-i (jeden URL w każdej linii).
2. Ścieżki do folderu, w którym zapisane zostaną pobrane pliki.

Skrypt zacznie pobierać filmy, napisy, miniatury i metadane, zapisując je w wybranym folderze.

### Przykład

Aby pobrać filmy z pliku `links.txt` i zapisać je w folderze `C:\Filmy`, uruchom skrypt w ten sposób:

```powershell
C:\Ścieżka\Do\YT-DLP-Download-Script.ps1
