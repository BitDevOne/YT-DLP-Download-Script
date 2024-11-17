YT-DLP-Download-Script
Przegląd
Skrypt PowerShell o nazwie YT-DLP-Download-Script sprawdza, czy narzędzie yt-dlp jest zainstalowane na Twoim systemie, a następnie pobiera wideo oraz związane z nimi dane (napisy, miniatury i metadane) z URL-i zapisanych w pliku tekstowym. Użytkownik może określić plik z linkami oraz folder docelowy. Skrypt pobierze wideo w najwyższej dostępnej jakości, pobierze napisy, osadzi je w wideo, przekonwertuje je do formatu SRT i remuxuje wideo do formatu MP4, jeśli to konieczne.

Funkcje
Weryfikuje, czy yt-dlp jest zainstalowane i sprawdza dostępność aktualizacji.
Pobiera wideo, napisy, miniatury i metadane z URL-i zapisanych w pliku tekstowym.
Automatycznie konwertuje napisy do formatu SRT i osadza je w wideo.
Remuxuje wideo do formatu MP4, jeśli to konieczne.
Zapobiega nadpisywaniu plików i zapewnia zgodność z nazwami plików w systemie Windows.
Umożliwia dostosowanie ścieżek do plików wideo i metadanych.
Obsługuje pobieranie wideo w różnych formatach i rozdzielczościach.
Instalacja
Zainstaluj yt-dlp: Skrypt wymaga, aby yt-dlp było zainstalowane na Twoim systemie. Możesz zainstalować je za pomocą poniższego polecenia:

bash
Skopiuj kod
winget install yt-dlp
Pobierz Skrypt: Pobierz lub sklonuj repozytorium na swój system.

Uruchom Skrypt: Otwórz PowerShell i uruchom skrypt za pomocą poniższego polecenia:

powershell
Skopiuj kod
C:\Ścieżka\Do\YT-DLP-Download-Script.ps1
Użycie
Po uruchomieniu skrypt poprosi Cię o podanie:

Pełnej ścieżki do pliku tekstowego zawierającego listę URL-i (jeden URL w każdej linii).
Ścieżki do folderu, w którym zapisane zostaną pobrane pliki.
Skrypt zacznie pobierać filmy, napisy, miniatury i metadane, zapisując je w wybranym folderze.

Przykład
Aby pobrać filmy z pliku links.txt i zapisać je w folderze C:\Filmy, uruchom skrypt w ten sposób:

powershell
Skopiuj kod
C:\Ścieżka\Do\YT-DLP-Download-Script.ps1
Skrypt poprosi o podanie ścieżki do pliku z linkami oraz folderu docelowego. Następnie rozpocznie pobieranie wszystkich filmów wskazanych w links.txt.

Szczegóły Skryptu
Parametry
Plik Wejściowy: Zwykły plik tekstowy zawierający listę URL-i do pobrania (po jednym URL-u w każdej linii).
Folder Docelowy: Folder, w którym zapisane zostaną pobrane pliki. Jeśli folder nie istnieje, skrypt go utworzy.
Przebieg Działania
Sprawdzanie, czy yt-dlp jest zainstalowane: Skrypt sprawdza, czy narzędzie yt-dlp jest zainstalowane. Jeśli nie, wyświetli komunikat o błędzie i zakończy działanie.
Sprawdzanie dostępności aktualizacji: Skrypt sprawdza, czy dostępna jest nowsza wersja yt-dlp i informuje użytkownika, jeśli aktualizacja jest dostępna.
Pobieranie URL-i: Skrypt odczytuje linki z pliku tekstowego i pobiera wideo oraz związane z nim dane (napisy, miniatury, metadane).
