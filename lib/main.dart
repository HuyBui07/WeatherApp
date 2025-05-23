// Flutter imports
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Firebase imports
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Components
import 'components/email_form.dart';
import 'components/future_weather.dart';
import 'components/header.dart';
import 'components/search_form.dart';
import 'components/today_weather.dart';

// Models
import 'models/weather_model.dart';

// Services
import 'services/weather_history_service.dart';
import 'services/weather_service.dart';

// Theme
import 'theme/app_colors.dart';
import 'theme/app_theme.dart';

// Utils
import 'utils/text_scale.dart';
import 'utils/validate_city.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await WeatherHistoryService().init();
  runApp(
    const MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        scrollbars: false,
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
        },
      ),
      home: const WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  // Form
  final _formKey = GlobalKey<FormState>();
  final _cityController = TextEditingController();

  // Weather data
  final _weatherService = WeatherService();
  WeatherModel? _todayWeather;
  List<WeatherModel>? _forecastWeather;

  // Scroll
  final _scrollController = ScrollController();
  bool _isLoading = false;
  bool _isLoadingMore = false;

  // Error
  String? _error;

  // Pagination
  int _currentPage = 0;
  bool _hasMore = true;

  // History
  Map<String, dynamic>? _weatherHistory;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadWeatherHistory();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _loadWeatherHistory() async {
    _weatherHistory = await WeatherHistoryService().getWeatherHistory();
    if (_weatherHistory != null) {
      _cityController.text = _weatherHistory!['current']['cityName'];
      setState(() {
        _todayWeather = WeatherModel.fromJson(_weatherHistory!['current'],
            _weatherHistory!['current']['cityName']);
        List<WeatherModel> forecastList = [];
        for (var e in _weatherHistory!['forecast']) {
          forecastList.add(WeatherModel.fromJson(e, e['cityName']));
        }
        _forecastWeather = forecastList;
      });
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      _loadMoreData();
    }
  }

  Future<void> _loadMoreData() async {
    if (_isLoadingMore || !_hasMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    try {
      final newData = await _weatherService.getWeathers(
        _cityController.text,
        page: _currentPage + 1,
      );

      setState(() {
        _forecastWeather = [...?_forecastWeather, ...newData['forecast']];
        _hasMore = newData['hasMore'];
        _currentPage++;
        _isLoadingMore = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoadingMore = false;
      });
    }
  }

  Future<void> _handleSearch() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _error = null;
        _currentPage = 0;
        _hasMore = true;
      });

      try {
        final weathers = await _weatherService.getWeathers(
          _cityController.text,
          page: 0,
        );

        setState(() {
          _todayWeather = weathers['current'];
          _forecastWeather = weathers['forecast'];
          WeatherHistoryService().saveWeatherHistory(
            _todayWeather!,
            _forecastWeather!,
          );
          _hasMore = weathers['hasMore'];
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildForecastList() {
    if (_forecastWeather == null) return const SizedBox.shrink();

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      itemCount: _forecastWeather!.length + (_isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _forecastWeather!.length) {
          return const SizedBox(
            height: 100,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        final weather = _forecastWeather![index];
        return FittedBox(
          child: FutureWeather(
            cityName: weather.cityName,
            date: weather.lastUpdated,
            temperature: weather.temperature,
            windSpeed: weather.windSpeed,
            humidity: weather.humidity.toDouble(),
            condition: weather.condition,
            icon: weather.icon,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Header(),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _error!,
                  style: TextStyle(color: Colors.red[300]),
                ),
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: MediaQuery.of(context).size.width < 600
                    ? _buildMobileLayout()
                    : _buildDesktopLayout(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: SearchForm(
              cityController: _cityController,
              formKey: _formKey,
              isLoading: _isLoading,
              onSearch: _handleSearch,
              validator: validateCity,
            ),
          ),
          const SizedBox(height: 24),
          if (_todayWeather != null) ...[
            TodayWeather(
              cityName: _todayWeather!.cityName,
              date: _todayWeather!.lastUpdated,
              temperature: _todayWeather!.temperature,
              windSpeed: _todayWeather!.windSpeed,
              humidity: _todayWeather!.humidity.toDouble(),
              condition: _todayWeather!.condition,
              icon: _todayWeather!.icon,
            ),
            const SizedBox(height: 24),
            const Text(
              'Forecast',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 400,
              child: _buildForecastList(),
            ),
          ] else
            const Center(
              child: Text('No city selected'),
            ),
          const SizedBox(height: 24),
          Center(
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const EmailForm(),
                );
              },
              splashColor: Colors.transparent,
              child: const Text(
                "Subscribe to get the latest weather updates",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 16,
                  color: AppColors.gray,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: SearchForm(
                cityController: _cityController,
                formKey: _formKey,
                isLoading: _isLoading,
                onSearch: _handleSearch,
                validator: validateCity,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: Center(
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => const EmailForm(),
                    );
                  },
                  splashColor: Colors.transparent,
                  child: const Text(
                    "Subscribe to get the latest weather updates",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                      color: AppColors.gray,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 32),
        if (_todayWeather != null)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TodayWeather(
                  cityName: _todayWeather!.cityName,
                  date: _todayWeather!.lastUpdated,
                  temperature: _todayWeather!.temperature,
                  windSpeed: _todayWeather!.windSpeed,
                  humidity: _todayWeather!.humidity.toDouble(),
                  condition: _todayWeather!.condition,
                  icon: _todayWeather!.icon,
                ),
                SizedBox(height: 40 * ScaleSize.sizeScaleFactor(context)),
                Text(
                  'Forecast',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  textScaler:
                      TextScaler.linear(ScaleSize.sizeScaleFactor(context)),
                ),
                SizedBox(height: 28 * ScaleSize.sizeScaleFactor(context)),
                Expanded(
                  child: _buildForecastList(),
                ),
              ],
            ),
          )
        else
          const Expanded(
            child: Center(
              child: Text('No city selected'),
            ),
          ),
      ],
    );
  }
}
