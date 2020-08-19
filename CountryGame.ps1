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


#
#Player Choices
#

#What game
$gamenbr = Read-Host "What do you wanna play?`n1.Guess the Size`n2.Guess the number of people`n3.Guess the capital`n"
#What list to play with
$listnbr = Read-Host "What countries do you want to play with ?`n1.Western Europe`n2.Eastern Europe`n3.NorthernEurope`n"

#Determine the country to play with
switch ($listnbr){
    1{$countryName = $countryList1[$i1]}
    2{$countryName = $countryList2[$i2]}
    3{$countryName = $countryList3[$i3]}
}
$tolerateDiff_SIZE = @(50000, 50000, 80000) 
$tolerateDiff_POPU = (2000000, 3000000, 2000000)
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
