# Movie Recommend App

A Flutter : Movie Recommend Application, with Deterministic-Finite-Automaton (DFA) liked algorithm.

This project is for AUT COMP711 : Theory of Computation assignment (mini project)


Submit_video : [Google drive video](https://drive.google.com/file/d/1HRav16wVc4T8cbZrc_H7XpSO3HKuO0bB/view?usp=share_link)

Video_slides : [Google Docs](https://drive.google.com/file/d/1ZOtxPDKBYV4fWmzpituyQfgtYhfN-Z6_/view?usp=share_link)

<br/>

## Tech-stack used :
* Flutter : for frontend client app
  * Navigator 2.0 : together with customed providers for state management.
* TMDB : TMDB API to get movie datas

<br/>

## To Run App


### 1. Set up TMDB API key for the app
a. Go into folder `lib/constants/`.
b. Inside this folder create `constants.dart` file, to store TMDB Api key and other constant values.
   * NOTE : watch `constants.example.dart` as example.
   * The `constants.dart` should look like this :
   
   ```
   class Constants {
    static const String BASE_URL = "https://api.themoviedb.org/3";
    static const String TMDB_API_KEY = "place_your_tmdb_api_key_here";

    static const String API_KEY_QUERY = "api_key=${TMDB_API_KEY}";

    static const String IMG_BASE_URL = "https://image.tmdb.org/t/p";
    }
   ```
   
c. Store your TMDB Api key inside `TMDB_API_KEY` variable.
   
   
### 2. Run the app
In the root folder, run the app with this below command :
```
flutter run
```

Or run from editor, run on specific devices, or etc...
