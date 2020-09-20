#
#Country lists
#

#Western Europe
$countryList1 = @("France","Germany","Italia", "Belgium", "United Kingdom", "Holland", "Spain", "Portugal", "Switzerland", "luxembourg")
$i1 = Get-Random -Maximum $countryList1.Count
#Eastern Europe
$countryList2 = @("Russia", "Austria", "Czechia", "Poland", "Slovakia", "Hungary", "Croatia", "slovenia", "Bosnia", "Montenegro", "Serbia", "Kosovo", "Albania", "Macedonia", "Bulgaria", "Greece", "Romania", "Moldova", "Ukraine", "Belarus")
$i2 = Get-Random -Maximum $countryList3.Count
#Northern Europe
$countryList3 = @("Denmark", "Norway", "Iceland", "Sweden", "Finland", "Estonia", "Latvia", "Lithuania")
$i3 = Get-Random -Maximum $countryList3.Count
#America
$countryList4 = @("Canada", "United States", "Mexico", "Guatemala", "Honduras", "El salvador", "Cuba", "Bahamas", "Jamaica", "Venezuela", "Colombia", "Suriname", "Equator", "Peru", "Bolivia", "Brasil", "Chile",  "Paraguay", "Uruguay", "Argentina")
$i4 = Get-Random -Maximum $countryList4.Count
#Asia
$countryList5 = @("India", "Nepal", "Bhoutan", "Bangladesh", "Burma", "Thailand", "Vietnam", "Cambodia", "Philippines", "Malaisia", "China", "Indonesia", "North korea", "south korea", "Japon", "Mongolia")
$i5 = Get-Random -Maximum $countryList5.Count
#Midle East
$countryList6 = @("Kazakhstan", "Ouzbékistan", "Kirghizistan", "Turkménistan", "Afghanistan", "Tadjikistan", "Pakistan", "Iran", "Irak", "Syria", "Turkey", "Saudi Arabia", "Yémen", "Oman", "Jordania")
$i6 = Get-Random -Maximum $countryList6.Count
#Africa   add : Guinée, cote d'ivoire, republique centrafricaine
$countryList7 = @("Marroco", "Algeria", "Tunisia", "Libia", "Egypt", "Mauritania", "Mali", "Niger", "Tchad", "Soudan", "Senegal", "Guinea", "Sierra leone", "liberia", "Gambie", "Ghana", "Togo", "Benin", "Nigeria", "Cameroun", "Ethiopia", "Erythree", "Djibouti", "Somalia", "Kenya", "Ouganda", "Rwanda", "Burundi", "Tanzanie", "Gabon", "Congo", "Tanzania", "Angola", "Zambia", "Zimbabwe", "Mozambique", "Namibia", "Botswana", "Madagascar", "Eswatini", "Lesotho", "South Africa")
$i7 = Get-Random -Maximum $countryList7.Count
#Oceania
$countryList8 = @("Austalia", "New zealand")
$i8 = Get-Random -Maximum $countryList8.Count


#
#Player Choices
#

#What game
$gamenbr = Read-Host "What do you wanna play?`n1.Guess the Size`n2.Guess the number of people`n3.Guess the capital`n"
#What list to play with
$listnbr = Read-Host "What countries do you want to play with ?`n1.Western Europe`n2.Eastern Europe`n3.NorthernEurope`n4.America`n5.Asia`n6.Midle East`n7.Africa`n8.Oceania"

#Determine the country to play with
switch ($listnbr){
    1{$countryName = $countryList1[$i1]}
    2{$countryName = $countryList2[$i2]}
    3{$countryName = $countryList3[$i3]}
    4{$countryName = $countryList4[$i4]}
    5{$countryName = $countryList5[$i5]}
    6{$countryName = $countryList6[$i6]}
    7{$countryName = $countryList7[$i7]}
    8{$countryName = $countryList8[$i8]}
}
$tolerateDiff_SIZE = @(50000, 50000, 80000, 50000, 100000, 50000, 50000, 50000) 
$tolerateDiff_POPU = (2000000, 3000000, 2000000, 5000000, 10000000, 5000000, 5000000, 5000000)



#
#Game Start
#

$countryURL = "https://restcountries.eu/rest/v2/name/" + $countryName
$getCountry = Invoke-RestMethod $countryURL

switch ($gamenbr){
    1{#Size Game
        $countrySize = $getCountry.area 
        #Player's Answer
        $answer = Read-Host "What the size of $countryName ? (~"$tolerateDiff_SIZE[$listnbr-1] "km²)"
        $ansLess = $countrySize - $tolerateDiff_SIZE[$listnbr-1]
        $ansMore = $countrySize + $tolerateDiff_SIZE[$listnbr-1]
        #Result
        if ($answer -in $ansLess..$ansMore) {
           $getChuck = Invoke-RestMethod "https://api.chucknorris.io/jokes/random"
           $reward = $getChuck.value
           Write-Host "Well played !  Here a Chuck Norris fact for you :`n$reward"
        } else {
            Write-host "Wrong ! $country is $countrySize km²"
        }
    }
    
    2{#Nbr of people Game
        $howmanypeople = $getCountry.population
        #Player's Answer
        $answer = Read-Host "How many people live in $countryName ? (~"$tolerateDiff_POPU[$listnbr-1]")"
        $ansLess = $howmanypeople - $tolerateDiff_POPU[$listnbr-1]
        $ansLess = $howmanypeople + $tolerateDiff_POPU[$listnbr-1]
        #Result
        if ($answer -in $ansLess..$ansMore) {
           $getChuck = Invoke-RestMethod "https://api.chucknorris.io/jokes/random"
           $reward = $getChuck.value
           Write-Host "Well played !  Here a Chuck Norris fact for you :`n$reward"
        } else {
            Write-host "Wrong ! there is $howmanypeople in $countryName"
        }

    }
    
    3{#Capital Game
        $capital = $getCountry.capital 
        #Player's Answer
        $answer = Read-Host "Whats the capital of $countryName ?"
        #Result
        if ($answer -match $capital) {
           $getChuck = Invoke-RestMethod "https://api.chucknorris.io/jokes/random"
           $reward = $getChuck.value
           Write-Host "Well played !  Here a Chuck Norris fact for you :`n$reward"
        } else {
            Write-host "Wrong ! the capital of $countryName is $capital"
        }
    }
}