import 'package:desafio_webadapte/src/ui/core/themes/app_colors.dart';
import 'package:desafio_webadapte/src/ui/core/themes/app_text_styles.dart';
import 'package:desafio_webadapte/src/ui/core/widgets/custom_circular_progress_indicator.dart';
import 'package:desafio_webadapte/src/ui/home/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayerForm extends StatefulWidget {
  final HomeViewModel viewModel;

  const PlayerForm({super.key, required this.viewModel});

  @override
  State<PlayerForm> createState() => _PlayerFormState();
}

class _PlayerFormState extends State<PlayerForm> {
  final _formKey = GlobalKey<FormState>();
  final _dropdownGamesLabels = [
    'League of Legends',
    'Apex Legends',
    'Counter Strike',
    'World of Warcraft',
    'Dota 2',
    'Fortnite',
  ];
  final _availabilityDaysLabels = ['S', 'T', 'Q', 'Q', 'S'];
  final _selectedAvailabilityDays = List.filled(5, false);
  final _nameController = TextEditingController();
  final _discordController = TextEditingController();
  final _yearsGameTimeController = TextEditingController();
  final _startHoursController = TextEditingController();
  final _endHoursController = TextEditingController();

  final playerFormLabelStyle = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 2.6,
    color: AppColors.zinc500,
  );

  final fieldErrorStyle = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1,
    color: AppColors.red400,
  );

  bool _canAudioCall = false;
  String? _gameSelected;
  String? _availabilityDaysFieldError;

  void createPlayerAd() {
    final daysValidationReturn = widget.viewModel.validateDaysAvailability(
      _selectedAvailabilityDays,
    );

    setState(() {
      _availabilityDaysFieldError = daysValidationReturn;
    });

    final isFormValid =
        _formKey.currentState!.validate() && daysValidationReturn == null;

    if (isFormValid) {
      widget.viewModel.createGameAd(
        gameName: _gameSelected!,
        playerName: _nameController.text,
        yearsGameTime: _yearsGameTimeController.text,
        discordUsername: _discordController.text,
        daysAvailability:
            _selectedAvailabilityDays.where((value) => value).toList().length,
        startHoursAvailability: _startHoursController.text,
        endHoursAvailability: _endHoursController.text,
        canAudioCall: _canAudioCall,
      );
    }
  }

  Text createFieldLabel({required String labelText}) {
    return Text(labelText, style: TabletTextStyles.strongBodySmall);
  }

  TextFormField createTextFormField({
    required String hintText,
    required bool isNumericInput,
    required TextEditingController controller,
    required String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: isNumericInput ? TextInputType.number : TextInputType.text,
      inputFormatters:
          isNumericInput
              ? [FilteringTextInputFormatter.digitsOnly]
              : List.empty(),
      style: playerFormLabelStyle.copyWith(color: AppColors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: playerFormLabelStyle,
        errorStyle: fieldErrorStyle,
        isDense: true,
        errorMaxLines: 2,
        filled: true,
        fillColor: AppColors.zinc900,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Column createFormTextSection({
    required String labelText,
    required String hintText,
    required bool isNumericInput,
    required TextEditingController controller,
    required String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        createFieldLabel(labelText: labelText),
        const SizedBox(height: 5),
        createTextFormField(
          hintText: hintText,
          isNumericInput: isNumericInput,
          controller: controller,
          validator: validator,
        ),
      ],
    );
  }

  Column createGamesDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        createFieldLabel(labelText: 'Qual o game?'),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          value: _gameSelected,
          validator: widget.viewModel.validateGameSected,
          icon: SizedBox(
            width: 24,
            height: 24,
            child: Image.asset('assets/icons/caret_down.png'),
          ),
          hint: Text(
            'Selecione o game que deseja jogar',
            style: playerFormLabelStyle.copyWith(height: 1.2),
          ),
          padding: EdgeInsets.symmetric(vertical: 10),
          dropdownColor: AppColors.zinc900,
          decoration: InputDecoration(
            filled: true,
            isDense: true,
            fillColor: AppColors.zinc900,
            errorStyle: fieldErrorStyle,
            errorMaxLines: 2,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onChanged: (value) => setState(() => _gameSelected = value),
          items:
              _dropdownGamesLabels.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(
                    option,
                    style: playerFormLabelStyle.copyWith(
                      color: AppColors.white,
                      height: 1.2,
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }

  Column createAvailabilityDaysFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        createFieldLabel(labelText: 'Quando costuma jogar?'),
        const SizedBox(height: 5),
        Row(
          spacing: 5,
          children:
              _availabilityDaysLabels.asMap().entries.map((entry) {
                return createAvailabilityDayField(
                  index: entry.key,
                  dayLabel: entry.value,
                );
              }).toList(),
        ),
        if (_availabilityDaysFieldError != null &&
            !_selectedAvailabilityDays.contains(true)) ...[
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(_availabilityDaysFieldError!, style: fieldErrorStyle),
          ),
        ],
      ],
    );
  }

  GestureDetector createAvailabilityDayField({
    required int index,
    required String dayLabel,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAvailabilityDays[index] = !_selectedAvailabilityDays[index];
        });
      },
      child: AnimatedContainer(
        width: 40,
        height: 40,
        duration: Duration(milliseconds: 500),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:
              _selectedAvailabilityDays[index]
                  ? AppColors.violet500
                  : AppColors.zinc900,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(dayLabel, style: PhoneTextStyles.headlineSmall),
      ),
    );
  }

  Column createAvailabilityHoursFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        createFieldLabel(labelText: 'Qual horário do dia?'),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Expanded(
              child: createTextFormField(
                hintText: 'De',
                isNumericInput: true,
                controller: _startHoursController,
                validator: widget.viewModel.validateHourAvailability,
              ),
            ),
            Expanded(
              child: createTextFormField(
                hintText: 'Até',
                isNumericInput: true,
                controller: _endHoursController,
                validator: widget.viewModel.validateHourAvailability,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row createCanAudioCallCheckbox() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => setState(() => _canAudioCall = !_canAudioCall),
          child: Container(
            width: 24,
            height: 24,
            color: AppColors.zinc900,
            child:
                _canAudioCall
                    ? Icon(
                      Icons.check_rounded,
                      size: 18,
                      color: AppColors.emerald400,
                    )
                    : null,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'Costumo me conectar ao chat de voz',
          style: playerFormLabelStyle.copyWith(color: AppColors.white),
        ),
      ],
    );
  }

  Row createFormButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            backgroundColor: AppColors.zinc500,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Text('Cancelar', style: TabletTextStyles.strongBodySmall),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: createPlayerAd,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            backgroundColor: AppColors.violet500,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Image.asset('assets/icons/game_controller.png'),
              ),
              const SizedBox(width: 10),
              Text('Encontrar duo', style: TabletTextStyles.strongBodySmall),
            ],
          ),
        ),
      ],
    );
  }

  void viewModelListener() {
    setState(() {});
    if (widget.viewModel.isPlayerAdCreated) {
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    widget.viewModel.addListener(viewModelListener);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 32, horizontal: 40),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Publique um anúncio',
                  style: TabletTextStyles.strongHeadlineSmall,
                ),
                const SizedBox(height: 20),
                createGamesDropdown(),
                const SizedBox(height: 20),
                createFormTextSection(
                  labelText: 'Seu nome (ou nickname)',
                  hintText: 'Como te chamam dentro do game?',
                  isNumericInput: false,
                  controller: _nameController,
                  validator: widget.viewModel.validateName,
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 20,
                  children: [
                    Expanded(
                      flex: 1,
                      child: createFormTextSection(
                        labelText: 'Joga há quantos anos?',
                        hintText: 'Tudo bem ser ZERO',
                        isNumericInput: true,
                        controller: _yearsGameTimeController,
                        validator: widget.viewModel.validateYearsGameTime,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: createFormTextSection(
                        labelText: 'Qual o seu Discord?',
                        hintText: 'Usuario#0000',
                        isNumericInput: false,
                        controller: _discordController,
                        validator: widget.viewModel.validateDiscord,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: createAvailabilityDaysFields()),
                    Expanded(flex: 2, child: createAvailabilityHoursFields()),
                  ],
                ),
                const SizedBox(height: 10),
                createCanAudioCallCheckbox(),
                const SizedBox(height: 20),
                createFormButtons(),
              ],
            ),
          ),
        ),
        if (widget.viewModel.isNewPlayerAdLoading)
          Positioned.fill(
            child: CustomCircularProgressIndicator(opacity: 0.5),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _discordController.dispose();
    _yearsGameTimeController.dispose();
    _startHoursController.dispose();
    _endHoursController.dispose();
    super.dispose();
  }
}
